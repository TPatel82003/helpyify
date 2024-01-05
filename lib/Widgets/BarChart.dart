// ignore_for_file: unnecessary_import, unused_import, must_be_immutable, non_constant_identifier_names, avoid_print, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpyify/DataModel/ChartDataProblems.dart';
import 'package:helpyify/DataModel/RatingChart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart extends StatelessWidget {
  final List<RatingChart> GrapValue;
  BarChart({Key? key, required this.GrapValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(isVisible: false),
        primaryYAxis: NumericAxis(
          isVisible: false,
        ),
        series: <ChartSeries>[
          LineSeries<RatingChart, int>(
              pointColorMapper: (RatingChart data, _) =>
                                    data.PointColor,
              
              markerSettings: const MarkerSettings(isVisible: true),
              dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle:
                      GoogleFonts.alata(color: Colors.grey, fontSize: 11)),
              dataSource: GrapValue,
              xValueMapper: (RatingChart data, _) => data.Index,
              yValueMapper: (RatingChart data, _) => data.Rating)
        ]);
  }
}
