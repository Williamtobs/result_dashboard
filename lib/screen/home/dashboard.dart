import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.menu,
            color: Color.fromRGBO(119, 0, 187, 1),
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
              GridView.builder(
                  itemCount: _options.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return OptionCard(
                      term: _options[index].term,
                    );
                  })
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
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Card(
            child: Image.asset('assets/dashboard.png'),
            shape: Border.all(
              color: const Color.fromRGBO(186, 186, 255, 1),
            ),
            elevation: 1,
          ),
        ),
        const SizedBox(height: 5),
        Text(term),
      ],
    );
  }
}
