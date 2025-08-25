import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/settings_model.dart';
import '../models/timezone_model.dart';

class StorageService {
  static const String _settingsKey = 'app_settings';
  static const String _timezonesKey = 'timezones';

  Future<void> saveSettings(SettingsModel settings) async {
    final prefs = await SharedPreferences.getInstance();
    final settingsJson = {
      'isDarkMode': settings.isDarkMode,
      'timeFormat': settings.timeFormat.index,
      'dateFormat': settings.dateFormat.index,
      'temperatureUnit': settings.temperatureUnit.index,
      'viewType': settings.viewType.index,
      'showSeconds': settings.showSeconds,
      'showAnalogClock': settings.showAnalogClock,
    };
    await prefs.setString(_settingsKey, jsonEncode(settingsJson));
  }

  Future<SettingsModel> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsString = prefs.getString(_settingsKey);
    if (settingsString == null) return SettingsModel();

    final settingsJson = jsonDecode(settingsString) as Map<String, dynamic>;
    return SettingsModel(
      isDarkMode: settingsJson['isDarkMode'] as bool,
      timeFormat: TimeFormat.values[settingsJson['timeFormat'] as int],
      dateFormat: DateFormat.values[settingsJson['dateFormat'] as int],
      temperatureUnit: TemperatureUnit.values[settingsJson['temperatureUnit'] as int],
      viewType: ViewType.values[settingsJson['viewType'] as int],
      showSeconds: settingsJson['showSeconds'] as bool,
      showAnalogClock: settingsJson['showAnalogClock'] as bool,
    );
  }

  Future<void> saveTimezones(List<TimezoneModel> timezones) async {
    final prefs = await SharedPreferences.getInstance();
    final timezonesJson = timezones.map((tz) => tz.toJson()).toList();
    await prefs.setString(_timezonesKey, jsonEncode(timezonesJson));
  }

  Future<List<TimezoneModel>> loadTimezones() async {
    final prefs = await SharedPreferences.getInstance();
    final timezonesString = prefs.getString(_timezonesKey);
    if (timezonesString == null) return [];

    final timezonesJson = jsonDecode(timezonesString) as List;
    return timezonesJson
        .map((json) => TimezoneModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}