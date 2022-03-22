import 'package:global_configuration/global_configuration.dart';

// const String apiBaseUrl = 'https://consultation.softwaresbranding.com/api/';
// const String baseUrl = 'https://consultation.softwaresbranding.com/';
// const String mediaUrl = 'https://consultation.softwaresbranding.com';

final String baseUrl = GlobalConfiguration().get('base_url');
final String apiBaseUrl = GlobalConfiguration().get('api_base_url');
final String mediaUrl = GlobalConfiguration().get('media_url');

///---fcm
const String fcmService = 'https://fcm.googleapis.com/fcm/send';

///---auth
String signUpWithEmailURL = apiBaseUrl + 'signup-email';
String loginWithEmailURL = apiBaseUrl + 'login-email';

String mentorApprovalStatusUrl = apiBaseUrl + 'mentorStatus';

///---user
String getUserProfileURL = apiBaseUrl + 'get-mentee-profile';

String updateMenteeProfileUrl = apiBaseUrl + 'update-mentee-profile';

///---consultant-profile-by-id
String getConsultantProfileByIDURL = apiBaseUrl + 'getUserById';

///---consultant-profile-section
String mentorProfileGenericDataUrl = apiBaseUrl + 'generic_mentor';
String getCitiesByIdUrl = apiBaseUrl + 'cities';
String getCountriesUrl = apiBaseUrl + 'countries';
String mentorParentCategoryDataUrl = apiBaseUrl + 'mentorCategoriesList';
String mentorChildCategoryDataUrl = apiBaseUrl + 'mentorChildCategoriesList';
String mentorGeneralInfoPostUrl = apiBaseUrl + 'updateMentorProfile';
String mentorEducationalInfoPostUrl = apiBaseUrl + 'mentorEducation';
String mentorExperienceInfoUrl = apiBaseUrl + 'mentorExperience';
String mentorSkillInfoUrl = apiBaseUrl + 'mentorSkill';
String mentorAccountInfoUrl = apiBaseUrl + 'mentor_card';
String mentorEducationalInfoDeleteUrl = apiBaseUrl + 'mentorEducationDelete';
String mentorExperienceInfoDeleteUrl = apiBaseUrl + 'mentorExperienceDelete';
String mentorSkillInfoDeleteUrl = apiBaseUrl + 'mentorSkillDelete';
String mentorRatingsUrl = apiBaseUrl + 'get-ratings-detail';

///---featured
String getFeaturedURL = apiBaseUrl + 'get-featured-mentors';

///---categories
String getCategoriesURL = apiBaseUrl + 'mentorCategories';

///---top-rated
String getTopRatedConsultantURL = apiBaseUrl + 'topRatedMentors';

///---categories-with-mentor
String getCategoriesWithMentorURL = apiBaseUrl + 'categories/with/mentors';

///---book-appointment
String getScheduleAvailableDaysURL =
    apiBaseUrl + 'get-scheduled-available-days';
String getScheduleSlotsForMenteeUrl = apiBaseUrl + 'get-date-schedule';
String bookAppointmentUrl = apiBaseUrl + 'bookAppointment';

///---appointment-log-user
String getUserAllAppointmentsURL = apiBaseUrl + 'all-status-menteeAppointments';

///---appointment-log-user
String getAppointmentsDetailURL = apiBaseUrl + 'appointmentDetails';
