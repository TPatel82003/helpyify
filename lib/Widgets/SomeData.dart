// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpyify/DataModel/ContestData.dart';
import 'package:helpyify/DataModel/RatingChanges.dart';
import 'package:helpyify/Widgets/Rating.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class SomeData extends StatelessWidget {
  final String HandleName;
  const SomeData({Key? key, required this.HandleName}) : super(key: key);
  Future<List<ContestData>> _getData() async {
    List<ContestData> Ans = [];
    try {
      var Data = await http.get(Uri.parse(
          "https://codeforces.com/api/user.rating?handle=$HandleName"));
      var JsonData = json.decode(Data.body);
      var CountSubmission = <String?, int?>{};
      int MaxRank = 100000, MinRank = 0;
      int MaxUp = 0, MaxDown = 0;

      for (var info in JsonData["result"]) {
        MaxRank = min(MaxRank, info["rank"]);
        MinRank = max(MinRank, info["rank"]);
        MaxUp = max(MaxUp, info["newRating"] - info["oldRating"]);
        if (info["newRating"] < info["oldRating"]) {
          MaxDown = max(MaxDown, info["oldRating"] - info["newRating"]);
        }
      }
      ContestData Ctd = ContestData(
          MaxDown: MaxDown, MaxRank: MaxRank, MaxUp: MaxUp, MinRank: MinRank);
      Ans.add(Ctd);
    } catch (e) {
      print(e);
    }
    return Ans;
  }

  Widget DataContainer(String Data, int Value) {
    if (Data == "Max Down") {
      return Container(
          padding: EdgeInsets.all(10),
          height: 100,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(Data,
                      style: GoogleFonts.alata(
                          fontSize: 18,
                          color: Color.fromARGB(255, 177, 174, 174))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.minus,
                        color: Colors.red,
                        size: 10,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('${Value}',
                          style: GoogleFonts.alata(
                              fontSize: 18, color: Colors.white))
                    ],
                  )
                ]),
          ));
    } else if (Data == "Max Up") {
      return Container(
          padding: EdgeInsets.all(10),
          height: 100,
          decoration: BoxDecoration(color: Color.fromARGB(255, 36, 42, 64) , borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(Data,
                      style: GoogleFonts.alata(
                          fontSize: 18,
                          color: Color.fromARGB(255, 177, 174, 174))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.plus,
                        color: Colors.green,
                        size: 10,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('${Value}',
                          style: GoogleFonts.alata(
                              fontSize: 18, color: Colors.white))
                    ],
                  )
                ]),
          ));
    }
    return Container(
        padding: EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(color: Color.fromARGB(255, 36, 42, 64) , borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(Data,
                    style: GoogleFonts.alata(
                        fontSize: 18,
                        color: Color.fromARGB(255, 177, 174, 174))),
                Text('${Value}',
                    style: GoogleFonts.alata(fontSize: 18, color: Colors.white))
              ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: FutureBuilder(
            future: _getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  height: 500,
                  width: 400,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 36, 42, 64)),
                  child: Lottie.asset('Assests/chart.json',
                      width: 100, height: 100),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int Index) {
                      return Container(
                        height: 150,
                        width: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DataContainer(
                                    "Best Rank", snapshot.data[Index].MaxRank),
                                DataContainer(
                                    "Worst Rank", snapshot.data[Index].MinRank),
                                     DataContainer(
                                    "Max Up", snapshot.data[Index].MaxUp),
                              ],
                            ),
                          
                          ],
                        ),
                      );
                    });
              }
            }));
  }
}
