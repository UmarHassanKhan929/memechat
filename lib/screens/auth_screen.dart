import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassword = '';
  String _userName = '';
  bool _isLogin = true;
  File _image;

  final _auth = FirebaseAuth.instance;

  var _isLoading = false;
  var imageUrl;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext context,
    File image,
  ) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });

      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        setState(() {
          _isLoading = false;
        });
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final fBSref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${authResult.user.uid}.jpg');

        UploadTask uploadTask = fBSref.putFile(image);
        imageUrl = await (await uploadTask).ref.getDownloadURL();
        final storingImgUrl = imageUrl.toString();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
          'username': username,
          'email': email,
          'image_url': storingImgUrl,
        });
        setState(() {
          _isLoading = false;
        });
      }
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$err, check email or password or internet connection'),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_image == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please select an image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    if (isValid) {
      _formKey.currentState.save();
      _submitAuthForm(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          _isLogin, context, _image);
    }
  }

  void _pickImage() async {
    final imagepicker = ImagePicker();
    final imageFile = await imagepicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 150,
      maxWidth: 150,
      imageQuality: 50,
    );
    if (imageFile != null) {
      setState(() {
        _image = File(imageFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _isLogin
                          ? Text('Login Away...')
                          : Column(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage:
                                      _image != null ? FileImage(_image) : null,
                                  backgroundColor: Colors.grey,
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    _pickImage();
                                  },
                                  icon: const Icon(Icons.camera_front_rounded),
                                  label: const Text('Add Your Image'),
                                ),
                              ],
                            ),
                      TextFormField(
                        key: const ValueKey('email'),
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userEmail = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      if (!_isLogin)
                        TextFormField(
                          key: const ValueKey('name'),
                          decoration: const InputDecoration(
                            labelText: 'Username',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _userName = value;
                          },
                        ),
                      TextFormField(
                        key: const ValueKey('password'),
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty || value.length < 8) {
                            return 'Please enter a password 8+ characters long';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userPassword = value;
                        },
                      ),
                      const SizedBox(height: 12),

                      ElevatedButton(
                        onPressed: () {
                          _trySubmit();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_isLoading)
                              const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            if (_isLogin)
                              const Text(
                                ' Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            if (!_isLogin)
                              const Text(
                                ' Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            const SizedBox(width: 8),
                            if (_isLogin)
                              const Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                            if (!_isLogin)
                              const Icon(
                                Icons.person_add,
                                color: Colors.white,
                              ),
                          ],
                        ),
                      ),
                      // Text(
                      //   _isLogin ? 'Sign In' : 'Sign Up',
                      //   style: const TextStyle(color: Colors.white),
                      // ),

                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(
                          _isLogin
                              ? 'Create Account'
                              : 'Have an account? Sign in',
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
