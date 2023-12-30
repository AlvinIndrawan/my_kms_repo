import 'package:firebase_auth/firebase_auth.dart';

Future<String> logoutUser() async {
  try {
    await FirebaseAuth.instance.signOut();
    print('User logged out successfully!');
    return 'Berhasil logout';
  } catch (e) {
    print('Failed to log out: $e');
    return '$e';
    // Handle logout failure, show error messages, etc.
  }
}
