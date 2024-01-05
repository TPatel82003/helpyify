// ignore_for_file: unnecessary_import, unused_import, must_be_immutable, non_constant_identifier_names, avoid_print, prefer_const_constructors, file_names

import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpyify/DataModel/ChartDataProblems.dart';
import 'package:helpyify/DataModel/RatingChart.dart';
import 'package:helpyify/DataModel/TypeOfproblem.dart';
import 'package:helpyify/Widgets/BarChart.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RatingGraph extends StatelessWidget {
  final String HandleName;
  RatingGraph({Key? key, required this.HandleName}) : super(key: key);
  List<int> Rating = [];
  List<RatingChart> Ans = [];
  int Count = 1;
  Future<List<RatingChart>> _Values() async {
    try {
      var Data = await http.get(Uri.parse(
          "https://codeforces.com/api/user.rating?handle=$HandleName"));
      var JsonData = json.decode(Data.body);

      for (var Info in JsonData["result"]) {
        Rating.add(Info["newRating"]);
      }
    } catch (e) {
      print(e);
    }
    List<int> Temp = [];
    for (var i = Rating.length - 1; i >= 0 && Count <= 10; i--) {
      Temp.add(Rating[i]);

      if (Rating[i] >= 3000) {
        RatingChart Cnew = RatingChart(Rating: Rating[i], Index: Count ,PointColor: Color.fromARGB(255, 244, 106, 96));
        Ans.add(Cnew);
      } else if (Rating[i] >= 2600 && Rating[i] <= 2999) {
        RatingChart Cnew = RatingChart(Rating: Rating[i], Index: Count, PointColor: Color.fromARGB(255, 244, 106, 96));
        Ans.add(Cnew);
      } else if (Rating[i] >= 2400 && Rating[i] <= 2599) {
        RatingChart Cnew = RatingChart(Rating: Rating[i], Index: Count, PointColor:Color.fromARGB(255, 244, 106, 96));
        Ans.add(Cnew);
      } else if (Rating[i]>= 2300 && Rating[i] <= 2399) {
        RatingChart Cnew = RatingChart(Rating: Rating[i], Index: Count, PointColor:Color.fromARGB(255, 255, 165, 4));
        Ans.add(Cnew);
      } else if (Rating[i] >= 2100 && Rating[i] <= 2299) {
        RatingChart Cnew = RatingChart(Rating: Rating[i], Index: Count, PointColor:Color.fromARGB(255, 250, 174, 239));
        Ans.add(Cnew);
      } else if (Rating[i] >= 1900 && Rating[i] <= 2099) {
        RatingChart Cnew = RatingChart(Rating: Rating[i], Index: Count, PointColor:Color.fromARGB(255, 250, 174, 239));
        Ans.add(Cnew);
      } else if (Rating[i] >= 1600 && Rating[i] <= 1899) {
        RatingChart Cnew = RatingChart(Rating: Rating[i], Index: Count, PointColor:Color.fromARGB(255, 175, 174, 255));
        Ans.add(Cnew);
      } else if (Rating[i]>= 1400 && Rating[i] <= 1599) {
        RatingChart Cnew = RatingChart(Rating: Rating[i], Index: Count, PointColor:Color.fromARGB(255, 3, 168, 158));
        Ans.add(Cnew);
      } else if (Rating[i] >= 1200 && Rating[i] <= 1399) {
        RatingChart Cnew = RatingChart(Rating: Rating[i], Index: Count, PointColor:Color.fromARGB(255, 0, 128, 60));
        Ans.add(Cnew);
      } else {
        RatingChart Cnew = RatingChart(Rating: Rating[i], Index: Count, PointColor:Colors.grey);
        Ans.add(Cnew);
      }
      Count++;
    }
    Ans = Ans.reversed.toList();
    return Ans;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 300,
        width: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 36, 42, 64)),
        child: FutureBuilder(
            future: _Values(),
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
                return ListView.builder(
                    itemCount: 1,
                    //scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int Index) {
                      return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          width: 350,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.infoCircle,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Text(
                                      'Scroll Graph To view More',
                                      style:
                                          GoogleFonts.alata(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              BarChart(
                                GrapValue: Ans,
                              )
                            ],
                          ));
                    });
              }
            }));
  }
}
