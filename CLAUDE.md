# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Running the Application
```bash
flutter run -d chrome          # Run in web browser
flutter run -d macos           # Run on macOS
flutter run -d ios             # Run iOS simulator
```

### Testing and Analysis
```bash
flutter test                   # Run unit and widget tests
flutter analyze                # Run static analysis with linter
flutter doctor                 # Check Flutter environment
```

### Build Commands
```bash
flutter build web              # Build for web deployment
flutter clean                  # Clean build artifacts
flutter pub get                # Install dependencies
```

## Architecture Overview

This is a Flutter web application for timezone management with weather integration, built using:

### State Management
- **Riverpod**: Primary state management solution
- **Key Providers**:
  - `settingsProvider`: App configuration (theme, formats, layout)
  - `timezonesProvider`: Timezone data management
  - `storageServiceProvider`: Persistent storage operations

### Core Architecture Patterns
- **MVVM-style separation**: Models, providers (view models), widgets (views)
- **Service layer**: External API interactions and data persistence
- **Custom AsyncValueState**: Enhanced state management wrapper for loading/error states

### Project Structure
```
lib/
├── main.dart              # App entry point with ProviderScope
├── models/                # Data models and state classes
├── providers/             # Riverpod state notifiers
├── services/              # External service integrations
│   ├── storage_service.dart    # SharedPreferences wrapper
│   └── weather_service.dart    # OpenWeather API client
├── theme/                 # FlexColorScheme theming
├── screens/               # Main application screens
└── widgets/               # Reusable UI components
```

### Key Components
- **Clock Widget**: Displays analog/digital clocks with weather data
- **Settings Drawer**: Theme, format, and layout configuration
- **Timezone Management**: Add/remove timezones with search functionality
- **Responsive Layouts**: Grid view (desktop) and list view (mobile)

### Dependencies
- `flutter_riverpod`: State management
- `timezone`: Timezone calculations
- `weather`: OpenWeather API integration
- `shared_preferences`: Local data persistence
- `flex_color_scheme`: Advanced theming
- `google_fonts`: Typography
- `intl`: Internationalization and formatting

## Development Notes

### Weather API Setup
The application integrates with OpenWeather API. Configure API key in environment variables or update `weather_service.dart` directly.

### State Management Pattern
All state mutations go through StateNotifier classes in `providers.dart`. Direct state updates bypass the error handling and persistence layers.

### Testing
Widget tests are in `test/widget_test.dart`. Run `flutter test` to execute all tests.