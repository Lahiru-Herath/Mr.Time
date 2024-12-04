import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  final Color backgroundColor;
  final String title;
  final String deadline;
  final int timeWorked;
  final bool isDone;
  final List<String> tags;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final Function(bool?) onToggle;

  const TaskTile({
    super.key,
    required this.backgroundColor,
    required this.title,
    required this.deadline,
    required this.timeWorked,
    required this.isDone,
    required this.tags,
    required this.onTap,
    required this.onEdit,
    required this.onToggle,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  late bool isTaskDone;

  @override
  void initState() {
    super.initState();
    isTaskDone = widget.isDone;
  }

  Color getColor(Set<WidgetState> states) {
    if (states.contains(WidgetState.selected)) {
      return Colors.black;
    }
    return widget.backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(widget.tags.length, (index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      margin: const EdgeInsets.only(right: 5),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 8.0,
                        ),
                        child: Text(
                          widget.tags[index],
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                      ),
                    );
                  }),
                ),
                GestureDetector(
                  onTap: widget.onEdit,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.edit_outlined,
                        color: widget.backgroundColor,
                        size: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // TASK DETAILS
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration:
                            isTaskDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.deadline,
                          style: TextStyle(
                            fontSize: 14,
                            color: widget.isDone ? Colors.grey : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // isCompleted ICON
                Checkbox(
                  checkColor: widget.backgroundColor,
                  fillColor: WidgetStateProperty.resolveWith(getColor),
                  shape: const CircleBorder(),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: isTaskDone,
                  onChanged: (bool? value) {
                    setState(() {
                      isTaskDone = value!;
                    });
                    widget.onToggle(value);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            color: widget.backgroundColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Work on Task",
                            style: TextStyle(
                              color: widget.backgroundColor,
                            ),
                          )
                        ],
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
