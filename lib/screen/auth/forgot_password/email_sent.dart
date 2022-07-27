import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/auth_provider.dart';
import '../../widget/button.dart';

class EmailSent extends ConsumerWidget {
  final String email;
  const EmailSent({Key? key, required this.email}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(authRepositoryProvider);

    sendEmail() async{
      await model.sendPasswordInfo(email: email, context: context);
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(186, 186, 255, 1),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Email has been sent!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                  'Please check your inbox or spam, and click on the received '
                      'link to reset your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14)),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/mail_sent.png',
              height: 250,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: FunctioningButton(
                text: 'Login',
                //load: load,
                action: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: (){
                sendEmail();
              },
              child: const Text("Didn't receive the link? Resend.",
                  style: TextStyle(fontSize: 14)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
