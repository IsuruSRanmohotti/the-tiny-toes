import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tiny_toes/components/buttons/custom_button.dart';
import 'package:the_tiny_toes/components/text_fields/custom_textfield.dart';
import 'package:the_tiny_toes/providers/user_provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Image.asset('assets/images/tiny_toys.png',
                      height: size.height / 4),
                ),
                CustomTextField(
                    hint: 'User Name', controller: userProvider.userNameController,icon: Icons.person,),
                CustomTextField(
                  hint: 'Password',
                  controller: userProvider.passwordController,
                  isPassword: true,
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Your Password?',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Sign In',
                  onTap: () {
                    userProvider.startSignIn(context);
                  },
                  size: size,
                  bg: Colors.blue,
                  border: Colors.blue,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Dont have an account?'),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: 'Create Account',
                  onTap: () {},
                  size: size,
                  fontColor: Colors.blue,
                  bg: Colors.white,
                  border: Colors.blue,
                  borderWidth: 1,
                ),
              ],
            ),
          ));
    });
  }
}
