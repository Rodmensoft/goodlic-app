import 'package:global_configuration/global_configuration.dart';

// const String baseUrl = 'https://mashvra.softwaresbranding.com/api/';
// const String mediaUrl = 'https://mashvra.softwaresbranding.com/';
// const String paymentBaseUrl = 'https://mashvra.softwaresbranding.com/';

final String baseUrl = GlobalConfiguration().get('base_url');
final String apiBaseUrl = GlobalConfiguration().get('api_base_url');
final String mediaUrl = GlobalConfiguration().get('media_url');

///---fcm
String fcmService = 'https://fcm.googleapis.com/fcm/send';
