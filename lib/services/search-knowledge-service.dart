import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot<Object?>> searchKnowledge({required String keyword}) {
  // Get a reference to the Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Collection reference
  CollectionReference knowledge = firestore.collection('knowledge');

  // Use where() to perform the similar search based on a field (e.g., 'title')
  return knowledge
      .where('title', isGreaterThanOrEqualTo: keyword)
      .where('title', isLessThanOrEqualTo: keyword + '\uf8ff')
      .snapshots();
}

// Future<List<QueryDocumentSnapshot<Object?>>> getDataFromFirestore() async {
//   // Get a reference to the Firestore instance
//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   // Reference to a specific collection (replace 'my_collection' with your collection name)
//   CollectionReference knowledge = firestore.collection('knowledge');

//   // Get documents from the collection
//   QuerySnapshot<Object?> querySnapshot = await knowledge.get();

//   // Return the list of documents
//   return querySnapshot.docs;
// }
