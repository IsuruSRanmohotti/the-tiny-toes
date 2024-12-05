import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tiny_toes/providers/user_provider.dart';
import 'package:the_tiny_toes/screens/auth_screen/auth_screen.dart';
import 'package:the_tiny_toes/screens/main_screen/main_screen.dart';
import 'package:the_tiny_toes/utils/shared_preferences_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SharedPreferencesUtils.loadString('currentUser').then(
      (value) {
        Timer(const Duration(seconds: 3), () {
          Provider.of<UserProvider>(context, listen: false)
              .setCurrentUser(value);

          if (value == '') {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthScreen(),
                ));
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ));
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Hero(
                tag: 'logo', child: Image.asset('assets/images/tiny_toys.png')),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CupertinoActivityIndicator(
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'From ',
                      style: TextStyle(color: Colors.grey.shade900),
                    ),
                    Image.asset(
                      'assets/images/3axis-word.png',
                      height: 20,
                    ),
                  ],
                ),
              ],
            )),
          )
        ],
      ),
    );
  }
}
