import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:uuid/uuid.dart';
import '../data/models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _formKey = GlobalKey<FormState>();

  // Form input controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();

  // Default values
  final TaskStatus _selectedStatus = TaskStatus.PENDING;
  String _selectedColor = "#000000";

  // Firestore reference
  final CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  // Save Task to Firestore
  Future<void> _saveTask() async {
    if (_formKey.currentState!.validate()) {
      String taskId = const Uuid().v4();
      String userId = user.uid; // Replace with actual user ID logic
      List<String> tags =
          _tagsController.text.split(',').map((tag) => tag.trim()).toList();

      Task newTask = Task(
        id: taskId,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        deadline: _deadlineController.text.trim(),
        timeWorked: 0, // Default to 0
        status: _selectedStatus,
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

              // Deadline Input
              TextFormField(
                controller: _deadlineController,
                decoration: const InputDecoration(
                  labelText: "Deadline (e.g., YYYY-MM-DD)",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Deadline is required"
                    : null,
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
              Row(
                children: [
                  const Text("Task Color: "),
                  GestureDetector(
                    onTap: () async {
                      Color? pickedColor = await showDialog<Color>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Pick Task Color"),
                            content: SingleChildScrollView(
                              child: BlockPicker(
                                pickerColor: Color(int.parse(
                                    _selectedColor.replaceFirst("#", "0xff"))),
                                onColorChanged: (color) {
                                  setState(() {
                                    _selectedColor =
                                        '#${color.value.toRadixString(16).substring(2)}';
                                  });
                                  Navigator.of(context).pop(color);
                                },
                              ),
                            ),
                          );
                        },
                      );
                      if (pickedColor != null) {
                        setState(() {
                          _selectedColor =
                              '#${pickedColor.value.toRadixString(16).substring(2)}';
                        });
                      }
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Color(
                          int.parse(_selectedColor.replaceFirst("#", "0xff")),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
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
