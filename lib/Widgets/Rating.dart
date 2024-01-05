// ignore_for_file: unnecessary_import, unused_import, must_be_immutable, non_constant_identifier_names, avoid_print, prefer_const_constructors, file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpyify/DataModel/ApiData.dart';
import 'package:helpyify/DataModel/HistoryData.dart';
import 'package:helpyify/Screens/RatingHistory.dart';
import 'package:helpyify/Widgets/RatingGraph.dart';

import 'RatingGraph.dart';

class Rating extends StatelessWidget {
  final int MaxRating, CurrentRating , Cont , Freinds;
  final String Handle , MaxRank , Rank ;
  const Rating({Key? key, required this.MaxRating, required this.CurrentRating, required this.Cont, required this.Freinds, required this.Handle, required this.MaxRank, required this.Rank})
      : super(key: key);
  void AddDetails(){
    User NewInfo  = User(Handle: Handle, MaxRank: MaxRank, MaxRating: MaxRating, Rank: Rank, Rating: CurrentRating, Freinds: Freinds, Cont: Cont);
    if (!Users.contains(NewInfo)){
      Users.add(NewInfo);
    }
  }

  Widget GivePercentage(int Max, int Current) {
    
    if (Max != Current) {
      return const Icon(FontAwesomeIcons.greaterThan, color: Color.fromARGB(255, 244, 106, 96) ,size: 19,);
    }
    return const Icon(FontAwesomeIcons.equals, color: Colors.green,size: 19);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 520,
      width: 380,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 36,42,64)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rating',
                    style: GoogleFonts.alata(
                        fontSize: 24, color: Color.fromARGB(255, 177, 174, 174)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: IconButton(
                        icon: Icon(FontAwesomeIcons.history),
                         onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RatingHistory(HandleName: Handle,))),
                        color: Color.fromARGB(255, 177, 174, 174)),
                  )
                ],
              )),
          RatingGraph(HandleName: Handle),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                alignment: Alignment.topCenter,
                height: 120,
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Max',
                        style: GoogleFonts.alata(
                            fontSize: 20,
                            color: Color.fromARGB(255, 177, 174, 174))),
                    Container(width: 25,height: 0,decoration: BoxDecoration(border: Border.all(color: Colors.white)),),
                    Text(
                      '$MaxRating',
                      style: GoogleFonts.alata(
                        fontSize: 18,
                         color: Colors.white
                      ),
                    )
                  ],
                )),
            Divider(height : 5),
            Container(
                alignment: Alignment.topCenter,
                height: 120,
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Current',
                        style: GoogleFonts.alata(
                            fontSize: 20,
                            color: Color.fromARGB(255, 177, 174, 174))),
                              Container(width: 25,height: 0,decoration: BoxDecoration(border: Border.all(color: Colors.white)),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GivePercentage(MaxRating,
                            CurrentRating),
                        SizedBox(width: 5),
                        Text(
                          '$CurrentRating',
                          style: GoogleFonts.alata(
                            fontSize: 18,
                            color: Colors.white
                          ),
                        ),
                      ],
                    ),
                    
                  ],
                )),
          ],
            ),
          ),
        ],
      ),
    );
  }
}
