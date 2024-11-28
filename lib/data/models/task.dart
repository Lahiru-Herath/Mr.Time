enum TaskStatus { COMPLETED, PENDING, CREATED }

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime deadline;
  final int timeWorked;
  final TaskStatus status;
  final String userId;

  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.deadline,
      required this.timeWorked,
      required this.status,
      required this.userId});

  // Convert task to a map for firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'deadline': deadline,
      'timeWorked': timeWorked,
      'status': status.name,
      'userId': userId,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      deadline: map['deadline'],
      timeWorked: map['timeWorked'] ?? 0,
      status: TaskStatus.values.firstWhere((e) => e.name == map['status']),
      userId: map['userId'],
    );
  }
}
