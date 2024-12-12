import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:goal_grid_habit_tracker_app/dateTime/date_time.dart';

class MonthSummary extends StatelessWidget {
  const MonthSummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  final Map<DateTime, int>? datasets;
  final String startDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(const Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: const Color(0xFFB3C8CF),
        textColor: Colors.white,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 35,
        colorsets: const {
          1: Color(0xFF8FBAC9),
          2: Color(0xff89C2D9),
          3: Color(0xff61A5C2),
          4: Color(0xff468FAF),
          5: Color(0xFF276E8D),
          6: Color(0xff2A6F97),
          7: Color(0xff014F86),
          8: Color(0xff01497C),
          9: Color(0xff013A63),
          10: Color(0xff012A4A),
        },
        onClick: (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: const Color(0xff2A6F97),
              content: Text(
                value.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
