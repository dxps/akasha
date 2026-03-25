import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/access_level/access_levels_screen.dart';
import 'package:akasha_ui/attr_tmpl/attr_tmpls_list_screen.dart';
import 'package:akasha_ui/screens/home_screen.dart';
import 'package:akasha_ui/widgets/app_shell.dart';
import 'package:flutter/material.dart';
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

  runApp(const MyApp());
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: '',
      theme: initThemeData(),
    );
  }
}

ThemeData initThemeData() {
  final base = ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.grey[200],
  );

  return base.copyWith(
    dataTableTheme: const DataTableThemeData(
      headingTextStyle: TextStyle(color: Colors.grey, fontSize: 13),
      dataRowMinHeight: 30,
      dataRowMaxHeight: 30,
      dividerThickness: 0.25,
      headingRowHeight: 30,
    ),

    textTheme: base.textTheme.copyWith(
      bodyLarge: const TextStyle(fontSize: 15),
      bodyMedium: const TextStyle(fontSize: 14),
      titleMedium: const TextStyle(fontSize: 14), // important for ListTile/CheckboxListTile
      labelLarge: const TextStyle(fontSize: 14),
      labelMedium: const TextStyle(fontSize: 14),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      border: UnderlineInputBorder(),
      enabledBorder: UnderlineInputBorder(),
      focusedBorder: UnderlineInputBorder(),
      filled: false,
      hoverColor: Colors.transparent,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 8),
      labelStyle: TextStyle(fontSize: 14),
      floatingLabelStyle: TextStyle(fontSize: 15),
      hintStyle: TextStyle(fontSize: 13),
      helperStyle: TextStyle(fontSize: 12),
      errorStyle: TextStyle(fontSize: 12),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    ),

    listTileTheme: const ListTileThemeData(
      titleTextStyle: TextStyle(fontSize: 14),
    ),

    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(fontSize: 14),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.hovered)) {
            return const Color.fromARGB(255, 224, 251, 224);
          }
          return Colors.white;
        }),
        elevation: WidgetStateProperty.resolveWith<double?>((states) {
          if (states.contains(WidgetState.disabled)) return 0;
          if (states.contains(WidgetState.hovered)) return 1; // same as normal
          if (states.contains(WidgetState.pressed)) return 1; // or higher if you want
          return 1; // normal
        }),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        foregroundColor: const WidgetStatePropertyAll(Colors.black87),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
