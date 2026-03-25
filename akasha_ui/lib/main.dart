import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/access_level/access_levels_screen.dart';
import 'package:akasha_ui/attr_tmpl/attr_tmpls_list_screen.dart';
import 'package:akasha_ui/screens/home_screen.dart';
import 'package:akasha_ui/theming/init_theme.dart';
import 'package:akasha_ui/theming/theme_cubit.dart';
import 'package:akasha_ui/widgets/app_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

/// Sets up a global client object that can be used to talk to the server from
/// anywhere in our app. The client is generated from your server code
/// and is set up to connect to a Serverpod running on a local server on
/// the default port. You will need to modify this to connect to staging or
/// production servers.
/// In a larger app, you may want to use the dependency injection of your choice
/// instead of using a global client object. This is just a simple example.
late final Client client;

late String serverUrl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: This works only for the Web.
  usePathUrlStrategy();

  // When you are running the app on a physical device, you need to set the
  // server URL to the IP address of your computer. You can find the IP
  // address by running `ipconfig` on Windows or `ifconfig` on Mac/Linux.
  // You can set the variable when running or building your app like this:
  // E.g. `flutter run --dart-define=SERVER_URL=https://api.example.com/`.
  // Otherwise, the server URL is fetched from the assets/config.json file or
  // defaults to http://$localhost:9090/ if not found.
  final serverUrl = await getServerUrl();

  client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();

  client.auth.initialize();

  runApp(
    BlocProvider(
      create: (_) => ThemeCubit(),
      child: const MyApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) => NoTransitionPage(child: HomeScreen(client: client)),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/attribute_templates',
              pageBuilder: (context, state) => const NoTransitionPage(child: AttributeTmplsScreen()),
            ),
            GoRoute(
              path: '/access_levels',
              pageBuilder: (context, state) => const NoTransitionPage(child: AccessLevelsScreen()),
            ),
          ],
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
          title: '',
          themeMode: themeMode,
          theme: initThemeData(Brightness.light),
          darkTheme: initThemeData(Brightness.dark),
        );
      },
    );
  }
}
