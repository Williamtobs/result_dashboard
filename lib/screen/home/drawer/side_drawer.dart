import 'package:flutter/material.dart';
import 'package:result_board/screen/auth/onboarding.dart';

import '../../../repository/auth_repository.dart';
import '../../widget/button.dart';

class Drawers extends StatefulWidget {
  const Drawers({Key? key}) : super(key: key);

  @override
  State<Drawers> createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  AuthRepositoryImpl press = AuthRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    logOut() {
      press.signOut();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Logged out of Account'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      ));
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return const OboardingScreen();
      }), (route) => false);
    }

    return Drawer(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(186, 186, 255, 1),
        //backgroundColor: const Color.fromRGBO(119, 0, 187, 1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: FunctioningButton(
                text: 'Log out',
                action: () {
                  logOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
