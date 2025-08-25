import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/settings_model.dart';
import '../providers/providers.dart';
import 'loading_indicator.dart';
import 'error_display.dart';

class SettingsDrawer extends ConsumerStatefulWidget {
  const SettingsDrawer({super.key});

  @override
  ConsumerState<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends ConsumerState<SettingsDrawer> {
  bool _isSaving = false;

  Future<void> _updateSettings(SettingsModel settings, SettingsModel newSettings) async {
    if (_isSaving) return;

    setState(() => _isSaving = true);
    
    try {
      await ref.read(settingsProvider.notifier).updateSettings(newSettings);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Settings updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update settings: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsProvider);
    final theme = Theme.of(context);

    if (settingsState.isLoading || _isSaving) {
      return const Drawer(
        child: LoadingIndicator(message: 'Loading settings...'),
      );
    }

    if (settingsState.error != null) {
      return Drawer(
        child: ErrorDisplay(
          error: settingsState.error!,
          onRetry: () => ref.refresh(settingsProvider),
        ),
      );
    }

    final settings = settingsState.data!;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    'Settings',
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Customize your timezone display',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  Card(
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text('Dark Mode'),
                          subtitle: const Text('Toggle dark/light theme'),
                          value: settings.isDarkMode,
                          onChanged: (value) => _updateSettings(
                            settings,
                            settings.copyWith(isDarkMode: value),
                          ),
                        ),
                        const Divider(),
                        SwitchListTile(
                          title: const Text('Show Analog Clock'),
                          subtitle: const Text('Display analog clock face'),
                          value: settings.showAnalogClock,
                          onChanged: (value) => _updateSettings(
                            settings,
                            settings.copyWith(showAnalogClock: value),
                          ),
                        ),
                        const Divider(),
                        SwitchListTile(
                          title: const Text('Show Seconds'),
                          subtitle: const Text('Display seconds in digital time'),
                          value: settings.showSeconds,
                          onChanged: (value) => _updateSettings(
                            settings,
                            settings.copyWith(showSeconds: value),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Column(
                      children: [
                        _buildFormatTile(
                          title: 'Time Format',
                          subtitle: 'Choose 12 or 24-hour format',
                          value: settings.timeFormat,
                          items: TimeFormat.values,
                          getLabel: (format) => 
                              format == TimeFormat.h12 ? '12-hour' : '24-hour',
                          onChanged: (value) => _updateSettings(
                            settings,
                            settings.copyWith(timeFormat: value),
                          ),
                        ),
                        const Divider(),
                        _buildFormatTile(
                          title: 'Date Format',
                          subtitle: 'Select date display format',
                          value: settings.dateFormat,
                          items: DateFormat.values,
                          getLabel: _getDateFormatLabel,
                          onChanged: (value) => _updateSettings(
                            settings,
                            settings.copyWith(dateFormat: value),
                          ),
                        ),
                        const Divider(),
                        _buildFormatTile(
                          title: 'Temperature Unit',
                          subtitle: 'Choose temperature display unit',
                          value: settings.temperatureUnit,
                          items: TemperatureUnit.values,
                          getLabel: (unit) => 
                              unit == TemperatureUnit.celsius ? '°C' : '°F',
                          onChanged: (value) => _updateSettings(
                            settings,
                            settings.copyWith(temperatureUnit: value),
                          ),
                        ),
                        const Divider(),
                        _buildFormatTile(
                          title: 'View Type',
                          subtitle: 'Choose grid or list layout',
                          value: settings.viewType,
                          items: ViewType.values,
                          getLabel: (viewType) => 
                              viewType == ViewType.grid ? 'Grid' : 'List',
                          onChanged: (value) => _updateSettings(
                            settings,
                            settings.copyWith(viewType: value),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.check),
                label: const Text('Done'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormatTile<T>({
    required String title,
    required String subtitle,
    required T value,
    required List<T> items,
    required String Function(T) getLabel,
    required ValueChanged<T?> onChanged,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: DropdownButton<T>(
        value: value,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(getLabel(item)),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  String _getDateFormatLabel(DateFormat format) {
    switch (format) {
      case DateFormat.ddmmyyyy:
        return 'DD/MM/YYYY';
      case DateFormat.mmddyyyy:
        return 'MM/DD/YYYY';
      case DateFormat.yyyymmdd:
        return 'YYYY-MM-DD';
    }
  }
}