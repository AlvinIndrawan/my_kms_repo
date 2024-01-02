import 'package:cloud_firestore/cloud_firestore.dart';

// Future<List<Object>> getAllDataFromFirestore(String keyword) async {
//   CollectionReference collectionRef =
//       FirebaseFirestore.instance.collection('knowledge');

//   try {
//     QuerySnapshot<Object?> querySnapshot = await collectionRef
//         .where('title', isGreaterThanOrEqualTo: keyword)
//         .where('title', isLessThanOrEqualTo: keyword + '\uf8ff')
//         .where('status', isEqualTo: 'publish')
//         .get();

//     // Handle the data and convert it to a list of maps
//     List<Object> data = querySnapshot.docs.map((doc) => doc.data()!).toList();
//     return data;
//   } catch (error) {
//     print('Error fetching data: $error');
//     // Optionally, rethrow the error for higher-level error handling
//     rethrow;
//   }
// }

Future<List<Object>> getAllDataFromFirestore(
    String keyword, String type, String category) async {
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('knowledge');

  QuerySnapshot<Object?> querySnapshot;

  try {
    if (category == 'Semua') {
      querySnapshot = await collectionRef
          .where('status', isEqualTo: 'publish')
          .where('type', isEqualTo: type)
          .where('title', isGreaterThanOrEqualTo: keyword)
          .where('title', isLessThanOrEqualTo: keyword + '\uf8ff')
          .get();
    } else {
      querySnapshot = await collectionRef
          .where('status', isEqualTo: 'publish')
          .where('type', isEqualTo: type)
          .where('category', isEqualTo: category)
          .where('title', isGreaterThanOrEqualTo: keyword)
          .where('title', isLessThanOrEqualTo: keyword + '\uf8ff')
          .get();
    }

    List<Map<String, dynamic>> documents = querySnapshot.docs
        .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
        .toList();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      documents[i]['document id'] = querySnapshot.docs[i].id;
      print(querySnapshot.docs[i].id);
      print(documents[i]);
    }
    return documents;
  } catch (error) {
    print('Error fetching data: $error');
    // Optionally, rethrow the error for higher-level error handling
    rethrow;
  }
}
