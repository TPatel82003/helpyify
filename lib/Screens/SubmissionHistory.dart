// ignore_for_file: unnecessary_import, unused_import, must_be_immutable, non_constant_identifier_names, avoid_print, prefer_const_constructors, file_names, sized_box_for_whitespace, unrelated_type_equality_checks, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpyify/DataModel/SubmissionDetails.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class SubmissionHistory extends StatelessWidget {
  final String HandleName;
  int Average_Rank = 0;
  SubmissionHistory({Key? key, required this.HandleName}) : super(key: key);
  Future<List<SubmissionDetails>> _getData2() async {
    var Data = await http.get(Uri.parse(
        "https://codeforces.com/api/user.status?handle=$HandleName&from=1&count=1000"));
    var JsonData = json.decode(Data.body);
    List<SubmissionDetails> FinalData = [];
    try {
      for (var info in JsonData["result"]) {
        List<String> TagFind = [];
        for (var Tag in info["problem"]["tags"]) {
          TagFind.add(Tag);
        }
        if (info["problem"]["rating"].toString() != Null) {
          SubmissionDetails NewInfo = SubmissionDetails(
            ProblemName: info["problem"]["name"],
            Rating: info["problem"]["rating"],
            Index: info["problem"]["index"],
            ProblemType: info["problem"]["type"],
            Tags: TagFind,
            Verdict: info["verdict"],
            ContestId: info["contestId"],
          );
          FinalData.add(NewInfo);
        } else {
          SubmissionDetails NewInfo = SubmissionDetails(
            ProblemName: info["problem"]["name"],
            Rating: 0,
            Index: info["problem"]["index"],
            ProblemType: info["problem"]["type"],
            Tags: TagFind,
            Verdict: info["verdict"],
            ContestId: info["contestId"],
          );
          FinalData.add(NewInfo);
        }
      }
    } catch (e) {
      print(e);
    }

    return FinalData;
  }

  Widget VerdictWidget(String Verdict) {
    if (Verdict == "OK") {
      return Text(Verdict,
          style: GoogleFonts.alata(
              fontSize: 16, color: Color.fromARGB(255, 80, 207, 54)));
    }
    return Text(Verdict,
        style: GoogleFonts.alata(
            fontSize: 16, color: Color.fromARGB(255, 231, 119, 119)));
  }

  Future<void> _launchUrl(int ContestId, String Index) async {
    String Contest = ContestId.toString();
    Uri _url =
        Uri.parse("https://codeforces.com/problemset/problem/$Contest/$Index");
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 25, 28, 49),
      appBar: AppBar(
        title: Text(
          'Recent Submissions',
          style: GoogleFonts.alata(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: Color.fromARGB(255, 25, 28, 49),
        elevation: 0,
        centerTitle: true,
        actions: const [],
      ),
      body: FutureBuilder(
        future: _getData2(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: Container(
                  alignment: Alignment.center,
                  color: Color.fromARGB(255, 36, 42, 64),
                  height: MediaQuery.of(context).size.height,
                  child: Lottie.asset('Assests/loading.json',
                      width: 100, height: 100)),
            );
          } else {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int Index) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    child: Container(
                        height: 320,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(255, 36, 42, 64),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Problem Name',
                                    style: GoogleFonts.alata(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                          child: GestureDetector(
                                        onTap: () => _launchUrl(
                                            snapshot.data[Index].ContestId,
                                            snapshot.data[Index].Index),
                                        child: Container(
                                          width: 350,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Text(
                                              snapshot.data[Index].ProblemName,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.alata(
                                                  fontSize: 16,
                                                  color: Colors.white)),
                                        ),
                                      )),
                                    ]),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        'Problem Index',
                                        style: GoogleFonts.alata(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(snapshot.data[Index].Index,
                                        style: GoogleFonts.alata(
                                            fontSize: 16, color: Colors.white))
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        'Problem Rating',
                                        style: GoogleFonts.alata(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('${snapshot.data[Index].Rating}',
                                        style: GoogleFonts.alata(
                                            fontSize: 16, color: Colors.white))
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    'Verdict',
                                    style: GoogleFonts.alata(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                VerdictWidget(snapshot.data[Index].Verdict),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Problem Tags',
                                    style: GoogleFonts.alata(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 50,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: ListView.builder(
                                        itemCount:
                                            snapshot.data[Index].Tags.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(5),
                                              child: Container(
                                                padding: EdgeInsets.all(7),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1),
                                                  color: Color.fromARGB(
                                                      255, 25, 28, 49),
                                                ),
                                                child: Text(
                                                  snapshot
                                                      .data[Index].Tags[index],
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.alata(
                                                      color: Colors.grey),
                                                ),
                                              ));
                                        }),
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                  );
                });
          }
        },
      ),
    );
  }
}
