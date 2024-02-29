import 'package:flutter/material.dart';
import 'package:weatherapp/services/location_service.dart';
import 'package:weatherapp/services/weather_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LocationService locationService = LocationService();

  double todayTemperature = 0.0;
  double tommorowTemperature = 0.0;

  int weatherIconCode = 0;
  int tomorrowWeatherIconCode = 0;

  String day = '0000-00-00';

  double windspeed = 0.0;

  Future<void> loadWeatherData() async {
    try {
      List locationDetails = await locationService.getLocation();

      final WeatherService weatherService = WeatherService(
          'https://www.meteosource.com/api/v1/free/point?lat=${locationDetails[0]}&lon=${locationDetails[1]}&sections=daily&timezone=UTC&language=en&units=metric&key=ui659dlb6uytvgx13psg5k1gejpz0p4dhtrmh8iq');
      Map<String, dynamic> weatherData = await weatherService.getWeatherData();

      setState(() {
        todayTemperature = weatherData['daily']['data'][0]['all_day']['temperature'];
        tommorowTemperature = weatherData['daily']['data'][1]['all_day']['temperature'];

        weatherIconCode = weatherData['daily']['data'][0]['icon'];
        tomorrowWeatherIconCode = weatherData['daily']['data'][1]['icon'];

        day = weatherData['daily']['data'][1]['day'];

        windspeed = weatherData['daily']['data'][0]['all_day']['wind']['speed'];
      });
    } catch (e) {
      print('Weather data could not be retrieved:$e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 16, 0, 56),
              Color.fromARGB(255, 99, 5, 177),
              Color.fromARGB(255, 175, 21, 196),
            ],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50),
                width: 244,
                height: 244,
                child: FittedBox(
                  child: Image.asset(
                    (weatherIconCode >= 1 && weatherIconCode <= 9)
                        ? 'assets/images/sunny.png'
                        : (weatherIconCode >= 10 && weatherIconCode <= 14)
                            ? 'assets/images/rainny.png'
                            : (weatherIconCode > 14)
                                ? 'assets/images/snowy.png'
                                : 'assets/images/sunny.png',
                  ),
                ),
              ),
              Text('${todayTemperature}°C', style: TextStyle(fontSize: 50)),
              Image.asset('assets/images/House.png'),
              Container(
                width: 428,
                height: 246,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [
                          Color.fromARGB(255, 16, 0, 56),
                          Color.fromARGB(255, 131, 24, 218),
                          Color.fromARGB(255, 175, 21, 196),
                        ])),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tomorrow',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '${day}',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                        color: const Color.fromARGB(255, 142, 120, 200),
                        thickness: 3),
                    Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           Image.asset(
                            
                    (weatherIconCode >= 1 && weatherIconCode <= 9)
                        ? 'assets/images/sunny.png'
                        : (weatherIconCode >= 10 && weatherIconCode <= 14)
                            ? 'assets/images/rainny.png'
                            : (weatherIconCode > 14)
                                ? 'assets/images/snowy.png'
                                : 'assets/images/sunny.png', height: 150,
                  ),
                            Text('${tommorowTemperature}°C',
                                style: TextStyle(fontSize: 50)),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            const Text('Wind', style: TextStyle(fontSize: 20)),
                            Text('${windspeed}m/s',
                                style: TextStyle(fontSize: 20)),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
