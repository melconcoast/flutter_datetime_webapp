import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:intl/intl.dart' as intl;
import 'package:weather/weather.dart';
import 'package:timezone/timezone.dart' as tz;
import '../models/settings_model.dart';
import '../providers/providers.dart';
import '../services/weather_service.dart';

class ClockWidget extends ConsumerStatefulWidget {
  final String timezone;
  final DateTime dateTime;
  final bool isDaytime;

  const ClockWidget({
    super.key,
    required this.timezone,
    required this.dateTime,
    required this.isDaytime,
  });

  @override
  ConsumerState<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends ConsumerState<ClockWidget> {
  late DateTime _currentTime;
  late Timer _timer;
  Weather? _weather;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _updateCurrentTime();
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTime);
    _fetchWeather();
  }

  void _updateCurrentTime() {
    try {
      final location = tz.getLocation(widget.timezone);
      _currentTime = tz.TZDateTime.now(location);
    } catch (e) {
      // Fallback to system time if timezone not found
      _currentTime = DateTime.now();
    }
  }

  Future<void> _fetchWeather() async {
    try {
      final weatherService = ref.read(weatherServiceProvider);
      final weather = await weatherService.getWeatherForCity(_extractCityName(widget.timezone));
      if (mounted) {
        setState(() => _weather = weather);
      }
    } catch (e) {
      // Weather fetch failed, continue without weather
      if (mounted) {
        setState(() => _weather = null);
      }
    }
  }

  String _extractCityName(String timezone) {
    // Extract city name from timezone (e.g., "America/New_York" -> "New York")
    if (timezone.contains('/')) {
      return timezone.split('/').last.replaceAll('_', ' ');
    }
    return timezone;
  }

  void _updateTime(Timer timer) {
    setState(() {
      _updateCurrentTime();
    });
  }

  String _formatTemperature(double temperature, TemperatureUnit unit) {
    if (unit == TemperatureUnit.fahrenheit) {
      temperature = (temperature * 9 / 5) + 32;
    }
    return '${temperature.round()}°${unit == TemperatureUnit.celsius ? 'C' : 'F'}';
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: widget.isDaytime 
                ? [
                    const Color(0xFFE3F2FD).withValues(alpha: 0.8),
                    const Color(0xFFBBDEFB).withValues(alpha: 0.9),
                  ]
                : [
                    const Color(0xFF1A237E).withValues(alpha: 0.9),
                    const Color(0xFF3949AB).withValues(alpha: 0.8),
                  ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: widget.isDaytime 
                ? Colors.white.withValues(alpha: 0.3)
                : Colors.white.withValues(alpha: 0.1),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isDaytime 
                  ? const Color(0xFF2196F3).withValues(alpha: _isHovered ? 0.25 : 0.15)
                  : const Color(0xFF7C4DFF).withValues(alpha: _isHovered ? 0.35 : 0.25),
              blurRadius: _isHovered ? 20 : 16,
              offset: Offset(0, _isHovered ? 8 : 6),
              spreadRadius: _isHovered ? 2 : 0,
            ),
            BoxShadow(
              color: Colors.white.withValues(
                alpha: widget.isDaytime ? 0.6 : 0.1,
              ),
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Location Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: widget.isDaytime 
                      ? Colors.white.withValues(alpha: 0.2)
                      : Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: widget.isDaytime 
                        ? Colors.white.withValues(alpha: 0.3)
                        : Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 16,
                      color: widget.isDaytime 
                          ? const Color(0xFF1976D2)
                          : const Color(0xFF7C4DFF),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatLocationName(widget.timezone),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: widget.isDaytime 
                            ? const Color(0xFF1565C0)
                            : Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Clock Display - Either Analog OR Digital
              if (settings.data?.showAnalogClock ?? false) ...[
                // Analog Clock Section
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: AnalogClock(
                    dateTime: _currentTime,
                    isKeepTime: false,
                  ),
                ),
                const SizedBox(height: 16),
              ] else ...[
                // Digital Time Display
                Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: widget.isDaytime 
                        ? [
                            Colors.white.withValues(alpha: 0.3),
                            Colors.white.withValues(alpha: 0.1),
                          ]
                        : [
                            Colors.white.withValues(alpha: 0.15),
                            Colors.white.withValues(alpha: 0.05),
                          ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: widget.isDaytime 
                        ? Colors.white.withValues(alpha: 0.4)
                        : Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      _formatTime(_currentTime, settings.data?.timeFormat ?? TimeFormat.h24, settings.data?.showSeconds ?? true),
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: widget.isDaytime 
                            ? const Color(0xFF0D47A1)
                            : Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 48,
                        letterSpacing: -1.5,
                        fontFamily: 'SF Pro Display',
                        shadows: widget.isDaytime 
                            ? []
                            : [
                                Shadow(
                                  color: Colors.white.withValues(alpha: 0.5),
                                  blurRadius: 8,
                                ),
                              ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(_currentTime, settings.data?.dateFormat ?? DateFormat.ddmmyyyy),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: widget.isDaytime 
                            ? const Color(0xFF1976D2).withValues(alpha: 0.7)
                            : Colors.white.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              ],
              const SizedBox(height: 20),
              // Weather Information
              if (_weather != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: widget.isDaytime 
                        ? Colors.white.withValues(alpha: 0.2)
                        : Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: widget.isDaytime 
                          ? Colors.white.withValues(alpha: 0.3)
                          : Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Temperature
                      _buildWeatherItem(
                        Icons.thermostat_rounded,
                        _formatTemperature(
                          _weather!.temperature!.celsius!,
                          settings.data?.temperatureUnit ?? TemperatureUnit.celsius,
                        ),
                        widget.isDaytime 
                            ? const Color(0xFFFF6F00)
                            : const Color(0xFFFFB74D),
                      ),
                      
                      // Divider
                      Container(
                        height: 20,
                        width: 1,
                        color: widget.isDaytime 
                            ? Colors.grey.withValues(alpha: 0.3)
                            : Colors.white.withValues(alpha: 0.2),
                      ),
                      
                      // Humidity
                      _buildWeatherItem(
                        Icons.water_drop_rounded,
                        '${_weather!.humidity}%',
                        widget.isDaytime 
                            ? const Color(0xFF0277BD)
                            : const Color(0xFF4FC3F7),
                      ),
                    ],
                  ),
                ),
              ],
            ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time, TimeFormat format, bool showSeconds) {
    final pattern = format == TimeFormat.h12
        ? (showSeconds ? 'hh:mm:ss a' : 'hh:mm a')
        : (showSeconds ? 'HH:mm:ss' : 'HH:mm');
    return intl.DateFormat(pattern).format(time);
  }

  String _formatDate(DateTime date, DateFormat format) {
    final pattern = switch (format) {
      DateFormat.ddmmyyyy => 'dd/MM/yyyy',
      DateFormat.mmddyyyy => 'MM/dd/yyyy',
      DateFormat.yyyymmdd => 'yyyy-MM-dd',
    };
    return intl.DateFormat(pattern).format(date);
  }

  Widget _buildWeatherItem(IconData icon, String value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: TextStyle(
            color: widget.isDaytime 
                ? const Color(0xFF1565C0)
                : Colors.white.withValues(alpha: 0.9),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
  
  String _formatLocationName(String timezone) {
    if (timezone.contains('/')) {
      final parts = timezone.split('/');
      final city = parts.last.replaceAll('_', ' ');
      final region = parts.length > 2 ? parts[1] : parts.first;
      return '$city, ${region.replaceAll('_', ' ')}';
    }
    return timezone.replaceAll('_', ' ');
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}