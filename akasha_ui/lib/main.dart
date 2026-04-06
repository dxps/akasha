import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/attribute_template/attr_tmpl_repo.dart';
import 'package:akasha_ui/attribute_template/attr_tmpls_logic.dart';
import 'package:akasha_ui/entity/ent_repo.dart';
import 'package:akasha_ui/entity/ents_cubit.dart';
import 'package:akasha_ui/entity_template/ent_tmpl_repo.dart';
import 'package:akasha_ui/entity_template/ent_tmpls_cubit.dart';
import 'package:akasha_ui/routing.dart';
import 'package:akasha_ui/theming/init_theme.dart';
import 'package:akasha_ui/theming/theme_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
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

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorageDirectory.web : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  if (kIsWeb) {
    usePathUrlStrategy();
  }

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

  initRouter(client);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),

        BlocProvider(
          create: (_) {
            final repo = AttributeTemplateRepo(client: client);
            return AttributeTemplatesLogic(repo: repo);
          },
        ),

        BlocProvider(
          create: (_) {
            final repo = EntityTemplateRepo(client: client);
            return EntityTemplatesCubit(repo: repo);
          },
        ),

        RepositoryProvider(
          create: (_) {
            final repo = EntityRepo(client);
            return EntitiesCubit(repo);
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          title: '',
          themeMode: themeMode,
          theme: initThemeData(Brightness.light),
          darkTheme: initThemeData(Brightness.dark),
        );
      },
    );
  }
}
