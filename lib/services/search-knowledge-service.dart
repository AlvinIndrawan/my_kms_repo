import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Object>> getAllDataFromFirestore(String keyword) async {
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('knowledge');

  try {
    QuerySnapshot<Object?> querySnapshot = await collectionRef
        .where('title', isGreaterThanOrEqualTo: keyword)
        .where('title', isLessThanOrEqualTo: keyword + '\uf8ff')
        .get();

    // Handle the data and convert it to a list of maps
    List<Object> data = querySnapshot.docs.map((doc) => doc.data()!).toList();
    return data;
  } catch (error) {
    print('Error fetching data: $error');
    // Optionally, rethrow the error for higher-level error handling
    rethrow;
  }
}
