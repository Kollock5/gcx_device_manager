// models/device.dart
class Device {
  String id;
  String name;
  String model;
  String systemVersion;
  String? type;
  String location;
  String homeLocation;
  bool? isRented;

  Device({
    required this.id,
    required this.name,
    required this.model,
    required this.systemVersion,
    required this.type,
    required this.location,
    required this.homeLocation,
    required this.isRented,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'] as String? ?? 'Unknown',
      name: json['name'] as String? ?? 'Unknown',
      model: json['model'] as String? ?? 'Unknown',
      systemVersion: json['systemVersion'] as String? ?? 'Unknown',
      type: json['type'] as String?,
      location: json['location'] as String? ?? 'Unknown',
      homeLocation: json['homeLocation'] as String? ?? 'Not Set',
      isRented: json['isRented'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'model': model,
      'systemVersion': systemVersion,
      'type': type,
      'location': location,
      'homeLocation': homeLocation,
      'isRented': isRented,
    };
  }
}
