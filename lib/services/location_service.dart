import 'package:geolocator/geolocator.dart';

class LocationService{
  Future<List> getLocation() async {
    //Bu funksiya ile istifadecinin konumunu almaliyiq. Bunun ucun geolocatordan istifade edirik.
    List locationDetails =
        []; // Bu listde istifadeciden aldigimiz paralel ve meredian olmalidi.
    // Kullanıcının konumu açık mı kontrol ettik
    final bool serviceEnabled = await Geolocator
        .isLocationServiceEnabled(); //GeoLocatorun bu metodunu isLocationServiceEnabled = serviceEnabled
    if (!serviceEnabled) {
      //Cihazdaki konum baglidisa
      Future.error("Konum servisiniz kapalı");
    }

    LocationPermission permission = await Geolocator
        .checkPermission(); //GeoLocatorun checkPermission metodunu = permission
    if (permission == LocationPermission.denied) {
      //Eger istifadeci konuma erisime icaze vermeyibse
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Future.error("Konum izni vermelisiniz");
      }
    }

    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    locationDetails.add(position.latitude);
    locationDetails.add(position.longitude);

    return locationDetails;
  }
}