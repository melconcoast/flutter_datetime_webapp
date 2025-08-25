enum TimeFormat { h12, h24 }
enum DateFormat { ddmmyyyy, mmddyyyy, yyyymmdd }
enum TemperatureUnit { celsius, fahrenheit }
enum ViewType { grid, list }

class SettingsModel {
  final bool isDarkMode;
  final TimeFormat timeFormat;
  final DateFormat dateFormat;
  final TemperatureUnit temperatureUnit;
  final ViewType viewType;
  final bool showSeconds;
  final bool showAnalogClock;

  const SettingsModel({
    this.isDarkMode = false,
    this.timeFormat = TimeFormat.h24,
    this.dateFormat = DateFormat.ddmmyyyy,
    this.temperatureUnit = TemperatureUnit.celsius,
    this.viewType = ViewType.grid,
    this.showSeconds = true,
    this.showAnalogClock = false,
  });

  SettingsModel copyWith({
    bool? isDarkMode,
    TimeFormat? timeFormat,
    DateFormat? dateFormat,
    TemperatureUnit? temperatureUnit,
    ViewType? viewType,
    bool? showSeconds,
    bool? showAnalogClock,
  }) {
    return SettingsModel(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      timeFormat: timeFormat ?? this.timeFormat,
      dateFormat: dateFormat ?? this.dateFormat,
      temperatureUnit: temperatureUnit ?? this.temperatureUnit,
      viewType: viewType ?? this.viewType,
      showSeconds: showSeconds ?? this.showSeconds,
      showAnalogClock: showAnalogClock ?? this.showAnalogClock,
    );
  }
}