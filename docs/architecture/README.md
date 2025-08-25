# Architecture Documentation

## Project Structure

```
lib/
├── main.dart
├── models/
│   ├── settings_model.dart
│   ├── timezone_model.dart
│   └── async_value_state.dart
├── providers/
│   └── providers.dart
├── services/
│   ├── storage_service.dart
│   └── weather_service.dart
├── theme/
│   └── app_theme.dart
└── widgets/
    ├── clock_widget.dart
    ├── timezone_grid_view.dart
    ├── timezone_list_view.dart
    ├── settings_drawer.dart
    ├── loading_indicator.dart
    └── error_display.dart
```

## State Management

- **Provider**: Flutter Riverpod
- **Key Providers**:
  - `settingsProvider`: Manages application settings
  - `timezonesProvider`: Manages timezone data
  - `storageServiceProvider`: Handles data persistence

## Data Flow

1. User interactions trigger state changes through providers
2. Providers update the UI and persist changes
3. Services handle external interactions (weather, storage)
4. Models define data structures and transformations

## Services

### Storage Service
- Handles data persistence using SharedPreferences
- Manages settings and timezone storage
- Provides error handling and data validation

### Weather Service
- Integrates with OpenWeather API
- Manages weather data fetching and caching
- Handles API errors and rate limiting