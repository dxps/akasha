import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/access_level/access_levels_screen.dart';
import 'package:akasha_ui/attribute_template/attr_tmpls_list_screen.dart';
import 'package:akasha_ui/screens/home_screen.dart';
import 'package:akasha_ui/widgets/app_shell.dart';
import 'package:go_router/go_router.dart';

enum Routes {
  home('/'),
  attributeTemplates('/data/templates/attributes'),
  accessLevels('/data/access-levels');

  final String path;
  const Routes(this.path);
}

void initRouter(Client client) {
  router = GoRouter(
    initialLocation: Routes.home.path,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.home.path,
                pageBuilder: (context, state) => NoTransitionPage(child: HomeScreen(client: client)),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.attributeTemplates.path,
                pageBuilder: (context, state) => const NoTransitionPage(child: AttributeTmplsScreen()),
              ),
              GoRoute(
                path: Routes.accessLevels.path,
                pageBuilder: (context, state) => const NoTransitionPage(child: AccessLevelsScreen()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

late final GoRouter router;
