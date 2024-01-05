// ignore_for_file: unnecessary_import, unused_import, must_be_immutable, non_constant_identifier_names, avoid_print, prefer_const_constructors, file_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpyify/DataModel/SolvedProblems.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProblemSolved extends StatelessWidget {
  final String Handle;
  ProblemSolved({Key? key, required this.Handle}) : super(key: key);
  List<SolvedProblems> DataList = [];
  var Mapped = <String?, int?>{};
  Future<List<SolvedProblems>> _GetData() async {
    try {
      var Data = await http.get(
          Uri.parse("https://codeforces.com/api/user.status?handle=$Handle"));
      var JsonData = json.decode(Data.body);
      for (var Info in JsonData["result"]) {
        if (Info["verdict"] == "OK") {
          for (var i = 0; i < Info["problem"]["tags"].length; i++) {
            if (!Mapped.containsKey(Info["problem"]["tags"][i])) {
              Mapped[Info["problem"]["tags"][i]] = 1;
            } else {
              Mapped[Info["problem"]["tags"][i]] =
                  Mapped[Info["problem"]["tags"][i]]! + 1;
            }
          }
        }
      }
      for (var Name in Mapped.keys) {
        SolvedProblems Svd =
            SolvedProblems(Count: Mapped[Name]!, ProblemType: Name!);
        DataList.add(Svd);
      }
    } catch (e) {
      print(e);
    }
    return DataList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        width: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 36, 42, 64)),
        child: FutureBuilder(
            future: _GetData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  width: 400,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 36, 42, 64)),
                  child: Lottie.asset('Assests/chart.json',
                      width: 100, height: 100),
                );
              } else {
                return Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    direction: Axis.horizontal,
                    children: List.generate(
                        snapshot.data.length,
                        (index) => Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 25, 28, 49),
                                  border: Border.all(
                                      color: Colors.white, width: 0.5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      snapshot.data[index].ProblemType,
                                      style: GoogleFonts.alata(
                                          color: Colors.grey, fontSize: 15),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'x',
                                      style: GoogleFonts.alata(
                                          color: Colors.grey, fontSize: 15),
                                    ),
                                    Text('${snapshot.data[index].Count}',
                                        style: GoogleFonts.alata(
                                          color: Colors.grey,
                                        ))
                                  ]),
                            )));
              }
            }));
  }
}
