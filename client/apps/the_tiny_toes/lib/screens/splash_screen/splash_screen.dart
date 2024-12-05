import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_tiny_toes/screens/auth_screen/auth_screen.dart';
import 'package:the_tiny_toes/screens/users_screen/users_screen.dart';
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
    SharedPreferencesUtils.loadString('currentUser').then((value) {
         Timer(const Duration(seconds: 3), () {
      
      if(value == ''){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthScreen(),
          ));
      }else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const UsersScreen(),
          ));
      }
      
    });
      },);
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: 'logo',
              child: Image.asset('assets/images/tiny_toys.png')),
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
