import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterauth/components/category_box.dart';
import 'package:flutterauth/components/task_tile.dart';
import 'package:flutterauth/pages/add_task.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser!;
  String selectedCategory = "Pending";
  final List<Map<String, dynamic>> tasks = [
    {
      "title": "Complete Project Report",
      "deadline": "10 December 2024",
      "isDone": false,
      "tags": ["Mobile Application", "Project"],
      "backgroundColor": const Color(0xFF4BEEd1),
      "timeWorked": 5624,
    },
    {
      "title": "Study for Exams",
      "deadline": "15 December 2024",
      "isDone": false,
      "tags": ["Study", "Exams"],
      "backgroundColor": const Color(0xFFfbe114),
      "timeWorked": 11730,
    },
    {
      "title": "Work on Software Project",
      "deadline": "16 December 2024",
      "isDone": false,
      "tags": ["Software", "Project"],
      "backgroundColor": const Color(0xFF13d3fb),
      "timeWorked": 8966,
    }
  ];

  void toggleTaskStatus(int index, bool? value) {
    tasks[index]["isDone"] = value!;
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // PENDING, UPCOMING, COMPLETED UPDATING
  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
          margin: const EdgeInsets.only(left: 10.0),
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          width: 25,
          height: 25,
          child: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              size: 20,
            ),
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Task Manager",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 5.0),
            child: IconButton(
              onPressed: () {}, // NOTIFICATIONS
              icon: const Icon(Icons.notifications_active_outlined),
              color: Colors.black,
              iconSize: 30,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user.displayName}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email ?? "Guest User",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Navigate to Home
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to Settings
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          // WELCOME NOTE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 15.0,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back!",
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Here's Update Today.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 15.0),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 25,
          ),
          // CATEGORIES
          Container(
            margin: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryBox(
                  category: "Pending",
                  isSelected: selectedCategory == "Pending",
                  onTap: () => _onCategorySelected("Pending"),
                ),
                CategoryBox(
                  category: "Upcoming",
                  isSelected: selectedCategory == "Upcoming",
                  onTap: () => _onCategorySelected("Upcoming"),
                ),
                CategoryBox(
                  category: "Completed",
                  isSelected: selectedCategory == "Completed",
                  onTap: () => _onCategorySelected("Completed"),
                )
              ],
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskTile(
                  backgroundColor: tasks[index]["backgroundColor"],
                  title: tasks[index]["title"],
                  deadline: tasks[index]["deadline"],
                  isDone: tasks[index]["isDone"],
                  tags: tasks[index]["tags"],
                  timeWorked: tasks[index]["timeWorked"],
                  onTap: () {},
                  onEdit: () {},
                  onToggle: (value) => toggleTaskStatus(index, value),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddTaskPage(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.add_outlined,
                        size: 20,
                      ),
                      label: const Text(
                        "Add Task",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
