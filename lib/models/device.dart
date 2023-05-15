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
    required this.id, //QR
    required this.name, //
    required this.model,
    required this.systemVersion,
    required this.type,
    required this.location,
    required this.homeLocation,
    required this.isRented,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'].toString() as String? ?? 'Unknown',
      name: json['name'].toString() as String? ?? 'Unknown',
      model: json['model'].toString() as String? ?? 'Unknown',
      systemVersion: json['systemVersion'].toString() as String? ?? 'Unknown',
      type: json['type'].toString() as String?,
      location: json['location'].toString() as String? ?? 'Unknown',
      homeLocation: json['homeLocation'].toString() as String? ?? 'Not Set',
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
