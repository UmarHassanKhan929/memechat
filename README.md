# MemeChat 🎭

A real-time chat application built with Flutter and Firebase, featuring media sharing, push notifications, and cross-platform support.

<p float="left">
  <img src="https://user-images.githubusercontent.com/56496945/177550919-70121035-e140-47d3-8570-5687fd6d7f6a.jpeg" width="150" />
  <img src="https://user-images.githubusercontent.com/56496945/177550999-5e0d018e-c612-4a83-943f-982014585e11.jpeg" width="150" /> 
  <img src="https://user-images.githubusercontent.com/56496945/177551015-c2ad1d55-b6af-4331-ad16-9d537e8cd877.jpeg" width="150" />
  <img src="https://user-images.githubusercontent.com/56496945/177551029-51376f99-a827-4199-a827-d5129ff81391.jpeg" width="150" />
  <img src="https://user-images.githubusercontent.com/56496945/177551039-a6243843-7b99-4be6-b347-9dc5796bd4e2.jpeg" width="150" />
  <img src="https://user-images.githubusercontent.com/56496945/177551051-2657c7d2-5120-4bf1-9006-261b68bbde50.jpeg" width="150" />
</p>

## ✨ Features

- 🔐 **Firebase Authentication** - Secure login with email/password
- 💬 **Real-time Messaging** - Instant chat with Firestore
- 📷 **Image Sharing** - Send and receive images via Firebase Storage
- 📱 **Push Notifications** - Stay updated with Firebase Messaging
- 🌐 **Cross-Platform** - Runs on Android, iOS, Web, Windows, macOS, and Linux
- 🎨 **Modern UI** - Clean and intuitive user interface

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=2.11.1)
- Firebase project
- Android Studio / VS Code

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/memechat.git
   cd memechat
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Add an Android/iOS app to your Firebase project
   - Download `google-services.json` (Android) or `GoogleService-Info.plist` (iOS)
   - Place `google-services.json` in `android/app/` directory

4. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Dependencies

| Package | Description |
|---------|-------------|
| `firebase_core` | Core Firebase functionality |
| `firebase_auth` | User authentication |
| `cloud_firestore` | NoSQL cloud database |
| `firebase_storage` | File storage |
| `firebase_messaging` | Push notifications |
| `image_picker` | Image selection from gallery/camera |

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📬 Contact

For questions or feedback, please open an issue on GitHub.

---

<div align="center">
  Made with ❤️ using Flutter and Firebase
</div>
