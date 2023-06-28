import 'location.dart';

class Place {
  final Location location;
  final String name;
  final String description;
  final String imagePath;
  final DateTime timestamp;

  Place(this.location, this.name, this.description, this.imagePath, this.timestamp);

  Place.fromJSON(Map<String, dynamic> json)
      : location = Location.fromJSON(json['location']),
        name = json['name'],
        description = json['description'],
        timestamp = DateTime.parse(json['timestamp']),
        imagePath = json['imagePath'];

  Map<String, dynamic> toJson() =>
      {'location': location, 'name': name, 'description': description, 'imagePath': imagePath, 'timestamp': timestamp.toIso8601String()};

  @override
  bool operator ==(covariant Place other) {
    return location == other.location && name == other.name;
  }

  @override
  int get hashCode => location.hashCode;
}
