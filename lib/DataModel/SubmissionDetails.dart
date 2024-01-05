

import 'package:flutter/rendering.dart';

class SubmissionDetails{
  String ProblemName;
  String ProblemType;
  String Index;
  String Verdict;
  int Rating;
  List<String>Tags;
  int ContestId;
  SubmissionDetails({
    required this.ProblemName,
    required this.ProblemType,
    required this.Index,
    required this.Verdict,
    required this.Rating,
    required this.Tags,
    required this.ContestId,
  });
}