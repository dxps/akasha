import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/screens/greetings_screen.dart';
import 'package:akasha_ui/screens/sign_in_screen.dart';
import 'package:akasha_ui/widgets/layout_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class HomeScreen extends StatelessWidget {
  final Client client;
  const HomeScreen({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: const GreetingsScreen(),
      // This wraps the GreetingsScreen with a SignInScreen, which automatically
      // shows a sign-in UI when the user is not authenticated and displays
      // the GreetingsScreen once they sign in.
      body: Column(
        children: [
          TopHeader(),
          Center(
            child: SignInScreen(
              child: GreetingsScreen(
                onSignOut: () async {
                  await client.auth.signOutDevice();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
