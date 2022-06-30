import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:result_board/screen/auth/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:result_board/screen/widget/button.dart';
import 'package:result_board/screen/widget/formfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/auth_provider.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _matricNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DateTime? selectedDate;
  final _formKey = GlobalKey<FormState>();
  bool load = false;

  String? date;

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(authRepositoryProvider);
    final data = ref.watch(fireBaseAuthProvider);

    loading() {
      setState(() {
        load = !load;
      });
    }

    signUp() async{
      await model.signUpWithEmailAndPassword(_emailController.text,
          _passwordController.text, context).whenComplete(() {
            model.authStateChange.listen((event) {
              storeDetails(data.currentUser!.uid, _firstNameController.text,
                  _lastNameController.text, _matricNoController.text,
                  date!, _emailController.text,
                  _phoneController.text);
              if (event == null) {
                return;
              }
            });
      });
    }

    checkMatricUp(String matric) async {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      loading();
      var collection = FirebaseFirestore.instance.collection('Matric id');
      final doc = await collection.doc(matric).get();
      if(doc.exists){
        signUp();
        loading();
      }
      else{
        loading();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Matric number not found on database, Visit '
              'student center to register as student'),
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () { },
          ),
        ));
      }
    }

    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(186, 186, 255, 1),
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/signup.png',
                            ),
                            fit: BoxFit.fill))),
                // Image.asset(
                //   'assets/signup.png',
                // ),
                CardinFormField(
                    hintText: 'First Name',
                    controller: _firstNameController,
                    keyboardType: TextInputType.text,
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
                    hintText: 'Last Name',
                    controller: _lastNameController,
                    keyboardType: TextInputType.text,
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
                    hintText: 'Matric Number',
                    controller: _matricNoController,
                    keyboardType: TextInputType.text,
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
                DateTimeField(
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: const EdgeInsets.all(15),
                    hintText: 'D.O.B',
                    fillColor: const Color.fromARGB(255, 240, 240, 240),
                    prefixIcon: const Icon(
                      Icons.calendar_today,
                      color: Color.fromRGBO(119, 0, 187, 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  onDateSelected: (DateTime value) {
                    setState(() {
                      selectedDate = value;
                      //String date = selectedDate.toString();
                      date = '${selectedDate.toString().characters.take(10)}';
                    });
                  },
                  selectedDate: selectedDate,
                ),
                const SizedBox(height: 10),
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
                    hintText: 'Phone Number',
                    controller: _phoneController,
                    keyboardType: TextInputType.text,
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
                const SizedBox(height: 20),
                FunctioningButton(
                  text: 'Sign up',
                  load: load,
                  action: () {
                    checkMatricUp(_matricNoController.text.trim());
                  },
                ),
                const SizedBox(height: 20),
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                    text: 'Have an account already? ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Login.',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(119, 0, 187, 1),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                  ),
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

storeDetails(String userId, String firstName, String lastName,
    String matric, String dob, String email, String phone) async {
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  await ref.doc(userId).set({
    'id' : userId,
    'first_name' : firstName,
    'last_name' : lastName,
    'matric' : matric,
    'dob' : dob,
    'email' : email,
    'phone' : phone,

  });
}






