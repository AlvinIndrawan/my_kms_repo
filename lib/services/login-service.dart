import 'package:firebase_auth/firebase_auth.dart';

Future<String> loginUser(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print('User logged in successfully!');
    return 'Berhasil login';
  } catch (e) {
    print('Failed to log in: $e');
    return '$e';
    // Handle login failure, show error messages, etc.
  }
}

void checkLoginStatus() {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // User is already logged in
    print('User is signed in: ${user.uid}');
  } else {
    // User is not logged in
    print('User is not signed in');
  }
}
