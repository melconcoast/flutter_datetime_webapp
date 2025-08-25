import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/settings_model.dart';
import '../models/timezone_model.dart';
import '../models/async_value_state.dart';
import '../services/storage_service.dart';

final storageServiceProvider = Provider((ref) => StorageService());

final settingsProvider = StateNotifierProvider<SettingsNotifier, AsyncValueState<SettingsModel>>((ref) {
  return SettingsNotifier(ref.read(storageServiceProvider));
});

class SettingsNotifier extends StateNotifier<AsyncValueState<SettingsModel>> {
  final StorageService _storageService;

  SettingsNotifier(this._storageService) : super(AsyncValueState(data: SettingsModel())) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final settings = await _storageService.loadSettings();
      state = AsyncValueState(data: settings);
    } catch (e) {
      state = AsyncValueState(
        data: state.data,
        error: 'Failed to load settings: ${e.toString()}',
      );
    }
  }

  Future<void> updateSettings(SettingsModel newSettings) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      await _storageService.saveSettings(newSettings);
      state = AsyncValueState(data: newSettings);
    } catch (e) {
      state = AsyncValueState(
        data: state.data,
        error: 'Failed to save settings: ${e.toString()}',
      );
    }
  }
}

final timezonesProvider = StateNotifierProvider<TimezoneNotifier, AsyncValueState<List<TimezoneModel>>>((ref) {
  return TimezoneNotifier(ref.read(storageServiceProvider));
});

class TimezoneNotifier extends StateNotifier<AsyncValueState<List<TimezoneModel>>> {
  final StorageService _storageService;

  TimezoneNotifier(this._storageService) : super(const AsyncValueState(data: [])) {
    _loadTimezones();
  }

  Future<void> _loadTimezones() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      
      final timezones = await _storageService.loadTimezones();
      
      // If no timezones saved, create default with user's detected timezone
      if (timezones.isEmpty) {
        final defaultTimezones = await _createDefaultTimezones();
        await _storageService.saveTimezones(defaultTimezones);
        state = AsyncValueState(data: defaultTimezones);
        return;
      }
      
      state = AsyncValueState(data: timezones);
    } catch (e) {
      state = AsyncValueState(
        data: state.data,
        error: 'Failed to load timezones: ${e.toString()}',
      );
    }
  }
  
  Future<List<TimezoneModel>> _createDefaultTimezones() async {
    final timezones = <TimezoneModel>[];
    
    // Try to detect user's actual timezone first
    final userTimezone = _getTimezoneFromBrowser();
    print('Detected user timezone: $userTimezone');
    
    // ONLY show user's timezone initially (not demo timezones)
    final timezoneNames = [userTimezone];
    
    for (final timezoneName in timezoneNames) {
      try {
        final location = tz.getLocation(timezoneName);
        final now = tz.TZDateTime.now(location);
        
        timezones.add(TimezoneModel(
          name: timezoneName,
          offset: now.timeZoneOffset.toString(),
          dateTime: now,
          isDaytime: now.hour >= 6 && now.hour < 18,
        ));
      } catch (e) {
        // Skip if timezone not found
        continue;
      }
    }
    
    return timezones;
  }
  
  String _getTimezoneFromBrowser() {
    try {
      // Try multiple JavaScript approaches to get timezone
      String? detectedTimezone;
      
      // Method 1: Direct Intl API
      try {
        detectedTimezone = js.context['Intl']['DateTimeFormat'].callMethod('', []).callMethod('resolvedOptions', [])['timeZone'];
      } catch (e) {
        print('Method 1 failed: $e');
      }
      
      // Method 2: Create new DateTimeFormat
      if (detectedTimezone == null || detectedTimezone.isEmpty) {
        try {
          final dtf = js.context['Intl']['DateTimeFormat'].callMethod('', []);
          final options = dtf.callMethod('resolvedOptions', []);
          detectedTimezone = options['timeZone'];
        } catch (e) {
          print('Method 2 failed: $e');
        }
      }
      
      if (detectedTimezone != null && detectedTimezone.isNotEmpty) {
        print('JavaScript detected timezone: $detectedTimezone');
        return detectedTimezone;
      }
    } catch (e) {
      print('All JavaScript timezone detection methods failed: $e');
    }
    
    // Fallback: Use timezone offset with better Mexico/Central America mapping
    try {
      final now = DateTime.now();
      final offset = now.timeZoneOffset.inHours;
      
      // Improved mapping that considers Mexico and Central America
      switch (offset) {
        case -8: return 'America/Los_Angeles';
        case -7: return 'America/Denver';
        case -6: return 'America/Mexico_City'; // Better for Mexico/Central America
        case -5: return 'America/New_York';
        case 0: return 'UTC';
        case 1: return 'Europe/London';
        case 2: return 'Europe/Berlin';
        case 8: return 'Asia/Shanghai';
        case 9: return 'Asia/Tokyo';
        default: return 'UTC';
      }
    } catch (e) {
      return 'UTC';
    }
  }

  Future<void> addTimezone(TimezoneModel timezone) async {
    try {
      if (state.data!.any((element) => element.name == timezone.name)) {
        return;
      }
      state = state.copyWith(isLoading: true, error: null);
      final newTimezones = [...state.data!, timezone];
      await _storageService.saveTimezones(newTimezones);
      state = AsyncValueState(data: newTimezones);
    } catch (e) {
      state = AsyncValueState(
        data: state.data,
        error: 'Failed to add timezone: ${e.toString()}',
      );
    }
  }

  Future<void> removeTimezone(String name) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final newTimezones = state.data!.where((timezone) => timezone.name != name).toList();
      await _storageService.saveTimezones(newTimezones);
      state = AsyncValueState(data: newTimezones);
    } catch (e) {
      state = AsyncValueState(
        data: state.data,
        error: 'Failed to remove timezone: ${e.toString()}',
      );
    }
  }
  
  /// Reset and re-detect user's timezone (for testing/debugging)
  Future<void> resetToUserTimezone() async {
    try {
      // Clear existing timezones
      await _storageService.saveTimezones([]);
      // Reload which will trigger new detection
      await _loadTimezones();
    } catch (e) {
      state = AsyncValueState(
        data: state.data,
        error: 'Failed to reset timezone: ${e.toString()}',
      );
    }
  }
}