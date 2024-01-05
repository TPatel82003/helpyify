// ignore_for_file: unnecessary_import, unused_import, must_be_immutable, non_constant_identifier_names, avoid_print, prefer_const_constructors, file_names


import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpyify/DataModel/HistoryData.dart';
import 'package:helpyify/DataModel/ApiData.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListView.builder(
            itemCount: Users.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              User UsersInfo = Users[index];
              return Container(
                  height: 120,
                  width: 350,
                  padding: EdgeInsets.all(10),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 236, 251, 255),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.user,
                                  color: Color.fromARGB(255, 58, 127, 146),
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                 Text(
                                    UsersInfo.Handle,
                                    style: GoogleFonts.alata(
                                        color:
                                            Color.fromARGB(255, 58, 127, 146),
                                        fontSize: 25),
                                  ),
                              ],
                            ),
                            Text('${UsersInfo.Rating}',
                                style: GoogleFonts.alata(
                                    color: Color.fromARGB(255, 58, 127, 146),
                                    fontSize: 22))
                          ],
                        ),
                      )));
            }));
  }
}
