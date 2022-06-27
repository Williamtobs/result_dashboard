import 'package:flutter/material.dart';
import 'package:result_board/screen/auth/login/login.dart';
import 'package:result_board/screen/auth/signup/signup.dart';
import 'package:result_board/screen/widget/button.dart';

class OboardingScreen extends StatelessWidget {
  const OboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(186, 186, 255, 1),
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Result Dashoard',
                style: TextStyle(
                  fontSize: 26,
                  color: Color.fromRGBO(119, 0, 187, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Access your semester result by logining to your account\n '
                'or by signing up for a new account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              FunctioningButton(
                  text: 'Login',
                  action: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  }),
              const SizedBox(
                height: 10,
              ),
              FunctioningButton(
                  text: 'Sign up',
                  action: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupScreen()));
                  }),
            ],
          ),
        ));
  }
}
