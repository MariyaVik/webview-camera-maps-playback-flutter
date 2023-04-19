import 'lat_lng.dart';

abstract class AppLocation {
  Future<AppLatLong> getCurrentLocation();

  Future<bool> requestPermission();

  Future<bool> checkPermission();
}
