import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/access_level/access_levels_screen.dart';
import 'package:akasha_ui/attribute_template/attr_tmpls_list_screen.dart';
import 'package:akasha_ui/entity/ent_list_screen.dart';
import 'package:akasha_ui/entity_template/ent_tmpl_list_screen.dart';
import 'package:akasha_ui/screens/home_screen.dart';
import 'package:akasha_ui/widgets/app_shell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum Routes {
  home('/'),
  attributeTemplates('/data/templates/attributes'),
  accessLevels('/data/access-levels'),
  entityTemplates('/data/templates/entities'),
  entities('/data/entities');

  final String path;
  const Routes(this.path);

  static Routes? fromPath(String path) {
    for (final route in Routes.values) {
      if (route.path == path) return route;
    }
    return null;
  }
}

late final GoRouter router;

void initRouter(Client client) {
  router = GoRouter(
    initialLocation: Routes.home.path,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Title(
            title: titleForPath(state.uri.path),
            color: Colors.black,
            child: AppShell(navigationShell: navigationShell),
          );
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
              GoRoute(
                path: Routes.entityTemplates.path,
                pageBuilder: (context, state) => NoTransitionPage(child: EntityTemplatesScreen()),
              ),
              GoRoute(
                path: Routes.entities.path,
                pageBuilder: (context, state) => NoTransitionPage(child: EntitiesScreen()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

String titleForPath(String path) {
  return switch (Routes.fromPath(path)) {
    Routes.home => 'Home',
    Routes.attributeTemplates => 'Attribute Templates',
    Routes.accessLevels => 'Access Levels',
    Routes.entityTemplates => 'Entity Templates',
    Routes.entities => 'Entities',
    null => 'Akasha',
  };
}
