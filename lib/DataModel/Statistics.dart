import 'package:flutter/rendering.dart';

class Statistics {
  int Accepted;
  int Rejected;
  int Timelimit;
  int Compilation;
  int Memorylimit;
  int Wrong;
  Statistics({
    required this.Accepted,
    required this.Rejected,
    required this.Compilation,
    required this.Memorylimit,
    required this.Timelimit,
    required this.Wrong,
  });
}
