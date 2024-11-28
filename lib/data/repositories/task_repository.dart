import 'package:flutterauth/data/models/task.dart';
import 'package:flutterauth/data/services/firebase_service.dart';

class TaskRepository {
  final FirebaseService _firebaseService;

  TaskRepository(this._firebaseService);

  final String _collection = 'tasks';

  // ADD NEW TASK
  Future<void> addTask(Task task) async {
    await _firebaseService.addDocument(_collection, task.toMap());
  }

  // UPDATE TIME WORKED OR STATUS OF A TASK
  Future<void> updateTask(String id,
      {int? timeWorked, TaskStatus? status}) async {
    final updates = <String, dynamic>{};
    if (timeWorked != null) updates['timeWorked'] = timeWorked;
    if (status != null) updates['status'] = status.name;
    await _firebaseService.updateDocument(_collection, id, updates);
  }

  // DELETE A TASK
  Future<void> deleteTask(String taskId) async {
    await _firebaseService.deleteDocument(_collection, taskId);
  }

  // FETCH TASKS FOR A SPECIFIC USER
  Stream<List<Task>> getTasks(String userId) {
    return _firebaseService.getDocuments(_collection).map((docs) {
      return docs
          .map((doc) => Task.fromMap(doc))
          .where((task) => task.userId == userId)
          .toList();
    });
  }
}
