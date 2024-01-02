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

Future<List<Map<String, dynamic>>> getCommentKnowledge({
  required String knowledgeDocument,
}) async {
  try {
    // Replace 'knowledge' with the name of your collection
    // Replace 'comment' with the name of the subcollection
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('knowledge')
        .doc(knowledgeDocument)
        .collection('comment')
        .get();

    List<Map<String, dynamic>> comments =
        querySnapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> commentData =
          document.data() as Map<String, dynamic>;
      commentData['document id'] = document.id;
      return commentData;
    }).toList();

    return comments;
  } catch (e) {
    print('Error fetching collection: $e');
    rethrow;
  }
}

Future<String> replyComment({
  required String knowledgeDocumentId,
  required String commentDocumentId,
  required Map<String, dynamic> updatedData,
}) async {
  try {
    // Reference the parent document
    DocumentReference parentDocumentRef = FirebaseFirestore.instance
        .collection('knowledge')
        .doc(knowledgeDocumentId);

    // Reference the nested collection within the parent document
    CollectionReference nestedCollectionRef =
        parentDocumentRef.collection('comment');

    // Reference the specific document within the nested collection
    DocumentReference nestedDocumentRef =
        nestedCollectionRef.doc(commentDocumentId);

    // Update the data in the nested document
    await nestedDocumentRef.update(updatedData);

    print('Document updated successfully!');
    return 'Balasan komentar berhasil dikirim';
  } catch (e) {
    print('Error updating document: $e');
    return '$e';
    // Handle the error as needed
  }
}
