// ignore_for_file: unnecessary_import, unused_import, must_be_immutable, non_constant_identifier_names, avoid_print, prefer_const_constructors, file_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpyify/DataModel/ApiData.dart';
import 'package:helpyify/DataModel/ForNotification.dart';
import 'package:helpyify/Screens/Freinds.dart';
import 'package:helpyify/Widgets/ProblemSolved.dart';
import 'package:helpyify/Widgets/Ranking.dart';
import 'package:helpyify/Widgets/Rating.dart';
import 'package:helpyify/Widgets/SomeData.dart';
import 'package:helpyify/Widgets/StatisticsScreen.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DashBoard extends StatelessWidget {
  @override
  final String HandleName;
  final int AverageRank = 0;
  const DashBoard({Key? key, required this.HandleName}) : super(key: key);
  Future<List<User>> _getData() async {
    List<User> FinalData = [];
    var Data;
    var JsonData;
    try {
      Data = await http.get(Uri.parse(
          "https://codeforces.com/api/user.info?handles=$HandleName;"));
      if (Data.statusCode != 200) throw HttpException('${Data.statusCode}');
      JsonData = json.decode(Data.body);
    } on SocketException {
      print('No Internet connection');
    } on HttpException {
      return FinalData;
      print('Could Not Find Handle');
    } on FormatException {
      print("Something is wrong");
    }

    for (var info in JsonData["result"]) {
      User NewInfo = User(
          Handle: info["handle"],
          Rating: info["rating"],
          Rank: info["rank"],
          MaxRank: info["maxRank"],
          MaxRating: info["maxRating"],
          Freinds: info["friendOfCount"],
          Cont: info["contribution"]);
      FinalData.add(NewInfo);
    }
    return FinalData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 25, 28, 49),
        body: NestedScrollView(
          floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    title: Text(
                      'Dashboard',
                      style:
                          GoogleFonts.alata(color: Colors.white, fontSize: 22),
                    ),
                    backgroundColor: Color.fromARGB(255, 25, 28, 49),
                    elevation: 0,
                    centerTitle: true,
                    actions: [
                      Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Freinds(UserName: HandleName,))),
                            child: Icon(
                              FontAwesomeIcons.chessKing,
                              size: 22,
                            ),
                          ))
                    ],
                  )
                ],
            body: Center(
                child: FutureBuilder(
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
                }
                else if(snapshot.data!.length == 0){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('Assests/404-error.png' ,height: 85,),
                        SizedBox(height: 20,),
                        Text('$HandleName Not Found' , style: GoogleFonts.alata(
                            fontSize: 20,
                            color: Colors.white),),
                        Text('Kindly check handle' , style: GoogleFonts.alata(
                            fontSize: 20,
                            color: Colors.white),)
                      ],
                    )
                  );
                }

                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int Index) {
                        return Container(
                          color: Color.fromARGB(255, 25, 28, 49),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        NotificaionApi.ShowNotification(
                                            Id: 0,
                                            Title: 'My Name',
                                            Body: 'Here',
                                            Payload: 'ITms'),
                                    child: Container(
                                      height: 120,
                                      width: 180,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color:
                                              Color.fromARGB(255, 36, 42, 64)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.solidUser,
                                            size: 30,
                                            color: Color.fromARGB(
                                                255, 149, 159, 255),
                                          ),
                                          Text(
                                            snapshot.data[Index].Handle,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.alata(
                                                fontSize: 24,
                                                color: Color.fromARGB(
                                                    255, 149, 159, 255)),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 120,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color.fromARGB(255, 36, 42, 64)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.handsHelping,
                                          size: 30,
                                          color: Color.fromARGB(
                                              255, 242, 151, 156),
                                        ),
                                        Text(
                                          '${snapshot.data[Index].Freinds}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.alata(
                                              fontSize: 24,
                                              color: Color.fromARGB(
                                                  255, 242, 151, 156)),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 120,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color.fromARGB(255, 36, 42, 64)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.solidStar,
                                          size: 30,
                                          color: Color.fromARGB(
                                              203, 239, 192, 104),
                                        ),
                                        Text(
                                          '${snapshot.data[Index].Cont}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.alata(
                                            fontSize: 24,
                                            color: Color.fromARGB(
                                                203, 239, 192, 104),
                                            fontWeight: FontWeight.w200,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Rating(
                                  MaxRating: snapshot.data[Index].MaxRating,
                                  CurrentRating: snapshot.data[Index].Rating,
                                  Cont: snapshot.data[Index].Cont,
                                  Freinds: snapshot.data[Index].Freinds,
                                  Handle: snapshot.data[Index].Handle,
                                  MaxRank: snapshot.data[Index].MaxRank,
                                  Rank: snapshot.data[Index].Rank),
                              SizedBox(
                                height: 20,
                              ),
                              Ranking(
                                MaxRank: snapshot.data[Index].MaxRank,
                                CurrentRank: snapshot.data[Index].Rank,
                                HandleName: snapshot.data[Index].Handle,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              StatisticsScreen(
                                  HandleName: snapshot.data[Index].Handle),
                              
                            ],
                          ),
                        );
                      });

              },
            ))));
  }
}
