# Setup Guide

## Development Environment Setup

1. **Flutter SDK Installation**
```bash
# For Mac
brew install flutter
```

2. **Dependencies Installation**
```bash
flutter pub get
```

3. **API Keys Configuration**
Create a new file `.env` in the project root:
```env
OPENWEATHER_API_KEY=your_api_key_here
```

## Running the Application

### Development
```bash
flutter run -d chrome
```

### Production Build
```bash
flutter build web
```

## Testing

### Running Tests
```bash
flutter test
```

### Running Integration Tests
```bash
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart -d chrome
```

## Deployment

### Firebase Hosting
1. Install Firebase CLI
```bash
npm install -g firebase-tools
```

2. Login to Firebase
```bash
firebase login
```

3. Initialize Firebase
```bash
firebase init hosting
```

4. Deploy
```bash
firebase deploy
```

# Troubleshooting Flutter Run for Chrome

## Common Issues

### 1. Flutter SDK Not Installed or Not in PATH
- Ensure that Flutter is installed correctly and added to your system PATH.
- You can check this by running:
  ```bash
  flutter doctor
  ```
- If Flutter is not recognized, follow the installation instructions again.

### 2. Missing Dependencies
- Make sure all dependencies are installed by running:
  ```bash
  flutter pub get
  ```

### 3. Chrome Not Installed
- Ensure that Google Chrome is installed on your machine.
- If you have multiple versions of Chrome, ensure that the correct one is being used.

### 4. Flutter Web Not Enabled
- Make sure that Flutter web support is enabled:
  ```bash
  flutter config --enable-web
  ```

### 5. Caching Issues
- Sometimes, clearing the Flutter cache can resolve issues:
  ```bash
  flutter clean
  ```

### 6. Check for Errors in the Console
- Look for any error messages in the terminal output when running `flutter run -d chrome`. This can provide clues about what might be wrong.

### 7. Update Flutter
- Ensure you are using the latest version of Flutter:
  ```bash
  flutter upgrade
  ```

### 8. Check for Firewall or Antivirus Interference
- Sometimes, firewall or antivirus software can block the connection. Ensure that they are not interfering with Flutter's ability to run the application.

## Additional Resources
- [Flutter Documentation](https://flutter.dev/docs)
- [Flutter GitHub Issues](https://github.com/flutter/flutter/issues)