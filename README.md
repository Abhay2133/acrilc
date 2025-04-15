# Acrilc

Acrilc is a Flutter-based application that allows artists to showcase their artwork, and users to explore and support their creations.

---

## 🌐 Web Preview

[🔗 Click here to view the web preview](https://abhay2133.github.io/acrilc)

## 📱 Download APK

[📦 Download the APK for Android](https://abhay2133.github.io/acrilc/Acrilc.apk)

---

## 🛠️ Local Development Setup

Follow these steps to run the project locally:

### ✅ Prerequisites

- [x] Flutter SDK installed ([Install Guide](https://docs.flutter.dev/get-started/install))
- [x] Android Studio or compatible IDE
- [x] Git installed

### 🧰 Steps to Setup

- [ ] **Clone the Repository**

```bash
git clone https://github.com/abhay2133/acrilc.git
cd acrilc
```

- [ ] **Install Dependencies**

```bash
flutter pub get
```

- [ ] **Set Up Environment Variables**

Rename the example file and modify as needed for your local environment:

```bash
cp prod.env.example prod.env
```

Edit `prod.env` and fill in the necessary variables for local development.

> 💡 This project may use [`flutter_dotenv`](https://pub.dev/packages/flutter_dotenv) for loading environment variables. Ensure the file is loaded in `main.dart`:

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "prod.env");
  runApp(MyApp());
}
```

- [ ] **Run the App**

To run on a connected device or emulator:

```bash
flutter run
```

---

## 📦 Build APK for Testing

You can export an APK for distribution or manual testing.

- [ ] **Debug APK**

```bash
flutter build apk --debug
```

- [ ] **Release APK**

```bash
flutter build apk --release
```

The APK will be generated at:

```
build/app/outputs/flutter-apk/app-release.apk
```

You can share or install this file on an Android device.

---

## 📂 Project Structure (Optional Overview)

```plaintext
lib/
├── main.dart          # App entry point
├── screens/           # UI Screens
├── widgets/           # Reusable Widgets
├── services/          # API and backend interaction
├── models/            # Data Models
└── ...
```

---

## 📄 License

MIT License. See [LICENSE](LICENSE) for more information.
