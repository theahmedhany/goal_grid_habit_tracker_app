import 'package:flutter/material.dart';
import 'package:goal_grid_habit_tracker_app/data/habit_database.dart';
import 'package:goal_grid_habit_tracker_app/widgets/habit_tile.dart';
import 'package:goal_grid_habit_tracker_app/widgets/month_summary.dart';
import 'package:goal_grid_habit_tracker_app/widgets/my_floating_action_button.dart';
import 'package:goal_grid_habit_tracker_app/widgets/custom_alert_box.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box('Habit_Database');

  @override
  void initState() {
    if (_myBox.get('CURRENT_HABIT_LIST') == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }

    db.updateDatabase();

    super.initState();
  }

  bool habitCompleted = false;

  void checkBoxTabbed(bool? value, int index) {
    setState(() {
      db.todayHabitList[index][1] = value!;
    });
    db.updateDatabase();
  }

  final _newHabitNameController = TextEditingController();

  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertBox(
          controller: _newHabitNameController,
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
          hintText: 'Enter Habit Name.',
          buttonText: 'Add',
        );
      },
    );
  }

  void saveNewHabit() {
    setState(() {
      db.todayHabitList.add(
        [_newHabitNameController.text, false],
      );
      Navigator.of(context).pop();
      _newHabitNameController.clear();
    });
    db.updateDatabase();
  }

  void cancelDialogBox() {
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

  void saveExistingHabit(int index) {
    setState(() {
      db.todayHabitList[index][0] = _newHabitNameController.text;
      Navigator.of(context).pop();
      _newHabitNameController.clear();
    });
    db.updateDatabase();
  }

  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertBox(
          controller: _newHabitNameController,
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
          hintText: db.todayHabitList[index][0],
          buttonText: 'Save',
        );
      },
    );
  }

  void deleteHabit(int index) {
    setState(() {
      db.todayHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFloatingActionButton(
        onPressed: () => createNewHabit(),
      ),
      backgroundColor: const Color(0xffCEE7EF),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/z2.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xff2C7DA0),
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage('assets/z1.png'),
                    fit: BoxFit.fill,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff012A4A).withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: MonthSummary(
                  datasets: db.heatMapDataSet,
                  startDate: _myBox.get('START_DATE'),
                ),
              ),
              db.todayHabitList.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          Image.asset(
                            'assets/logo.png',
                            width: 250,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'No Habits Found.',
                            style: TextStyle(
                              fontSize: 28,
                              color: Color(0xff013A63),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: db.todayHabitList.length,
                      itemBuilder: (context, index) {
                        return HabitTile(
                          habitName: db.todayHabitList[index][0],
                          habitCompleted: db.todayHabitList[index][1],
                          onChanged: (value) => checkBoxTabbed(value, index),
                          settingsTapped: (Context) => openHabitSettings(index),
                          deleteTapped: (Context) => deleteHabit(index),
                        );
                      },
                    ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
