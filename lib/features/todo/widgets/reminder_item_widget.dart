import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techigh_todo/constants/sizes.dart';
import 'package:techigh_todo/constants/tech_colors.dart';
import 'package:techigh_todo/features/todo/models/list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techigh_todo/features/todo/view_models/fire_reminders_vm.dart';

class ReminderItemWidget extends ConsumerStatefulWidget {
  final ListModel list;
  final int index;
  final bool isAdding;
  final Function onTap;
  final bool isFocused;
  const ReminderItemWidget({
    Key? key,
    required this.list,
    required this.isAdding,
    required this.index,
    required this.onTap,
    required this.isFocused,
  }) : super(key: key);

  @override
  ConsumerState<ReminderItemWidget> createState() => _ReminderItemWidgetState();
}

class _ReminderItemWidgetState extends ConsumerState<ReminderItemWidget> {
  bool isChecked = false;
  late TextEditingController _titleController;
  late TextEditingController _noteController;

  void _onTitleChanged(String value) {
    ref
        .read(remindersProvider(widget.list.id).notifier)
        .addReminder(widget.list.id, value);
  }

  void _onNoteChanged() {}

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('reminder_item_widget - build');
    print(widget.isFocused);
    return ListTile(
      onTap: () => widget.onTap(widget.index),
      visualDensity: VisualDensity.compact,
      minLeadingWidth: 0,
      minVerticalPadding: 0,
      leading: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isChecked
                ? TechColors.allColors[widget.list.color]!
                : Colors.grey.shade700,
          ),
        ),
        child: Transform.scale(
          scale: 0.8,
          child: Checkbox(
            checkColor: Colors.transparent,
            // activeColor: Colors.red,
            // shape: const CircleBorder(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              // side: BorderSide.none,
            ),
            side: BorderSide.none,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

            /// fillColor가 activeColor보다 우선
            /// 만약 fillColor가 지정되어 있다면, 체크박스의 배경 색상은 fillColor에 정의된 색상으로 설정
            /// fillColor은 체크박스의 선택 여부와 관계없이 상태에 따라 다른 색상을 지정
            fillColor: MaterialStateProperty.resolveWith(
              (states) {
                // return Colors.transparent;
                if (states.contains(MaterialState.selected)) {
                  return TechColors.allColors[widget.list.color];
                } else {
                  return Colors.transparent;
                }
              },
            ),
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
        ),
      ),
      title: Container(
        padding: EdgeInsets.only(
          top: Sizes.size10,
          bottom: widget.isFocused ? 0 : Sizes.size10,
        ),
        decoration: BoxDecoration(
          border: widget.isFocused
              ? null
              : Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                  ),
                ),
        ),
        child: widget.isAdding
            ? CupertinoTextField(
                controller: _titleController,
                onChanged: _onTitleChanged,
                autofocus: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                ),
                decoration: BoxDecoration(),
              )
            : Text('New Reminder'),
      ),
      subtitle: widget.isFocused
          ? Container(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size10,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                  ),
                ),
              ),
              child: Text('Add Note'),
            )
          : null,
    );
  }
}
