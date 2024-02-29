import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiUrl;
  WeatherService(this.apiUrl);

  Future<Map<String, dynamic>> getWeatherData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Hava durumu verileri yüklenemedi');
    }
  }
}

































//  Future<List<WeatherModel>> getWeatherData() async {
//     final String city = await _getLocation();

//     final String url =
//         "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=ankara";
//     const Map<String, dynamic> headers = {
//       "authorization": "apikey 4I8DBYg8ETDeJrEZwwa0Pl:3Ht4IwjahVH2H75O2ecEDa",
//       "content-type": "application/json"
//     };

//     final dio = Dio();

//     final response = await dio.get(url, options: Options(headers: headers));

//     if (response.statusCode != 200) {
//       return Future.error("Bir sorun oluştu");
//     }

//    final List<dynamic>? list = response.data['result'];
// if (list == null) {
//   return Future.error("API'den geçerli veri alınamadı.");
// }

// final List<WeatherModel> weatherList =
//     list.map((e) => WeatherModel.fromJson(e)).toList();

//     return weatherList;
//   }
// }

// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:weatherapp/model/weather_model.dart';

// class WeatherService {
//   Future<List> _getLocation() async {
//     final List locationDetails = [];
//     LocationPermission permission;
//     final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       Future.error('Location services are disabled!');
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         Future.error('Location permissions are denied');
//       }
//     }
//     final Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     final List<Placemark> placemark =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     final String? city = placemark[0].locality;
//     if (city == null) {
//       Future.error('Error');
//     }
//     locationDetails.add(city);
//     locationDetails.add(position.latitude);
//     locationDetails.add(position.longitude);
//     return locationDetails;
//   }

//   Future<List<WeatherModel>> getWeatherData() async {
//     final List<dynamic> details = await _getLocation();
//     // final city = details[0];
//     final latitude = details[1];
//     final longitude = details[2];
//     final url = 'https://api.tomorrow.io/v4/weather/forecast?location=$latitude,$longitude&apikey=kyOVvLGMjdtBZZACFPrr3vEtLn3sb7vB';

//     final dio = Dio();
//     final response = await dio.get(url);

//     if (response.statusCode != HttpStatus.ok) {
//       return Future.error('errosssr');
//     }
//     print(response.data);
//     final List<Map<String, dynamic>> list = response.data['timelines']['minutely'];
//     final List<WeatherModel> weatherList = list.map((minutely) => WeatherModel.fromJson(minutely['values'])).toList();

//     return weatherList;
//   }
// }
