import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/auth_provider.dart';
import '../../widget/button.dart';
import '../../widget/formfield.dart';
import 'email_sent.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool load = false;

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(authRepositoryProvider);

    loading() {
      setState(() {
        load = !load;
      });
    }

    sendEmail() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      loading();
      await model
          .sendPasswordInfo(email: _emailController.text, context: context)
          .then((value) => loading());
    }

    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(186, 186, 255, 1),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Forgot Password?',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                        'Enter your registered email below to receive '
                        'password reset instruction',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14)),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/forgot_password.png',
                    height: 250,
                  ),
                  const SizedBox(height: 20),
                  CardinFormField(
                    hintText: 'Email Address',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    isPassword: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'field cannot be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Remember Password? Login.',
                        style: TextStyle(fontSize: 14)),
                  ),
                  const SizedBox(height: 30),
                  FunctioningButton(
                    text: 'Send',
                    load: load,
                    action: () {
                      sendEmail();
                      //login();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
