import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:result_board/screen/widget/button.dart';
import 'package:result_board/screen/widget/formfield.dart';

import '../../../provider/auth_provider.dart';
import '../../home/dashboard.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool load = false;


  @override
  Widget build(BuildContext context) {
    final model = ref.watch(authRepositoryProvider);
    //final data = ref.watch(fireBaseAuthProvider);

    loading() {
      setState(() {
        load = !load;
      });
    }


    login() async{
      if (!_formKey.currentState!.validate()) {
        return;
      }
      loading();
      await model.signInWithEmailAndPassword(_emailController.text,
          _passwordController.text, context);
      loading();
    }

    return Form(
      key: _formKey,
      child: Scaffold(
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
                  isPassword: false,
                validator: (value){
                  if(value!.isEmpty){
                    return 'field cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CardinFormField(
                hintText: 'Password',
                controller: _passwordController,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                isPassword: true,
                tap: true,
                validator: (value){
                  if(value!.isEmpty){
                    return 'field cannot be empty';
                  }
                  return null;
                },
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
              FunctioningButton(text: 'Login',
                load: load,
                action: (){
                login();
              },),
            ],
          ),
        ),
      ),
    );
  }
}
