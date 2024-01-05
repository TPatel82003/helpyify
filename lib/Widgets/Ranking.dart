// ignore_for_file: unnecessary_import, unused_import, must_be_immutable, non_constant_identifier_names, avoid_print, prefer_const_constructors, file_names


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpyify/Screens/RatingHistory.dart';

class Ranking extends StatelessWidget {
  final String MaxRank, CurrentRank, HandleName;
  const Ranking(
      {Key? key,
      required this.MaxRank,
      required this.CurrentRank,
      required this.HandleName})
      : super(key: key);
  Widget GiveStanding(String Current) {
    List<String> Ranks = [
      "newbie",
      "pupil",
      "specialist",
      "expert",
      "candidate master",
      "master",
      "international master",
      "grandmaster",
      "international grandmaster",
      "legendary grandmaster"
    ];
    if (Current == Ranks[0]) {
      return Text(
        Current,
        style: GoogleFonts.alata(
          fontSize: 20,
        ),
      );
    }
    if (Current == Ranks[1]) {
      return Text(
        Current,
        style: GoogleFonts.alata(
            fontSize: 20, color: Color.fromARGB(255, 0, 128, 60)),
      );
    }
    if (Current == Ranks[2]) {
      return Text(
        Current,
        style: GoogleFonts.alata(
            fontSize: 20, color: Color.fromARGB(255, 3, 168, 158)),
      );
    }
    if (Current == Ranks[3]) {
      return Text(
        Current,
        style: GoogleFonts.alata(
            fontSize: 20,
            color: Color.fromARGB(255, 175, 174, 255)),
      );
    }
    if (Current == Ranks[4]) {
      return Text(
        Current,
        style: GoogleFonts.alata(
            fontSize: 20, color: Color.fromARGB(255, 250, 174, 239)),
      );
    }
    if (Current == Ranks[5]) {
      return Text(
        Current,
        style: GoogleFonts.alata(
            fontSize: 20,
            color: Color.fromARGB(255, 250, 174, 239)),
      );
    }
    if (Current == Ranks[6]) {
      return Text(
        Current,
        style: GoogleFonts.alata(
            fontSize: 20, color: Color.fromARGB(255, 255, 165, 4)),
      );
    }
    if (Current == Ranks[7]) {
      return Text(
        Current,
        style: GoogleFonts.alata(
            fontSize: 20,
            color: Color.fromARGB(255, 244, 106, 96)),
      );
    }
    if (Current == Ranks[8]) {
      return Text(
        Current,
        style: GoogleFonts.alata(
            fontSize: 20,
            color: Color.fromARGB(255, 244, 106, 96)),
      );
    }
    return Text(
      Current,
      style: GoogleFonts.alata(
          fontSize: 20,
          color: Color.fromARGB(255, 244, 106, 96)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      width: 400,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 36,42,64)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    'Ranking',
                    style: GoogleFonts.alata(
                        fontSize: 24, color: Color.fromARGB(255, 177, 174, 174)),
                  ),
                ],
              )),
          Container(
            height: 100,
            width: 360,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white  , width: 1),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Max',
                    style: GoogleFonts.alata(
                        fontSize: 20, color: Color.fromARGB(255, 177, 174, 174))),
                GiveStanding(MaxRank)
              ],
            ),
          ),
          Container(
            height: 100,
            width: 360,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Current',
                    style: GoogleFonts.alata(
                        fontSize: 20, color: Color.fromARGB(255, 177, 174, 174))),
                GiveStanding(CurrentRank)
              ],
            ),
          )
        ],
      ),
    );
  }
}
