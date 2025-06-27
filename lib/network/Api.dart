// ignore_for_file: prefer_interpolation_to_compose_strings, file_names

class Api {
  static var baseUrl = "https://mutschmiede.com/wp-json/app/v1/";
  static var login = baseUrl + "api_login"; //?vouchernumber=27424024
  static var userlistonline = baseUrl + "api_get_info_user_online";
  static var userlistall = baseUrl + "api_get_all_coaches";
  static var dashboardCall =
      baseUrl + "api_get_info_user_online"; //? company_id =27424024
  static var calendarAPICall = baseUrl + "api_get_calendar";
  static var inboxCall = baseUrl + "api_get_message";
  static var aktuelles = baseUrl + "api_get_data_events_v3";
  static var kooperatiosPartner = aktuelles; // ?vouchernumber=40552880;
  static var zusagen = baseUrl + "update_news";
  static var profile = baseUrl + "api_get_profile";
  static var updateProfile = baseUrl + "update_info_user";
  static var userList = baseUrl + "api_get_all_user";
  static var whistleKeeperProgram = baseUrl + "api_get_whistleblower";
  static var apiGetSpiele = baseUrl + "api_get_spiele";
  static var categoryList =
     baseUrl + "api_user_group_by_category/?id_category=";
  static var videoTrainer = baseUrl + "api_get_video_trainer_by_case";
  static var checkCompanyStatus =
      baseUrl + "check_company_status_option"; // ?vouchernumber=40552880
  static var sendMail = baseUrl +
      "api_send_mail/"; // ?vouchernumber=40552880 , ?firma=test , ?land=Italien , ?email=jptesting3@gmail.com , ?namen_des_absenders=dev , ?beschwerde=text
  static var sendPhoneNumber =
      baseUrl + "company_start_call"; // ?vouchernumber=40552880

}
