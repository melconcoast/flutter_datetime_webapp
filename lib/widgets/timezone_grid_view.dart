import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import 'clock_widget.dart';
import 'loading_indicator.dart';
import 'error_display.dart';

class TimezoneGridView extends ConsumerWidget {
  const TimezoneGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timezonesState = ref.watch(timezonesProvider);

    if (timezonesState.isLoading) {
      return const LoadingIndicator(message: 'Loading timezones...');
    }

    if (timezonesState.error != null) {
      return ErrorDisplay(
        error: timezonesState.error!,
        onRetry: () => ref.refresh(timezonesProvider),
      );
    }

    if (timezonesState.data!.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.watch_later_outlined,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'No timezones added yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the + button to add a timezone',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: timezonesState.data!.length,
      itemBuilder: (context, index) {
        final timezone = timezonesState.data![index];
        return Stack(
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
                  color: Colors.red.withOpacity(0.8),
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