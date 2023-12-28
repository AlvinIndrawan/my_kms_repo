import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> createKnowledge(
    {required String status,
    required String type,
    required String title,
    required String category,
    required String image_cover,
    required String penjelasan,
    required String attachment_file,
    required String attachment_file_name}) async {
  try {
    // Get a reference to the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Collection reference
    CollectionReference knowledge = firestore.collection('knowledge');

    // Add a document with a generated ID
    await knowledge.add({
      'status': status,
      'type': type,
      'title': title,
      'category': category,
      'image cover': image_cover,
      'penjelasan': penjelasan,
      'attachment file': attachment_file,
      'attachment file name': attachment_file_name,
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
    return "Failed to add knowledge: $error";
  }
}
