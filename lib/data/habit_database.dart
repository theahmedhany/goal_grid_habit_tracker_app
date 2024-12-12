import 'package:goal_grid_habit_tracker_app/dateTime/date_time.dart';
import 'package:hive_flutter/adapters.dart';

final _myBox = Hive.box('Habit_Database');

class HabitDatabase {
  List todayHabitList = [];

  Map<DateTime, int> heatMapDataSet = {};

  void createDefaultData() {
    todayHabitList = [];

    _myBox.put('START_DATE', todaysDateFormatted());
  }

  void loadData() {
    if (_myBox.get(todaysDateFormatted()) == null) {
      todayHabitList = _myBox.get('CURRENT_HABIT_LIST');

      for (int i = 0; i < todayHabitList.length; i++) {
        todayHabitList[i][1] = false;
      }
    } else {
      todayHabitList = _myBox.get(todaysDateFormatted());
    }
  }

  void updateDatabase() {
    _myBox.put(todaysDateFormatted(), todayHabitList);

    _myBox.put('CURRENT_HABIT_LIST', todayHabitList);

    calculateHabitPercentages();

    loadHeatMap();
  }

  void calculateHabitPercentages() {
    int countCompleted = 0;

    for (int i = 0; i < todayHabitList.length; i++) {
      if (todayHabitList[i][1] == true) {
        countCompleted++;
      }
    }
    String percent = todayHabitList.isEmpty
        ? '0.0'
        : (countCompleted / todayHabitList.length).toStringAsFixed(1);

    _myBox.put('PERCENTAGE_SUMMARY_${todaysDateFormatted()}', percent);
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get('START_DATE'));

    int daysInBetween = DateTime.now().difference(startDate).inDays;

    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _myBox.get('PERCENTAGE_SUMMARY_$yyyymmdd') ?? '0.0',
      );

      int year = startDate.add(Duration(days: i)).year;

      int month = startDate.add(Duration(days: i)).month;

      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
    }
  }
}
