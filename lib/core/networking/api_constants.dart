// lib/core/constants/api_constants.dart

class ApiConstants {
  ApiConstants._();

  static const String baseUrl =
      'https://danita-astrometric-avengingly.ngrok-free.dev';
  static const String apiBaseUrl = baseUrl;

  // Timeouts
  static const int connectTimeout = 30;
  static const int receiveTimeout = 30;
  static const int sendTimeout = 30;

  // ===== AUTH ENDPOINTS =====
  static const String login = '/auth/jwt/create';
  static const String googleLogin = '/api/auth/google/';
  static const String register = '/auth/users/';
  static const String activateAccount = '/api/verify-otp/';
  static const String resendOtp = '/api/resend-otp/';
  static const String refreshToken = '/auth/tokens-refresh/';
  static const String progressOverview = '/api/progress-overview/';

  // ===== COURSE ENDPOINTS =====
  static const String categories = '/api/categories/';

  static String getCategoryProgress(int categoryId) {
    return '/api/category-progress/$categoryId/';
  }

  static String getSubjectsByCategory(int categoryId) {
    return '/api/categories/$categoryId/subjects/';
  }

  static String getSkillsBySubject(int categoryId, int subjectId) {
    return '/api/categories/$categoryId/subjects/$subjectId/skills/';
  }

  static String getProgressOverview() {
    return '/api/progress-overview/';
  }

  // ===== SKILL PROFILES (subject scoped) =====
  // Replaces the old flat '/api/skill-profiles' endpoint.
  static String getSkillProfilesBySubject(int categoryId, int subjectId) {
    return '/api/categories/$categoryId/subjects/$subjectId/skill-profiles/';
  }

  // ===== CONCEPT PROFILES =====
  static String getConceptProfiles(int categoryId, int subjectId, int skillId) {
    return '/api/categories/$categoryId/subjects/$subjectId/skills/$skillId/concept-profiles/';
  }

  // ===== PLACEMENT =====
  static String startPlacement(int categoryId, int subjectId, int skillId) {
    return '/api/categories/$categoryId/subjects/$subjectId/skills/$skillId/start-placement/';
  }

  static String submitPlacement(int placementId) {
    return '/api/placement/$placementId/submit/';
  }
}

class ApiErrors {
  ApiErrors._();

  static const String noContent = 'No content';
  static const String badRequestError = 'Bad request error';
  static const String unauthorizedError = 'Unauthorized error';
  static const String forbiddenError = 'Forbidden error';
  static const String internalServerError = 'Internal server error';
  static const String notFoundError = 'Not found error';
  static const String timeoutError = 'Timeout error';
  static const String defaultError = 'Something went wrong';
  static const String cacheError = 'Cache error';
  static const String noInternetError = 'No internet connection';
}
