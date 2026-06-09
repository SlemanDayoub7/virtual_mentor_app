class AppRoutes {
  AppRoutes._();

  // ─── Root paths (for go_router path definitions) ──────────
  static const String rootPath = '/';
  static const String onboardingPath = '/onboarding';
  static const String welcomingPath = '/welcoming';
  static const String authPath = '/auth';
  static const String mainPath = '/main';

  // ─── Route names (used with goNamed / pushNamed) ──────────
  static const String splash = 'splash';
  static const String onboarding = 'onboarding';
  static const String welcoming = 'welcoming';

  // ─── Auth names ───────────────────────────────────────────
  static const String login = 'login';
  static const String register = 'register';
  static const String forgotPassword = 'forgot-password';
  static const String verifyOtp = 'verify-otp';
  static const String resetPassword = 'reset-password';
  static const String verifySuccess = 'verify-success';
  static const String accountVerification = 'account-verification';
  static const String returnAccountVerification = 'return-account-verification';




  // ─── Main names ───────────────────────────────────────────
  static const String home = 'home';
  static const String mentors = 'mentors';
  static const String sessions = 'sessions';
  static const String notifications = 'notifications';
  static const String profile = 'profile';

  // ─── Nested names ─────────────────────────────────────────
  static const String mentorDetail = 'mentor-detail';
  static const String mentorBook = 'mentor-book';
  static const String sessionDetail = 'session-detail';
  static const String editProfile = 'edit-profile';
  static const String settings = 'settings';
  static const String changePassword = 'change-password';

  // ─── Full paths (for context.go() calls) ──────────────────
  static const String loginFull = '$authPath/$login';
  static const String welcomingFull = '$welcomingPath/$welcoming';
  static const String registerFull = '$authPath/$register';
  static const String forgotPasswordFull = '$authPath/$forgotPassword';
  static const String verifySuccessFull = '$authPath/$verifySuccess';
  static const String homeFull = '$mainPath/$home';
  static const String accountVerficationFull = '$authPath/$accountVerification';
  static const String returnAccountVerficationFull = '$authPath/$returnAccountVerification';

  static const String mentorsFull = '$mainPath/$mentors';
  static const String profileFull = '$authPath/$profile';
}
