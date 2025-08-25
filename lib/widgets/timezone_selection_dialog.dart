import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;
import '../models/timezone_model.dart';
import '../providers/providers.dart';

class TimezoneSelectionDialog extends ConsumerStatefulWidget {
  const TimezoneSelectionDialog({super.key});

  @override
  ConsumerState<TimezoneSelectionDialog> createState() => _TimezoneSelectionDialogState();
}

class _TimezoneSelectionDialogState extends ConsumerState<TimezoneSelectionDialog> {
  String? _searchQuery;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<String> _getFilteredTimezones() {
    final allTimezones = tz.timeZoneDatabase.locations.keys.toList()
      ..sort((a, b) => a.compareTo(b));

    if (_searchQuery?.isEmpty ?? true) {
      return allTimezones;
    }

    return allTimezones
        .where((timezone) =>
            timezone.toLowerCase().contains(_searchQuery!.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Timezone',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _getFilteredTimezones().length,
                itemBuilder: (context, index) {
                  final timezoneName = _getFilteredTimezones()[index];
                  final location = tz.getLocation(timezoneName);
                  final now = tz.TZDateTime.now(location);
                  
                  return ListTile(
                    title: Text(timezoneName),
                    subtitle: Text(now.toString()),
                    onTap: () {
                      ref.read(timezonesProvider.notifier).addTimezone(
                            TimezoneModel(
                              name: timezoneName,
                              offset: location.currentTimeZone.abbreviation,
                              dateTime: now,
                              isDaytime: now.hour >= 6 && now.hour < 18,
                            ),
                          );
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}