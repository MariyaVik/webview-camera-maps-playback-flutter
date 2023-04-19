class AppLatLong {
  final double lat;
  final double long;

  const AppLatLong({
    required this.lat,
    required this.long,
  });
}

class EkbLocation extends AppLatLong {
  const EkbLocation({
    super.lat = 56.8519,
    super.long = 60.6122,
  });
}
