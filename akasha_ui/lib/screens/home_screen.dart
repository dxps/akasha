import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/screens/sign_in_screen.dart';
import 'package:akasha_ui/widgets/top_header.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class HomeScreen extends StatelessWidget {
  final Client client;
  const HomeScreen({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The content is wrapped in a SignInScreen, which automatically shows a sign-in UI
      // when the user is not authenticated, and displays otherwise.
      body: Column(
        children: [
          const TopHeader(),
          Image.asset('images/logo_o_light_grey.png', width: 200, height: 200),
          Center(
            child: SignInScreen(
              child: Column(
                children: [
                  if (client.auth.isAuthenticated) ...[
                    const Text('Welcome!'),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () async {
                        await client.auth.signOutDevice();
                      },
                      style: TextButton.styleFrom(backgroundColor: Colors.transparent, textStyle: const TextStyle(fontSize: 13)),
                      child: const Text('Sign out'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
