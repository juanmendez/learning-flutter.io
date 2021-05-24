abstract class AnalyticsEvent {
  static const VIEW_SCREEN = 'Screen Viewed';
  static const CITY_SEARCHED = 'Weather Searched For';
  static const CITY_DETECTED = 'User Location Detected';
  static const CITY_IMAGE_FOUND = 'City Background Image';
  static const NO_CITY_IMAGE_FOUND = 'No City Background Found';
}

abstract class UserKey {
  static const NAME = 'Faked User Name';
  static const VISITS = 'Number of Visits';
}

abstract class AnalyticsKey {
  static const SCREEN = 'Screen';
  static const CITY = 'City';
  static const LATITUDE = 'Latitude';
  static const LONGITUDE = 'Longitude';
  static const URL = 'url';
}

abstract class AnalyticsValue {
  // pages
  static const CITY_SCREEN = 'City Screen';
  static const LOADING_SCREEN = 'Loading Screen';
  static const LOCATION_SCREEN = 'Location Screen';
}