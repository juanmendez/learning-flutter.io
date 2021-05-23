import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/identify.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_flutter/utilities/Strings.dart';

@LazySingleton()
class Analytics {
  late Amplitude _amplitude;

  Analytics() {
    _amplitude = Amplitude.getInstance(instanceName: Strings.ANALYTICS_PROJECT);
    _amplitude.init(Strings.AMPLITUDE_KEY);
  }

  Future<void> logEvent(String eventType, {Map<String, dynamic>? eventProperties, bool? outOfSession}) async {
    await _amplitude.logEvent(eventType, eventProperties: eventProperties, outOfSession: outOfSession);
  }

  Future<void> startSession() async {
    await _amplitude.trackingSessionEvents(true);
  }

  Future<void> endSession() async {
    await _amplitude.trackingSessionEvents(false);
  }

  Future<void> setPropertyOnce(String key, dynamic value) async {
    final identify = Identify();
    identify.setOnce(key, value);
    await _amplitude.identify(identify);
  }

  Future<void> setPropertiesOnce(Map<String, dynamic> properties) async {
    final identify = Identify();
    properties.forEach((key, value) {
      identify.setOnce(key, value);
    });

    await _amplitude.identify(identify);
  }

  Future<void> setProperty(String key, dynamic value) async {
    final identify = Identify();
    identify.set(key, value);
    await _amplitude.identify(identify);
  }

  Future<void> setProperties(Map<String, dynamic> properties) async {
    await _amplitude.setUserProperties(properties);
  }
}
