class Parameter {
  static const bool API_PRINT_LOGGING_ENABLED = true;
}

class ApiUrl {
  static String MAIN_BASE = MAIN_BASE_DEVELOPMENT;
  static String SECONDARY_BASE = SECONDARY_BASE_DEVELOPMENT;

  // Server development
  static final String MAIN_BASE_DEVELOPMENT = "https://api-dev.bpjsketenagakerjaan.go.id/sihandal-dev";
  static final String SECONDARY_BASE_DEVELOPMENT = "https://api-dev.bpjsketenagakerjaan.go.id/sihandal-dev";


  static const String SIGN_IN = "/login";
  static const String GET_PKBU = "/get-company";
  static const String REFRESH_TOKEN = "/refresh-token";


}

enum SharedPreferenceKey {
  IS_LOGIN,
  MAIN_BASE,
  SECONDARY_BASE,
  SESSION_ID,
  SESSION_EXPIRED_AT,
  USER_CODE,
  COMPANY_CODE
}