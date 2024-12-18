import 'package:flutter/material.dart';
import 'package:the_tiny_toes/screens/auth_screen/auth_screen.dart';
import 'package:the_tiny_toes/utils/custom_dialog.dart';
import 'package:the_tiny_toes/utils/shared_preferences_utils.dart';

import '../screens/main_screen/main_screen.dart';

class UserProvider extends ChangeNotifier {
  String? _currentUser;
  String? get currentUser => _currentUser;

  final TextEditingController _userNameController =
      TextEditingController(text: '3axis');
  TextEditingController get userNameController => _userNameController;

  final TextEditingController _passwordController =
      TextEditingController(text: '123456');
  TextEditingController get passwordController => _passwordController;

  void setCurrentUser(String currentUserName) {
    _currentUser = currentUserName;
    notifyListeners();
  }

  Future<void> startSignIn(BuildContext context) async {
    if (_userNameController.text.trim().length < 3) {
      CustomDialog.cupertinoAlert(
          context: context,
          title: "Oops!",
          subtitle: 'User name must be at least 3 characters long.');
    } else if (_passwordController.text.trim().length < 6) {
      CustomDialog.cupertinoAlert(
          context: context,
          title: "Oops!",
          subtitle: 'Password must be at least 6 characters long.');
    } else {
      SharedPreferencesUtils.saveString(
              key: 'currentUser', value: _userNameController.text.trim())
          .then(
        (value) {
          if (context.mounted) {
            _currentUser = _userNameController.text.trim();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ));
          }
        },
      );
    }
  }

  Future<void> signOutUser(BuildContext context) async {
    CustomDialog.cupertinoAlert(
      context: context,
      title: 'Are You Sure?',
      buttonText: 'Logout',
      cancelButton: 'Cancel',
      onProceed: () async {
        await SharedPreferencesUtils.deleteString('currentUser').then(
          (value) {
            if (context.mounted) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AuthScreen()));
            }
          },
        );
      },
      onCancel: () {
        Navigator.pop(context);
      },
    );
  }
}
