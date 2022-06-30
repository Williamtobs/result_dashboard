import 'package:flutter/material.dart';

class FunctioningButton extends StatelessWidget {
  final String text;
  final bool? load;
  final void Function()? action;

  const FunctioningButton({
    Key? key,
    required this.text,
    this.load,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromRGBO(119, 0, 187, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          child: TextButton(
              onPressed: action,
              child: load == true ?
              const CircularProgressIndicator(color: Colors.white,) :
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ));
  }
}
