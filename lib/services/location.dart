import 'package:geolocator/geolocator.dart';

class Location {
  static Future<Position> getLocation() async {
    // make sure to select location under simulator, as the default is none.
    // Android has one already defined, but you can also update the emulator current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    return position;
  }
}
