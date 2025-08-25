import 'package:weather/weather.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String _apiKey = '29ec820e7b41fba7311c927e33de378b'; // Replace with your API key

final weatherServiceProvider = Provider((ref) => WeatherService());

class WeatherService {
  final WeatherFactory _wf = WeatherFactory(_apiKey);

  Future<Weather?> getWeatherForCity(String cityName) async {
    try {
      return await _wf.currentWeatherByCityName(cityName);
    } catch (e) {
      return null;
    }
  }
}