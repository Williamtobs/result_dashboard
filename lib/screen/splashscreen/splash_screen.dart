import 'package:flutter/material.dart';

import '../auth/auth_checker.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 7), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const AuthChecker()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(186, 186, 255, 1),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/onboard.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          const SizedBox(height: 20),
          const Text(
            'Result Dashboard',
            style: TextStyle(
              fontSize: 30,
              color: Color.fromRGBO(119, 0, 187, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
      ),
    );
  }
}
