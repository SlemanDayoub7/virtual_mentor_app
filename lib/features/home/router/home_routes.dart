import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../presentation/pages/home_page.dart';

final homeRoutes = [
  GoRoute(
    path: AppRoutes.home,
    name: AppRoutes.home,
    builder: (_, __) => const HomePage(),
  ),
  // GoRoute(
  //   path: AppRoutes.mentors,
  //   name: AppRoutes.mentors,
  //   builder: (_, __) => const MentorsPage(),
  // ),
  // GoRoute(
  //   path: AppRoutes.profile,
  //   name: AppRoutes.profile,
  //   builder: (_, __) => const ProfilePage(),
  // ),
];
