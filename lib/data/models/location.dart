class Location {
  final double latitude;
  final double longitude;
  final double elevation;

  Location({required this.latitude, required this.longitude, required this.elevation});

  Location.fromJSON(Map<String, dynamic> json)
      : latitude = json['latitude'],
        longitude = json['longitude'],
        elevation = json['elevation'];

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'elevation': elevation,
      };
}
