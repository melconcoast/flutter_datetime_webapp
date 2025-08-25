# Chrome Launch Troubleshooting Guide

## Common Issues and Solutions

### 1. Chrome Not Detected
If Flutter can't detect Chrome:
```bash
# Check if Chrome is installed
ls /Applications/Google\ Chrome.app

# Install Chrome if missing
brew install --cask google-chrome
```

### 2. Flutter Web Support
Ensure web support is enabled:
```bash
# Check if web support is enabled
flutter config --list

# Enable web support
flutter config --enable-web
```

### 3. Project Setup Verification
```bash
# Clean the project
flutter clean

# Get dependencies again
flutter pub get

# Verify device support
flutter devices
```

### 4. Port Issues
If the default port (8080) is in use:
```bash
# Run on a different port
flutter run -d chrome --web-port=8081
```

### 5. Debug Mode
Try running in debug mode explicitly:
```bash
flutter run -d chrome --debug
```