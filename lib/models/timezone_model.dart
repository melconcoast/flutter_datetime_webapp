import 'package:weather/weather.dart';

class TimezoneModel {
  final String name;
  final String offset;
  final DateTime dateTime;
  final Weather? weather;
  final bool isDaytime;

  const TimezoneModel({
    required this.name,
    required this.offset,
    required this.dateTime,
    this.weather,
    required this.isDaytime,
  });

  factory TimezoneModel.fromJson(Map<String, dynamic> json) {
    return TimezoneModel(
      name: json['name'] as String,
      offset: json['offset'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      // weather: json['weather'] != null ? Weather.fromJson(json['weather']) : null,
      isDaytime: json['isDaytime'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'offset': offset,
      'dateTime': dateTime.toIso8601String(),
      // 'weather': weather?.toJson(),
      'isDaytime': isDaytime,
    };
  }
}