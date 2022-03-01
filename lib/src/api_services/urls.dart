import 'package:global_configuration/global_configuration.dart';

// const String baseUrl = 'https://mashvra.softwaresbranding.com/api/';
// const String mediaUrl = 'https://mashvra.softwaresbranding.com/';
// const String paymentBaseUrl = 'https://mashvra.softwaresbranding.com/';

final String baseUrl = GlobalConfiguration().get('base_url');
final String apiBaseUrl = GlobalConfiguration().get('api_base_url');
final String mediaUrl = GlobalConfiguration().get('media_url');

///---fcm
String fcmService = 'https://fcm.googleapis.com/fcm/send';

///---auth
String signUpWithEmailURL = apiBaseUrl + 'signup-email';
String loginWithEmailURL = apiBaseUrl + 'login-email';

///---user
String getUserProfileURL = apiBaseUrl + 'get-mentee-profile';

///---consultant-profile-by-id
String getConsultantProfileByIDURL = apiBaseUrl + 'getUserById';

///---featured
String getFeaturedURL = apiBaseUrl + 'get-featured-mentors';

///---categories
String getCategoriesURL = apiBaseUrl + 'mentorCategories';

///---top-rated
String getTopRatedConsultantURL = apiBaseUrl + 'topRatedMentors';

///---categories-with-mentor
String getCategoriesWithMentorURL = apiBaseUrl + 'categories/with/mentors';
