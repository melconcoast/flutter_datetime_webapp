import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import 'clock_widget.dart';

class TimezoneListView extends ConsumerWidget {
  const TimezoneListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timezonesState = ref.watch(timezonesProvider);
    final timezones = timezonesState.data ?? [];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: timezones.length,
      itemBuilder: (context, index) {
        final timezone = timezones[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Stack(
            children: [
              ClockWidget(
                timezone: timezone.name,
                dateTime: timezone.dateTime,
                isDaytime: timezone.isDaytime,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 16),
                    iconSize: 16,
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(
                      minWidth: 24,
                      minHeight: 24,
                    ),
                    onPressed: () => _removeTimezone(context, ref, timezone.name),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _removeTimezone(BuildContext context, WidgetRef ref, String timezoneName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Timezone'),
        content: Text('Remove $timezoneName from your timezone list?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(timezonesProvider.notifier).removeTimezone(timezoneName);
              Navigator.of(context).pop();
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}