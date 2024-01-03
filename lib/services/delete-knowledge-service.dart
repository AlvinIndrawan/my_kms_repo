import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> deleteKnowledge({required String document_id}) async {
  try {
    // Replace 'your_collection' with the name of your collection
    // Replace 'your_document_id' with the ID of the document you want to delete
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('knowledge').doc(document_id);

    await docRef.delete();

    print('Document deleted successfully!');
    return 'Knowledge berhasil di delete';
  } catch (e) {
    print('Error deleting document: $e');
    return '$e';
    // Handle the error as needed
  }
}

Future<void> deleteImage(String fileName) async {
  try {
    // Replace 'your_storage_reference' with the reference to your file in Firebase Storage
    Reference storageRef =
        FirebaseStorage.instance.ref().child('knowledge_images/$fileName');

    // Delete the file
    await storageRef.delete();

    print('Image deleted successfully!');
  } catch (e) {
    print('Error deleting images: $e');
    // Handle the error as needed
  }
}

Future<void> deleteFile(String fileName) async {
  try {
    // Replace 'your_storage_reference' with the reference to your file in Firebase Storage
    Reference storageRef =
        FirebaseStorage.instance.ref().child('knowledge_files/$fileName');

    // Delete the file
    await storageRef.delete();

    print('File deleted successfully!');
  } catch (e) {
    print('Error deleting file: $e');
    // Handle the error as needed
  }
}
