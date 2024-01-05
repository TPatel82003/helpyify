// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:helpyify/DataModel/ForNotification.dart';
import 'package:helpyify/Screens/DashBoard.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController textFieldController = TextEditingController();
  bool _Value = true;
  void _Remeberme(bool? value) {
    print("Handle Rember Me");
    _Value = value!;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('UserName', textFieldController.text);
      },
    );
    setState(() {
      _Value = value;
    });
  }

  void _loadUserEmailPassword() async {
    print("Load Email");
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var Handle = _prefs.getString("UserName") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;

      print(_remeberMe);
      print(Handle);
      if (_remeberMe) {
        setState(() {
          _Value = true;
        });
        textFieldController.text = Handle;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
    NotificaionApi.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          color: Color.fromARGB(255, 25, 28, 49),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 85 / 100,
                width: 450,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(70),
                        bottomRight: Radius.circular(70)),
                    color: Color.fromARGB(255, 36, 42, 64)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 135),
                      child: Text(
                        'Helpify',
                        style: GoogleFonts.alata(
                            fontSize: 50,
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.overline,
                            decorationThickness: 2),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 250,
                            width: 250,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.white, width: 2)),
                                  child: TextField(
                                    cursorColor: Colors.white,
                                    controller: textFieldController,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: GoogleFonts.alata(
                                        color: Colors.white, fontSize: 20),
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          FontAwesomeIcons.solidUser,
                                          color: Colors.white,
                                        ),
                                        hintStyle: GoogleFonts.alata(
                                            color: Colors.white, fontSize: 20),
                                        border: InputBorder.none,
                                        hintText: 'Handle'),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 250,
                                      child: ListTile(
                                        leading: Checkbox(
                                          checkColor: Colors.black,
                                          fillColor: MaterialStateProperty
                                              .resolveWith<Color>((states) {
                                            if (states.contains(
                                                MaterialState.disabled)) {
                                              return Colors.white
                                                  .withOpacity(.32);
                                            }
                                            return Colors.white;
                                          }),
                                          onChanged: (_Value) =>
                                              {_Remeberme(_Value)},
                                          value: _Value,
                                        ),
                                        title: Text('Remember Me',
                                            style: GoogleFonts.alata(
                                                color: Colors.white,
                                                fontSize: 16)),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DashBoard(
                                              HandleName:
                                                  textFieldController.text))),
                                  child: Container(
                                      width: 150,
                                      height: 50,
                                      padding: EdgeInsets.all(3),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 36, 42, 64),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                      ),
                                      child: Text(
                                        'Enter',
                                        style: GoogleFonts.alata(
                                            fontSize: 22, color: Colors.white),
                                      )),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.infoCircle,
                    color: Colors.white,
                    size: 35,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Beta Version',
                    style: GoogleFonts.alata(color: Colors.white, fontSize: 20),
                  )
                ],
              )
            ],
          )),
    );
  }
}
