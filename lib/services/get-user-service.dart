import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getEmailUser() async {
  try {
    User? user = await FirebaseAuth.instance.currentUser;

    if (user != null) {
      String email = user.email ?? 'Email not available';
      print('User Email: $email');
      return '$email';
    } else {
      print('User not found');
      return 'User not found';
    }
  } catch (e) {
    print('Error getting user: $e');
    return 'Error getting user: $e';
  }
}

Future<Map<String, dynamic>?> getDataUserByEmail(String userEmail) async {
  try {
    // Reference to the 'users' collection
    CollectionReference users = FirebaseFirestore.instance.collection('user');

    // Query to get the user document with a matching email
    QuerySnapshot querySnapshot =
        await users.where('email', isEqualTo: userEmail).get();

    if (querySnapshot.docs.isNotEmpty) {
      // Get the first document (assuming email is unique)
      DocumentSnapshot userDocument = querySnapshot.docs.first;

      // Access data from the document
      Map<String, dynamic> userData =
          userDocument.data() as Map<String, dynamic>;

      // Print or use the user data as needed
      print('User Data: $userData');
      return userData;
    } else {
      print('User not found with email: $userEmail');
      return null;
    }
  } catch (e) {
    print('Error fetching user data: $e');
    return null;
  }
}
