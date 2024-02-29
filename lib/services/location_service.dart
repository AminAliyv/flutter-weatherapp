import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<List> getLocation() async {
    List locationDetails = [];

    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Future.error("Your location service is turned off");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Future.error("You must grant location permission");
      }
    }

    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    locationDetails.add(position.latitude);
    locationDetails.add(position.longitude);

    return locationDetails;
  }
}
