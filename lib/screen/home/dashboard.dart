import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:result_board/screen/home/result/result_screen.dart';

import '../../provider/auth_provider.dart';
import 'drawer/side_drawer.dart';

class Dashboard extends ConsumerWidget {
  Dashboard({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(fireBaseAuthProvider);

    Future<DocumentSnapshot> getInfo() async {
      var fireStore = FirebaseFirestore.instance;
      DocumentSnapshot snapshot =
          await fireStore.collection('users').doc(data.currentUser!.uid).get();
      return snapshot;
    }

    return Scaffold(
      key: _key,
      drawer: const Drawers(),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(119, 0, 187, 1),
          leading: InkWell(
            onTap: (){
              _key.currentState!.openDrawer();
            },
            child: const Icon(
              Icons.menu,
              color: Color.fromRGBO(186, 186, 255, 1),
            ),
          ),
          elevation: 0,
        ),
        body: FutureBuilder<DocumentSnapshot>(
            future: getInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<OptionCard> _options = [
                  OptionCard(
                    term: 'ND I First Semester',
                    file: 'NdI_first',
                    examType: 'nd1 first semester',
                    matricNum: snapshot.data!["matric"],
                  ),
                  OptionCard(
                    term: 'ND I Second Semester',
                    file: 'NdI_second',
                    examType: 'nd1 second semester',
                    matricNum: snapshot.data!["matric"],
                  ),
                  OptionCard(
                    term: 'ND II First Semester',
                    file: 'NdII_first',
                    examType: 'nd2 first semester',
                    matricNum: snapshot.data!["matric"],
                  ),
                  OptionCard(
                    term: 'ND II Second Semester',
                    file: 'NdII_second',
                    examType: 'nd2 second semester',
                    matricNum: snapshot.data!["matric"],
                  ),
                ];

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(119, 0, 187, 1),
                    ),
                  );
                } else {
                  final firstName = snapshot.data!["first_name"];
                  final lastName = snapshot.data!["last_name"];
                  final matric = snapshot.data!["matric"];
                  return Column(children: [
                    const SizedBox(height: 30),
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/avatar.png'),
                      radius: 100,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$firstName $lastName',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Matric No: $matric',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: GridView.builder(
                          itemCount: _options.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return OptionCard(
                              examType: _options[index].examType,
                              term: _options[index].term,
                              file: _options[index].file,
                              matricNum: _options[index].matricNum,
                            );
                          }),
                    )
                  ]);
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(119, 0, 187, 1),
                  ),
                );
              }
            }));
  }
}


class OptionCard extends StatelessWidget {
  final String term;
  final String file;
  final String examType;
  final String matricNum;

  const OptionCard(
      {Key? key,
      required this.term,
      required this.file,
      required this.examType,
      required this.matricNum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ResultScreen(
                examType: examType,
                title: term,
                file: file,
                matricNum: matricNum,
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
                  side: const BorderSide(
                    color: Color.fromRGBO(186, 186, 255, 1),
                  )),
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
