import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this._message, this._username, this._userImage, this._isMe,
      {this.key, this.createdAt});
  final String _message;
  final String _username;
  final String _userImage;
  final bool _isMe;
  final Key key;
  final Timestamp createdAt;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 200),
              decoration: BoxDecoration(
                color: _isMe
                    ? const Color.fromARGB(255, 197, 139, 139)
                    : const Color.fromARGB(255, 197, 171, 171),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: !_isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                  bottomRight: _isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.only(
                  top: 24, bottom: 1, left: 10, right: 10),
              child: Column(
                crossAxisAlignment:
                    _isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      _username,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _isMe
                            ? Colors.white
                            : Color.fromARGB(255, 75, 52, 44),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    _message,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -4,
          left: _isMe ? MediaQuery.of(context).size.width * 0.89 : 0,
          child: CircleAvatar(
            backgroundImage: NetworkImage(_userImage),
          ),
        ),
      ],
    );
  }
}
