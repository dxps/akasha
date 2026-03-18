import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_flutter/screens/access_levels_screen.dart';
import 'package:akasha_flutter/screens/attr_tmpls_list_screen.dart';
import 'package:akasha_flutter/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'screens/greetings_screen.dart';

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

  // When you are running the app on a physical device, you need to set the
  // server URL to the IP address of your computer. You can find the IP
  // address by running `ipconfig` on Windows or `ifconfig` on Mac/Linux.
  //
  // You can set the variable when running or building your app like this:
  // E.g. `flutter run --dart-define=SERVER_URL=https://api.example.com/`.
  //
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
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const NoTransitionPage(child: MyHomePage(title: 'Akasha')),
    ),
    GoRoute(
      path: '/attr_tmpls',
      pageBuilder: (context, state) => const NoTransitionPage(child: AttributeTmplsScreen()),
    ),
    GoRoute(
      path: '/access_levels',
      pageBuilder: (context, state) => const NoTransitionPage(child: AccessLevelsScreen()),
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
      title: 'Akasha',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[200],
        dataTableTheme: DataTableThemeData(
          headingTextStyle: const TextStyle(color: Colors.grey),
          dataRowMinHeight: 30,
          dataRowMaxHeight: 30,
          dividerThickness: 0.25,
          headingRowHeight: 30,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      // home: const MyHomePage(title: 'Akasha'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.transparent),
      // body: const GreetingsScreen(),
      // To test authentication in this example app, uncomment the line below
      // and comment out the line above. This wraps the GreetingsScreen with a
      // SignInScreen, which automatically shows a sign-in UI when the user is
      // not authenticated and displays the GreetingsScreen once they sign in.
      //
      body: Center(
        child: SignInScreen(
          child: GreetingsScreen(
            onSignOut: () async {
              await client.auth.signOutDevice();
            },
          ),
        ),
      ),
    );
  }
}
