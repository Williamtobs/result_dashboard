import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';

class ResultScreen extends StatefulWidget {
  final String title;
  final String file;
  final String examType;
  final String matricNum;

  const ResultScreen(
      {Key? key,
      required this.title,
      required this.file,
      required this.examType,
      required this.matricNum})
      : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    Future<DocumentSnapshot> getInfo() async {
      var fireStore = FirebaseFirestore.instance;
      DocumentSnapshot snapshot =
          await fireStore.collection('Matric id').doc(widget.matricNum).get();
      return snapshot;
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(119, 0, 187, 1),
        onPressed: () {
          screenshotController.capture().then((Uint8List? image) {
            printPdf(image!, context, widget.file);
          }).catchError((onError) {});
        },
        child: const Icon(
          Icons.print,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(119, 0, 187, 1),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(186, 186, 255, 1),
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.title + ' Result',
          style: const TextStyle(color: Color.fromRGBO(186, 186, 255, 1)),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: getInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(119, 0, 187, 1),
                  ),
                );
              } else {
                if(snapshot.data![widget.examType].isEmpty){
                  return const Center(
                    child: Text("Result for this term is not available yet"),
                  );
                }
                else{
                  final data = snapshot.data![widget.examType];
                  return Screenshot(
                    controller: screenshotController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(119, 0, 187, 1),
                          ),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: const [
                              Expanded(
                                  child: Text(
                                    'Course',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              Text(
                                'Test',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'CA',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Exam',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Total',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ResultTile(
                                course: data[index]['course'],
                                test: data[index]['test'],
                                ca: data[index]['ca'],
                                exam: data[index]['exam'],
                                total: data[index]['total'],
                              );
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Text(
                            'Click on the Print icon to download your result '
                                'as pdf version',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            }
            else if (!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(119, 0, 187, 1),
                ),
              );
            }
            else{
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(119, 0, 187, 1),
                ),
              );
            }
          }),
    );
  }
}

class ResultTile extends StatelessWidget {
  final String course;
  final num test;
  final num ca;
  final num exam;
  final num total;

  const ResultTile(
      {Key? key,
      required this.course,
      required this.test,
      required this.ca,
      required this.exam,
      required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
                child: Text(
              course,
              style: const TextStyle(color: Colors.black),
            )),
            Text(
              '$test',
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '$ca',
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '$exam',
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '$total',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

Future printPdf(Uint8List screenShot, BuildContext context, String name) async {
  pw.Document pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Expanded(
            child: pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.fill));
      },
    ),
  );
  File pdfFile = File('/storage/emulated/0/Download/$name.pdf');
  pdfFile.writeAsBytesSync(await pdf.save());
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: const Text('File successfully saved.'),
    duration: const Duration(seconds: 2),
    action: SnackBarAction(
      label: 'Close',
      onPressed: () {},
    ),
  ));
}
