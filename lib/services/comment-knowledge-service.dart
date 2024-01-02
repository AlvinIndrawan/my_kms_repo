import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> commentKnowledge(
    String document_id, String nama, String email, String comment) async {
  // Replace 'your_collection' with the name of your main collection
  // Replace 'your_document_id' with the ID of the document where you want to add the collection
  CollectionReference mainCollection =
      FirebaseFirestore.instance.collection('knowledge');
  DocumentReference documentReference = mainCollection.doc(document_id);

  // Replace 'subcollection_name' with the name you want for the subcollection
  CollectionReference subCollection = documentReference.collection('comment');

  // Data to be added to the new document in the subcollection
  Map<String, dynamic> newData = {
    'nama': nama,
    'email': email,
    'comment': comment,
    'reply': '',
    // Add more fields as needed
  };

  try {
    // Add the data to the new document in the subcollection
    await subCollection.add(newData);
    print('Data added to subcollection successfully!');
    return 'Komentar berhasil dikirim';
  } catch (e) {
    print('Error adding data to subcollection: $e');
    return '$e';
  }
}

void getCommentKnowledge() async {
  try {
    // Replace 'your_collection' with the name of your collection
    // Replace 'your_document_id' with the ID of the document that contains the collection
    // Replace 'your_subcollection' with the name of the subcollection
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('knowledge')
        .doc('IGlS7VZUc1lIrZ2cY8kV')
        .collection('comment')
        .get();

    // Process the documents in the collection
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      // Access data from each document
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      print('Document ID: ${document.id}, Data: $data');
      print(querySnapshot.docs.length);
    });
  } catch (e) {
    print('Error fetching collection: $e');
  }
}
