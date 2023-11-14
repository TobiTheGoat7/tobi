class City {
  final String id;
  final String name;
  final double? lat;
  final double? lng;

  City({
    required this.id,
    required this.name,
    this.lat,
    this.lng,
  });
}
