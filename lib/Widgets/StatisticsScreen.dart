// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpyify/DataModel/ChartData.dart';
import 'package:helpyify/DataModel/Statistics.dart';
import 'package:helpyify/DataModel/SubmissionDetails.dart';
import 'package:helpyify/Screens/SubmissionHistory.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsScreen extends StatelessWidget {
  late List<ChartData> ForBar = [];
  final String HandleName;
  StatisticsScreen({super.key, required this.HandleName});
  Future<List<Statistics>> _Values() async {
    var Data = await http.get(
        Uri.parse("https://codeforces.com/api/user.status?handle=$HandleName"));
    var JsonData = json.decode(Data.body);
    int CountOk = 0;
    int CountNotOk = 0;
    int Tle = 0;
    int Mle = 0;
    int Comp = 0;
    int Wrong = 0;
    List<String> AlreadySolved = [];
    for (var Info in JsonData["result"]) {
      if (Info["verdict"] == "OK" &&
          !AlreadySolved.contains(Info["problem"]["name"])) {
        CountOk = CountOk + 1;
        AlreadySolved.add(Info["problem"]["name"]);
      } else if (Info["verdict"] != "OK") {
        if (Info["verdict"] == "COMPILATION_ERROR") {
          Comp = Comp + 1;
        }
        if (Info["verdict"] == "MEMORY_LIMIT_EXCEEDED") {
          Mle = Mle + 1;
        }
        if (Info["verdict"] == "TIME_LIMIT_EXCEEDED") {
          Tle = Tle + 1;
        }
        if (Info["verdict"] == "WRONG_ANSWER") {
          Wrong = Wrong + 1;
        }
        CountNotOk = CountNotOk + 1;
      }
    }
    Statistics St = Statistics(
        Accepted: CountOk,
        Rejected: CountNotOk,
        Compilation: Comp,
        Timelimit: Tle,
        Memorylimit: Mle,
        Wrong: Wrong);
    ChartData Ch = ChartData(
      Name: "AC",
      Value: CountOk,
    );
    ForBar.add(Ch);
    Ch = ChartData(
      Value: Wrong,
      Name: "WA",
    );
    ForBar.add(Ch);
    Ch = ChartData(
      Value: Tle,
      Name: "TLE",
    );
    ForBar.add(Ch);
    Ch = ChartData(
      Value: Mle,
      Name: "MLE",
    );
    ForBar.add(Ch);

    List<Statistics> Ans = [];
    Ans.add(St);
    return Ans;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 500,
        width: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 36, 42, 64)),
        child: FutureBuilder(
            future: _Values(),
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Submissions',
                              style: GoogleFonts.alata(
                                  fontSize: 24,
                                  color:
                                      const Color.fromARGB(255, 177, 174, 174)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: IconButton(
                                  icon: Icon(FontAwesomeIcons.history),
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SubmissionHistory(
                                                HandleName: HandleName,
                                              ))),
                                  color: Color.fromARGB(255, 177, 174, 174)),
                            )
                          ],
                        )),
                    Container(
                      alignment: Alignment.topLeft,
                      height: 250,
                      width: 250,
                      child: SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          series: <ChartSeries>[
                            BarSeries<ChartData, String>(
                                dataSource: ForBar,
                                borderRadius: BorderRadius.circular(10),
                                xValueMapper: (ChartData data, _) => data.Name,
                                yValueMapper: (ChartData data, _) => data.Value,
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    textStyle:
                                        GoogleFonts.alata(color: Colors.white)))
                          ],
                          primaryXAxis: CategoryAxis(
                            majorGridLines: MajorGridLines(width: 0),
                            //Hide the axis line of x-axis
                            axisLine: AxisLine(width: 0),
                          ),
                          primaryYAxis: NumericAxis(isVisible: false)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          height: 110,
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text('Accepted',
                                      style: GoogleFonts.alata(
                                          fontSize: 18,
                                          color: const Color.fromARGB(
                                              255, 177, 174, 174))),
                                ],
                              ),
                              Container(
                                width: 25,
                                height: 0,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                              ),
                              Text('${snapshot.data[0].Accepted}',
                                  style: GoogleFonts.alata(
                                      fontSize: 17, color: Colors.white))
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          height: 110,
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text('Rejected',
                                      style: GoogleFonts.alata(
                                          fontSize: 18,
                                          color: const Color.fromARGB(
                                              255, 177, 174, 174))),
                                ],
                              ),
                              Container(
                                width: 25,
                                height: 0,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                              ),
                              Text('${snapshot.data[0].Rejected}',
                                  style: GoogleFonts.alata(
                                      fontSize: 17, color: Colors.white))
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }
            }));
  }
}
