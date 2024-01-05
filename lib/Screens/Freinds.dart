import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpyify/DataModel/ApiData.dart';
import 'package:helpyify/DataModel/toprated.dart';
import 'package:helpyify/Screens/DashBoard.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:country_flags/country_flags.dart';

class Freinds extends StatelessWidget {
  final String UserName;
  Freinds({Key? key, required this.UserName}) : super(key: key);
  Future<List<topers>> _getData() async {
    List<topers> FinalData = [];
    var Data;
    var JsonData;
    try {
      Data = await http.get(Uri.parse(
          "https://codeforces.com/api/user.ratedList?activeOnly=true&includeRetired=false;"));
      if (Data.statusCode != 200) throw HttpException('${Data.statusCode}');
      JsonData = json.decode(Data.body);
    } on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print('Could Not Find Handle 😑');
    } on FormatException {
      print("No Fuck Given 🖕");
    }
    int max = 100;
    for (var info in JsonData["result"]) {
      topers NewInfo = topers(
        Handle: info["handle"],
        Rating: info["rating"],
        Rank: info["rank"],
        MaxRank: info["maxRank"],
        MaxRating: info["maxRating"],
        Freinds: info["friendOfCount"],
        Cont: info["contribution"],
      );
      FinalData.add(NewInfo);
      max--;
      if (max <= 0) break;
    }
    return FinalData;
  }

  Widget isUp(int current, int max) {
    if (current >= max) {
      return Icon(
        FontAwesomeIcons.arrowAltCircleUp,
        color: Colors.green,
        size: 20,
      );
    }
    return Icon(
      FontAwesomeIcons.arrowAltCircleDown,
      color: Colors.red,
      size: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          floating: true,
          snap: true,
          title: Text(
            'Top Rated',
            style: GoogleFonts.alata(color: Colors.white, fontSize: 22),
          ),
          backgroundColor: Color.fromARGB(255, 25, 28, 49),
          elevation: 0,
          centerTitle: true,
        )
      ],
      body: Scaffold(
          backgroundColor: Color.fromARGB(255, 25, 28, 49),
          body: FutureBuilder(
              future: _getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: Container(
                        alignment: Alignment.center,
                        color: Color.fromARGB(255, 25, 28, 49),
                        height: MediaQuery.of(context).size.height,
                        child: Lottie.asset('Assests/chart.json',
                            width: 100, height: 100)),
                  );
                }
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 36, 42, 64),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => DashBoard(
                                                    HandleName: snapshot
                                                        .data[index].Handle))),
                                        child: Text(
                                          '${snapshot.data[index].Handle}',
                                          style: GoogleFonts.alata(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Rank',
                                        style: GoogleFonts.alata(
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        'Ranking',
                                        style: GoogleFonts.alata(
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        'Rating',
                                        style: GoogleFonts.alata(
                                            color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${index + 1}',
                                        style: GoogleFonts.alata(
                                            color: Colors.white),
                                      ),
                                      Text(
                                        '${snapshot.data[index].Rank}',
                                        style: GoogleFonts.alata(
                                            color: Colors.white),
                                      ),
                                      Text(
                                        '${snapshot.data[index].Rating}',
                                        style: GoogleFonts.alata(
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Max Rating',
                                        style: GoogleFonts.alata(
                                            color: Colors.grey),
                                      ),
                                    
                                      Text(
                                        'Freinds',
                                        style: GoogleFonts.alata(
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${snapshot.data[index].MaxRating}',
                                            style: GoogleFonts.alata(
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          isUp(snapshot.data[index].Rating,
                                              snapshot.data[index].MaxRating)
                                        ],
                                      ),
                                    
                                      Text(
                                        '${snapshot.data[index].Freinds}',
                                        style: GoogleFonts.alata(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              )));
                    });
              })),
    );
  }
}
