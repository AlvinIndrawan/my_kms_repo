import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
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

String checkLoginStatus() {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // User is already logged in
    print('User is signed in: ${user.uid}');
    return 'User sudah login';
  } else {
    // User is not logged in
    print('User is not signed in');
    return 'User belum login';
  }
}

Future<void> saveLoginStatus(bool isLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
}

// Function to check login status
// Future<bool> checkLoginStatus() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getBool('isLoggedIn') ?? false;
// }
