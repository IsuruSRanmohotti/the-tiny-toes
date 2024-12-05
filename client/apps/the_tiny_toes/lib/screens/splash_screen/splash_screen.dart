import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
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
