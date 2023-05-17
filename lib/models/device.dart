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

  Device copy() {
    return Device(
      id: id,
      name: name,
      model: model,
      systemVersion: systemVersion,
      type: type,
      location: location,
      homeLocation: homeLocation,
      isRented: isRented,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Device &&
        other.id == id &&
        other.name == name &&
        other.model == model &&
        other.systemVersion == systemVersion &&
        other.type == type &&
        other.location == location &&
        other.homeLocation == homeLocation &&
        other.isRented == isRented;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        model.hashCode ^
        systemVersion.hashCode ^
        (type?.hashCode ?? 0) ^
        location.hashCode ^
        homeLocation.hashCode ^
        (isRented?.hashCode ?? 0);
  }
}
