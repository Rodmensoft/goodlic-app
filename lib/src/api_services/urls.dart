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
String getMenteeProfileUrl = apiBaseUrl + 'get-mentee-profile';

String updateMenteeProfileUrl = apiBaseUrl + 'update-mentee-profile';

///---consultant-profile-by-id
String getUserProfileUrl = apiBaseUrl + 'getUserById';

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

///---mentor-schedule
String getAppointmentTypeUrl = apiBaseUrl + 'appointmenttypes';
String markDayHolidayUrl = apiBaseUrl + 'mark-day-holiday';
String getAvailableDaysUrl = apiBaseUrl + 'get-available-days';
String saveMentorSchedulesUrl = apiBaseUrl + 'save-mentor-schedule';
String saveMentorChatFeeUrl = apiBaseUrl + 'save-mentor-chat-fee';
String getMentorSchedulesUrl = apiBaseUrl + 'get-mentor-schedules';
String deleteMentorScheduleUrl = apiBaseUrl + 'delete-mentor-schedule';

String mentorProfileStatusUrl = apiBaseUrl + 'mentorProfile';

String changeProfileVisibilityUrl = apiBaseUrl + 'toggle-visibility';
String changeMentorOnlineStatusUrl = apiBaseUrl + 'changeOnlineStatus';
String goLiveForMentorUrl = apiBaseUrl + 'turn-live-mentor';
String inActiveLiveForMentorUrl = apiBaseUrl + 'turn-inactive-mentor';


 String mentorChangeAppointmentStatusUrl =
     apiBaseUrl + 'changeAppointmentStatus';
///---get-appointment-counts
String getAppointmentCountUrl = apiBaseUrl + 'mentorAppointmentCount';
String getAppointmentCountForMentorUrl = apiBaseUrl + 'appointment-count';

///---mentor-appointment-log
String mentorAllAppointmentUrl = apiBaseUrl + 'mentorAppointments';
String mentorNewAppointmentUrl = apiBaseUrl + 'newMentorAppointments';
String mentorTodayAppointmentUrl = apiBaseUrl + 'today-appointments';

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
String getConsultantAllAppointmentsURL = apiBaseUrl + 'all-status-mentorAppointments';

///---appointment-log-user
String getAppointmentsDetailURL = apiBaseUrl + 'appointmentDetails';

/// Blogs
String blogCategoriesUrl = apiBaseUrl + 'categoriesBlogs';

/// wallet
String getWalletBalanceUrl = apiBaseUrl + 'check-balance';
String getWalletTransactionUrl = apiBaseUrl + 'wallet-history';
String walletDepositUrl = apiBaseUrl + 'deposit-wallet';
String walletDepositJazzcashUrl = apiBaseUrl + 'deposit-wallet-jazzcash';
String walletWithdrawUrl = apiBaseUrl + 'withdraw-request';

/// rating
String createRatingUrl = apiBaseUrl + 'create-rating';
String getExistRatingUrl = apiBaseUrl + 'rating-exist-appointment';

///---agora
 String agoraTokenUrl = apiBaseUrl + 'agoraToken';

///---send-message
String sendSMSUrl = apiBaseUrl + 'send-sms';

///---get-device-id
String fcmUpdateUrl = apiBaseUrl + 'fcm-store-token';
String fcmGetUrl = apiBaseUrl + 'fcm-get-tokens';

///---chat services
String fetchMessagesUrl = apiBaseUrl + 'fetch-messages';
String sendMessageUrl = apiBaseUrl + 'send-message';

///---download-invoice
String downloadAppointmentInvoiceForMenteeUrl = apiBaseUrl + 'completed-appointment-invoice';