import 'package:flutter/material.dart';
import 'package:result_board/screen/widget/button.dart';
import 'package:result_board/screen/widget/formfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(186, 186, 255, 1),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/login.png',
            ),
            const SizedBox(height: 30),
            CardinFormField(
                hintText: 'Email Address',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                isPassword: false),
            const SizedBox(height: 10),
            CardinFormField(
              hintText: 'Password',
              controller: _passwordController,
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              isPassword: true,
              tap: true,
            ),
            const SizedBox(height: 10),
            const Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            const SizedBox(height: 20),
            const FunctioningButton(text: 'Login'),
          ],
        ),
      ),
    );
  }
}
