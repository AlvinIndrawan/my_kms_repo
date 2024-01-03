import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> updateKnowledge(
    {required String document_id,
    required String status,
    required String type,
    required String title,
    required String category,
    required String image_cover,
    required String image_cover_name,
    required String penjelasan,
    required String attachment_file,
    required String attachment_file_name,
    required String author_name,
    required String author_email}) async {
  try {
    // Replace 'your_collection' with the name of your collection
    // Replace 'your_document_id' with the ID of the document you want to update
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('knowledge').doc(document_id);

    // Replace 'field1', 'field2', etc. with the fields you want to update
    // Replace 'new_value1', 'new_value2', etc. with the new values
    await docRef.update({
      'status': status,
      'type': type,
      'title': title,
      'category': category,
      'image cover': image_cover,
      'image cover name': image_cover_name,
      'penjelasan': penjelasan,
      'attachment file': attachment_file,
      'attachment file name': attachment_file_name,
      'nama author': author_name,
      'email author': author_email
      // Add more fields as needed
    });

    print("Knowledge Added");
    switch (status) {
      case "publish":
        return "Knowledge berhasil dipublish";
      case "draft":
        return "Knowledge berhasil disimpan sebagai draft";
      default:
        return "Invalid status";
    }
  } catch (error) {
    print("Failed to add knowledge: $error");
    return "Failed to edit knowledge: $error";
  }
}
