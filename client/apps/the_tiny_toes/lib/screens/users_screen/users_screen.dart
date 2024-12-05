import 'package:flutter/material.dart';
import 'package:the_tiny_toes/utils/shared_preferences_utils.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: FilledButton(
            onPressed: () {
              SharedPreferencesUtils.deleteString('currentUser');
            },
            child: const Text('logout')),
      ),
    );
  }
}
