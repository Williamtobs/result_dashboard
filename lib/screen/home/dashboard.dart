import 'package:flutter/material.dart';
import 'package:result_board/screen/home/result/result_screen.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(119, 0, 187, 1),
          leading: const Icon(
            Icons.menu,
            color:  Color.fromRGBO(186, 186, 255, 1),
          ),
          elevation: 0,
        ),
        body: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(height: 30),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/avatar.png'),
                radius: 100,
              ),
              const SizedBox(height: 10),
              const Text(
                'Hi Temitayo Daniel',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              const Text(
                '201925820050',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                    itemCount: _options.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return OptionCard(
                        term: _options[index].term,
                      );
                    }),
              )
            ]));
  }
}

const List<OptionCard> _options = [
  OptionCard(term: 'ND I First Semester'),
  OptionCard(term: 'ND I Second Semester'),
  OptionCard(term: 'ND II First Semester'),
  OptionCard(term: 'ND II Second Semester'),
];

class OptionCard extends StatelessWidget {
  final String term;
  const OptionCard({Key? key, required this.term}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return ResultScreen(
                title: term,
              );
            }));
          },
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Card(
              child: Image.asset('assets/dashboard.png'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color:  Color.fromRGBO(186, 186, 255, 1),)
              ),
              elevation: 1,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(term),
      ],
    );
  }
}
