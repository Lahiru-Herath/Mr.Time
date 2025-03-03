import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference getCollection(String collection) {
    return _firestore.collection(collection);
  }

  Future<void> addDocument(String collection, Map<String, dynamic> data) async {
    await getCollection(collection)
        .doc(data['id'])
        .set(data); // Use autogenerated ID
  }

  Future<void> updateDocument(
      String collection, String id, Map<String, dynamic> data) async {
    await getCollection(collection).doc(id).update(data);
  }

  Future<void> deleteDocument(String collection, String id) async {
    await getCollection(collection).doc(id).delete();
  }

  Stream<List<Map<String, dynamic>>> getDocuments(String collection) {
    return getCollection(collection).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }
}
