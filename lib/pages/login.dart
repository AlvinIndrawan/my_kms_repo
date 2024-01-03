import 'package:flutter/material.dart';
import '../../services/login-service.dart';
import '../../services/logout-service.dart';
import 'home/homepage.dart';
import 'register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Deklarasikan variabel state di sini
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  bool isEmailMandatoryFieldFilled = true;
  bool isPasswordMandatoryFieldFilled = true;

  // @override
  // void initState() {
  //   super.initState();
  //   Future<String> req_message = logoutUser();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   String login_status = checkLoginStatus();
  //   if (login_status == 'User sudah login') {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => Homepage()),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ListView(
        children: [
          SizedBox(height: 50),
          Center(
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                    15.0), // Set container background color
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Set shadow color
                    spreadRadius: 3, // Set the spread radius of the shadow
                    blurRadius: 5, // Set the blur radius of the shadow
                    offset: Offset(0, 3), // Set the offset of the shadow
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/logo ueu.png',
                height: 80,
                // width: MediaQuery.of(context).size.width *
                //     0.25, // Set the height if needed
              ),
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: Text(
              'Login',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              'Knowledge Management System',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              'Fakultas Ilmu Komputer',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 50),
          SizedBox(
            height: 10,
          ),
          Text('Email'),
          TextField(
            controller: emailEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Email',
              errorText: isEmailMandatoryFieldFilled
                  ? null
                  : 'Field tidak boleh kosong',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Password'),
          TextField(
            controller: passwordEditingController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Password',
              errorText: isPasswordMandatoryFieldFilled
                  ? null
                  : 'Field tidak boleh kosong',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(height: 50),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () async {
                //Cek apakah fieldnya kosong?
                if (emailEditingController.text.isNotEmpty &&
                    passwordEditingController.text.isNotEmpty) {
                  setState(() {
                    isEmailMandatoryFieldFilled = true;
                    isPasswordMandatoryFieldFilled = true;
                  });
                  Future<String> req_message = loginUser(
                      emailEditingController.text,
                      passwordEditingController.text);
                  req_message.then((value) async {
                    String message;
                    if (value == 'Berhasil login') {
                      message = value;
                    } else if (value ==
                        '[firebase_auth/invalid-email] The email address is badly formatted.') {
                      message = 'Format email tidak valid';
                    } else if (value ==
                        '[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.') {
                      message = 'Email atau password salah';
                    } else {
                      message = value;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: (message == 'Berhasil login')
                            ? Colors.green
                            : Colors.red,
                        content: Text(message),
                      ),
                    );
                    if (message == 'Berhasil login') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Homepage(index_start: 0)),
                      );
                      // await saveLoginStatus(true);
                    }
                  });
                } else if (emailEditingController.text.isEmpty &&
                    passwordEditingController.text.isNotEmpty) {
                  setState(() {
                    isEmailMandatoryFieldFilled = false;
                    isPasswordMandatoryFieldFilled = true;
                  });
                } else if (emailEditingController.text.isNotEmpty &&
                    passwordEditingController.text.isEmpty) {
                  setState(() {
                    isEmailMandatoryFieldFilled = true;
                    isPasswordMandatoryFieldFilled = false;
                  });
                } else {
                  setState(() {
                    isEmailMandatoryFieldFilled = false;
                    isPasswordMandatoryFieldFilled = false;
                  });
                }
                // Insert the code you want to run when the button is pressed
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Homepage()),
                // );
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  )),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: OutlinedButton(
              onPressed: () {
                // Insert the code you want to run when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Register()),
                );
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text('Create Account')),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                side: MaterialStateProperty.all<BorderSide>(
                  BorderSide(width: 1.0, color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    ));
  }
}
