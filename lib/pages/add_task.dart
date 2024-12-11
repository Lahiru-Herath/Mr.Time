import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../data/models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _formKey = GlobalKey<FormState>();

  // FORM INPUT CONTROLLERS
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();

  // DEFAULT VALUES
  final TaskStatus _selectedStatus = TaskStatus.TODO;
  String _selectedColor = "#fbe114";

  String? _deadline; // HOLD THE DEADLINE

  // FIRESTORE REFERENCE
  final CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  // COLOR LIST
  final List<String> colorOptions = [
    "#fbe114",
    "#4eed1",
    "#13d3fb",
    "#b6adff",
    "#fb1467",
    "#f5815c",
    "#148cfb"
  ];

  // SAVE THE TASK
  Future<void> _saveTask() async {
    if (_formKey.currentState!.validate()) {
      String taskId = const Uuid().v4();
      String userId = user.uid;
      List<String> tags =
          _tagsController.text.split(',').map((tag) => tag.trim()).toList();

      Task newTask = Task(
        id: taskId,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        deadline: _deadline!,
        timeWorked: 0, // Default to 0
        status: _selectedStatus,
        isDone: false,
        userId: userId,
        taskColor: _selectedColor,
        tags: tags,
      );

      try {
        await tasksCollection.doc(taskId).set(newTask.toMap());
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add task: $e")),
        );
      }
    }
  }

  // SHOW DATE PICKER
  Future<void> _selectDeadline() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _deadline = DateFormat('d MMMM yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Task",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Title Input
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Task Title",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Title is required" : null,
              ),
              const SizedBox(height: 16),

              // Description Input
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Task Description",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty
                    ? "Description is required"
                    : null,
              ),
              const SizedBox(height: 16),

              // Deadline Picker
              Row(
                children: [
                  const Text(
                    "Deadline:",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      _deadline ?? "Select a date",
                      style: TextStyle(
                        fontSize: 16,
                        color: _deadline == null ? Colors.grey : Colors.black87,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: _selectDeadline,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Tags Input
              TextFormField(
                controller: _tagsController,
                decoration: const InputDecoration(
                  labelText: "Tags (comma-separated)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Color Picker
              const Text("Pick Task Color:"),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children: colorOptions.map((colorCode) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = colorCode;
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(
                            int.parse(colorCode.replaceFirst("#", "0xff"))),
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Save Button
              ElevatedButton.icon(
                onPressed: _saveTask,
                icon: const Icon(Icons.save),
                label: const Text("Save Task"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
