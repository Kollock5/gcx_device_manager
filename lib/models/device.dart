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
      id: json['id'].toString(),
      name: json['name'].toString(),
      model: json['model'].toString(),
      systemVersion: json['systemVersion'].toString(),
      type: json['type'].toString(),
      location: json['location'].toString(),
      homeLocation: json['homeLocation'].toString(),
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
