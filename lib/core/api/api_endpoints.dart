// API base url

class Endpoint {
  // API base Url

  static const String _base =
      // "https://dev-api.outtapp.com";
      // 'https://ec2-34-201-165-54.compute-1.amazonaws.com';
      'http://ec2-44-204-168-41.compute-1.amazonaws.com:7653';

  // Environment.baseUrl;

  // Authentication Endpoint//////////////////////////////////
  /// Login
  static const authenticateEndpoint = '$_base/auth/authenticate/';

  // Logout
  static const logoutEndpoint = '$_base/users/signout';

  // Upload Endpoint
  static const String _uploadBase =
      'http://ec2-18-206-154-84.compute-1.amazonaws.com:8000';

  static const uploadEventVideoEndpointPost =
      '$_uploadBase/v1/uploads/event-video/';
  static const uploadImagesEndpointPost =
      '$_uploadBase/v1/uploads/profile-image/';

  //Create event
  static const String createEventEndpointPOST = '$_base/events/create-event/';

  static const String getEventFeedDataGET = '$_base/events/';
}
