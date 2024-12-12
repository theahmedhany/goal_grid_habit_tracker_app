import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class HabitTile extends StatelessWidget {
  const HabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.settingsTapped,
    required this.deleteTapped,
  });

  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: settingsTapped,
              backgroundColor: const Color(0xff012A4A),
              icon: Icons.mode_edit_outlined,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: deleteTapped,
              backgroundColor: const Color(0xffC62E2E),
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            if (onChanged != null) {
              onChanged!(!habitCompleted);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(
              color: const Color(0xfff3f8f9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff012A4A).withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: const Offset(1, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                MSHCheckbox(
                  value: habitCompleted,
                  onChanged: (selected) {
                    if (onChanged != null) {
                      onChanged!(selected);
                    }
                  },
                  size: 24,
                  colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                    checkedColor: const Color(0xff013A63),
                  ),
                  style: MSHCheckboxStyle.stroke,
                ),
                const SizedBox(width: 12),
                Text(
                  habitName,
                  style: const TextStyle(
                    color: Color(0xff013A63),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Color(0xff468FAF),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
