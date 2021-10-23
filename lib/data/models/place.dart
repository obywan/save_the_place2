import 'location.dart';

class Place {
  final Location location;
  final String name;
  final String description;
  final String imagePath;

  Place(this.location, this.name, this.description, this.imagePath);

  Place.fromJSON(Map<String, dynamic> json)
      : location = Location.fromJSON(json['location']),
        name = json['name'],
        description = json['description'],
        imagePath = json['imagePath'];

  Map<String, dynamic> toJson() => {
        'location': location,
        'name': name,
        'description': description,
        'imagePath': imagePath,
      };
}
