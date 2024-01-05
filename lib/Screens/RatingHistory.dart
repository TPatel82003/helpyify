// ignore_for_file: unnecessary_import, unused_import, must_be_immutable, non_constant_identifier_names, avoid_print, prefer_const_constructors, file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpyify/DataModel/RatingChanges.dart';
import 'package:helpyify/Widgets/SomeData.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class RatingHistory extends StatelessWidget {
  final String HandleName;
  int Average_Rank = 0;
  RatingHistory({Key? key, required this.HandleName}) : super(key: key);
  Future<List<RatingChanges>> _getData() async {
    var Data = await http.get(
        Uri.parse("https://codeforces.com/api/user.rating?handle=$HandleName"));
    var JsonData = json.decode(Data.body);
    List<RatingChanges> FinalData = [];
    for (var info in JsonData["result"]) {
      RatingChanges NewInfo = RatingChanges(
          ContestId: info["contestId"],
          ContestName: info["contestName"],
          OldRating: info["oldRating"],
          NewRating: info["newRating"],
          Rank: info["rank"]);
      FinalData.add(NewInfo);
    }
    List<RatingChanges> FinalDataNew = [];
    for (var i = FinalData.length - 1; i >= 0; i--) {
      FinalDataNew.add(FinalData[i]);
    }
    return FinalDataNew;
  }

  Future<void> _launchUrl(int ContestId) async {
    String Contest = ContestId.toString();
    Uri _url = Uri.parse("https://codeforces.com/contest/$Contest");
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $_url';
    }
  }

  ScrollController Sct = ScrollController();
  Widget RatingFec(int NewRating, int OldRating, int Rank) {
    if (NewRating < OldRating) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Rating',
                  style: GoogleFonts.alata(fontSize: 15, color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Text(
                      '$OldRating',
                      style:
                          GoogleFonts.alata(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'To',
                      style:
                          GoogleFonts.alata(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('$NewRating',
                        style: GoogleFonts.alata(
                            color: Colors.white, fontSize: 18)),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      FontAwesomeIcons.arrowAltCircleDown,
                      color: Colors.red,
                      size: 23,
                    ),
                  ],
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.zero,
                child: Text(
                  'Rank',
                  style: GoogleFonts.alata(fontSize: 15, color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Text('$Rank',
                    style:
                        GoogleFonts.alata(color: Colors.white, fontSize: 18)),
              )
            ],
          )
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Rating',
                style: GoogleFonts.alata(fontSize: 15, color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Text(
                    '$OldRating',
                    style: GoogleFonts.alata(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'To',
                    style: GoogleFonts.alata(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('$NewRating',
                      style:
                          GoogleFonts.alata(color: Colors.white, fontSize: 18)),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    FontAwesomeIcons.arrowAltCircleUp,
                    color: Colors.green,
                    size: 23,
                  ),
                ],
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.zero,
              child: Text(
                'Rank',
                style: GoogleFonts.alata(fontSize: 15, color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Text('$Rank',
                  style: GoogleFonts.alata(color: Colors.white, fontSize: 18)),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 25, 28, 49),
      appBar: AppBar(
        title: Text(
          'Contest History',
          style: GoogleFonts.alata(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: Color.fromARGB(255, 25, 28, 49),
        elevation: 0,
        centerTitle: true,
        actions: [],
      ),
      body: FutureBuilder(
        future: _getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: Container(
                  alignment: Alignment.center,
                  color: Color.fromARGB(255, 36, 42, 64),
                  height: MediaQuery.of(context).size.height,
                  child: Lottie.asset('Assests/chart.json',
                          width: 100, height: 100)),
            );
          } else {
            return Column(
              children: [
                SomeData(HandleName: HandleName),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int Index) {
                        return Container(
                          padding: EdgeInsets.all(8),
                          child: Container(
                              height: 220,
                              width: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(255, 36, 42, 64),
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 2),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () => _launchUrl(
                                              snapshot.data[Index].ContestId),
                                          child: Container(
                                              width: 350,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 1.5,
                                                    )),
                                                child: Text(
                                                  snapshot
                                                      .data[Index].ContestName,
                                                  style: GoogleFonts.alata(
                                                      color: Colors.white,
                                                      fontSize: 17),
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 350,
                                    alignment: Alignment.center,
                                    child: RatingFec(
                                        snapshot.data[Index].NewRating,
                                        snapshot.data[Index].OldRating,
                                        snapshot.data[Index].Rank),
                                  )
                                ],
                              )),
                        );
                      }),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
