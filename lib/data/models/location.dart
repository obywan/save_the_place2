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
  @override
  bool operator ==(covariant Location other) {
    return latitude == other.latitude && longitude == other.longitude && elevation == other.elevation;
  }

  @override
  int get hashCode => (latitude + longitude + elevation).hashCode;
}
