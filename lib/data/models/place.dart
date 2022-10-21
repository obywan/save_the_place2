import 'location.dart';

class Place {
  final Location location;
  final String name;
  final String description;
  final String imagePath;
  final DateTime timestamp;
  final List<String> tags;

  Place(this.location, this.name, this.description, this.imagePath, this.timestamp, this.tags);

  Place.fromJSON(Map<String, dynamic> json)
      : location = Location.fromJSON(json['location']),
        name = json['name'],
        description = json['description'],
        timestamp = DateTime.parse(json['timestamp']),
        imagePath = json['imagePath'],
        tags = json['tags'] == null ? [] : List<String>.from(json['tags']);

  Map<String, dynamic> toJson() =>
      {'location': location, 'name': name, 'description': description, 'imagePath': imagePath, 'timestamp': timestamp.toIso8601String(), 'tags': tags};

  @override
  bool operator ==(covariant Place other) {
    return location == other.location && name == other.name;
  }

  @override
  int get hashCode => location.hashCode;
}
