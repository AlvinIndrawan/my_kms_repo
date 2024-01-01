import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Object>> getMyPublishedKnowledge(String email_author) async {
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('knowledge');

  try {
    QuerySnapshot<Object?> querySnapshot = await collectionRef
        .where('status', isEqualTo: 'publish')
        .where('email author', isEqualTo: email_author)
        .get();

    // Handle the data and convert it to a list of maps
    // List<Object> data = querySnapshot.docs.map((doc) => doc.data()!).toList();
    // return data;
    List<Map<String, dynamic>> documents = querySnapshot.docs
        .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
        .toList();
    return documents;
  } catch (error) {
    print('Error fetching data: $error');
    // Optionally, rethrow the error for higher-level error handling
    rethrow;
  }
}

Future<List<Object>> getMyDraftKnowledge(String email_author) async {
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('knowledge');

  try {
    QuerySnapshot<Object?> querySnapshot = await collectionRef
        .where('status', isEqualTo: 'draft')
        .where('email author', isEqualTo: email_author)
        .get();

    // Handle the data and convert it to a list of maps
    // List<Object> data = querySnapshot.docs.map((doc) => doc.data()!).toList();
    // return data;
    List<Map<String, dynamic>> documents = querySnapshot.docs
        .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
        .toList();
    return documents;
  } catch (error) {
    print('Error fetching data: $error');
    // Optionally, rethrow the error for higher-level error handling
    rethrow;
  }
}
