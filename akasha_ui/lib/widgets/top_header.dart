import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      child: SizedBox(
        height: 36,
        child: Row(
          children: [
            const SizedBox(width: 2),
            InkWell(
              hoverColor: Colors.transparent,
              onTap: () => context.go('/'),
              child: Image.asset('images/logo_o_light_grey.png', width: 34, height: 34),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                context.go('/');
              },
              style: TextButton.styleFrom(backgroundColor: Colors.transparent, textStyle: const TextStyle(fontSize: 13)),
              child: const Text('Home'),
            ),
            TextButton(
              onPressed: () {
                context.go('/attribute_templates');
              },
              style: TextButton.styleFrom(backgroundColor: Colors.transparent, textStyle: const TextStyle(fontSize: 13)),
              child: const Text('Attribute Templates'),
            ),
            TextButton(
              onPressed: () {
                context.go('/access_levels');
              },
              style: TextButton.styleFrom(backgroundColor: Colors.transparent, textStyle: const TextStyle(fontSize: 13)),
              child: const Text('Access Levels'),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
