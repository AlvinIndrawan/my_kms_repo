import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> addUser(
    {required String status,
    required String nama,
    required String jurusan,
    required String nim,
    required String email,
    required String no_hp}) async {
  try {
    // Get a reference to the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Collection reference
    CollectionReference user = firestore.collection('user');

    // Add a document with a generated ID
    await user.add({
      'status': status,
      'nama': nama,
      'jurusan': jurusan,
      'nim': nim,
      'email': email,
      'no hp': no_hp,
    });

    print("User Added");
    return "Berhasil register!";
  } catch (error) {
    print("Failed to register: $error");
    return "Failed to register: $error";
  }
}
