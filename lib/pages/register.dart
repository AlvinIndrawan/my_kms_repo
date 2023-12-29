import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Buat variabel-variabel state di sini
  String selectedOptionJurusan = 'Teknik Informatika';
  String selectedOptionUser = 'Mahasiswa';

  TextEditingController namaEditingController = TextEditingController();
  TextEditingController nimEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController nohpEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confrimPasswordEditingController =
      TextEditingController();

  bool isNamaMandatoryFieldFilled = true;
  bool isNimMandatoryFieldFilled = true;
  bool isEmailMandatoryFieldFilled = true;
  bool isNoHPMandatoryFieldFilled = true;
  bool isPasswordMandatoryFieldFilled = true;
  bool isConfirmPasswordMandatoryFieldFilled = true;
  bool isPasswordSameWithConfirmPassword = true;

  bool isLoading = false;

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User registered successfully!');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil register!'),
        ),
      );
    } catch (e) {
      // Handle registration failure, show error messages, etc.
      print('Failed to register user: $e');
      if ('$e' ==
          '[firebase_auth/invalid-email] The email address is badly formatted.') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Format email tidak valid'),
          ),
        );
      } else if ('$e' ==
          '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Email yang digunakan sudah terdaftar. Gunakan email lain!'),
          ),
        );
      } else if ('$e' ==
          '[firebase_auth/weak-password] Password should be at least 6 characters') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password minimal harus 6 karakter'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$e'),
          ),
        );
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Halaman StatefulWidget'),
      // ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'Create Account',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Text('Daftar Sebagai'),
              Text(
                '*', // Add your mandatory icon (e.g., an asterisk)
                style: TextStyle(
                  color: Colors.red,
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: DropdownButton<String>(
              value: selectedOptionUser,
              onChanged: (newValue) {
                setState(() {
                  selectedOptionUser = newValue!;
                });
              },
              items: ['Mahasiswa', 'Dosen', 'Pengurus Lab'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isExpanded: true,
              underline: Container(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text('Nama'),
              Text(
                '*', // Add your mandatory icon (e.g., an asterisk)
                style: TextStyle(
                  color: Colors.red,
                ),
              )
            ],
          ),
          TextField(
            controller: namaEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nama',
              errorText: isNamaMandatoryFieldFilled
                  ? null
                  : 'Field tidak boleh kosong',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          (selectedOptionUser == 'Mahasiswa' || selectedOptionUser == 'Dosen')
              ? Row(
                  children: [
                    Text('Jurusan'),
                    Text(
                      '*', // Add your mandatory icon (e.g., an asterisk)
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )
                  ],
                )
              : SizedBox(),
          (selectedOptionUser == 'Mahasiswa' || selectedOptionUser == 'Dosen')
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: DropdownButton<String>(
                    value: selectedOptionJurusan,
                    onChanged: (newValue) {
                      setState(() {
                        selectedOptionJurusan = newValue!;
                      });
                    },
                    items: ['Teknik Informatika', 'Sistem Informasi']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    isExpanded: true,
                    underline: Container(),
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: (selectedOptionUser == 'Mahasiswa' ||
                    selectedOptionUser == 'Dosen')
                ? 10
                : 0,
          ),
          (selectedOptionUser == 'Mahasiswa' || selectedOptionUser == 'Dosen')
              ? Row(
                  children: [
                    Text('NIM/NIDN'),
                    Text(
                      '*', // Add your mandatory icon (e.g., an asterisk)
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )
                  ],
                )
              : SizedBox(),
          (selectedOptionUser == 'Mahasiswa' || selectedOptionUser == 'Dosen')
              ? TextField(
                  controller: nimEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'NIM/NIDN',
                    errorText: isNimMandatoryFieldFilled
                        ? null
                        : 'Field tidak boleh kosong',
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: (selectedOptionUser == 'Mahasiswa' ||
                    selectedOptionUser == 'Dosen')
                ? 10
                : 0,
          ),
          Row(
            children: [
              Text('Email'),
              Text(
                '*', // Add your mandatory icon (e.g., an asterisk)
                style: TextStyle(
                  color: Colors.red,
                ),
              )
            ],
          ),
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
          Row(
            children: [
              Text('No HP'),
              Text(
                '*', // Add your mandatory icon (e.g., an asterisk)
                style: TextStyle(
                  color: Colors.red,
                ),
              )
            ],
          ),
          TextField(
            controller: nohpEditingController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'No HP',
              errorText: isNoHPMandatoryFieldFilled
                  ? null
                  : 'Field tidak boleh kosong',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text('Password'),
              Text(
                '*', // Add your mandatory icon (e.g., an asterisk)
                style: TextStyle(
                  color: Colors.red,
                ),
              )
            ],
          ),
          TextField(
            controller: passwordEditingController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Password',
              errorText: isPasswordMandatoryFieldFilled
                  ? (isPasswordSameWithConfirmPassword)
                      ? null
                      : 'Password dan confirm password harus sama'
                  : 'Field tidak boleh kosong',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text('Confirm Password'),
              Text(
                '*', // Add your mandatory icon (e.g., an asterisk)
                style: TextStyle(
                  color: Colors.red,
                ),
              )
            ],
          ),
          TextField(
            controller: confrimPasswordEditingController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Confirm Password',
              errorText: isConfirmPasswordMandatoryFieldFilled
                  ? (isPasswordSameWithConfirmPassword)
                      ? null
                      : 'Password dan confirm password harus sama'
                  : 'Field tidak boleh kosong',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 30,
          ),
          (isLoading)
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.4,
                  ),
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      //Cek status user
                      if (selectedOptionUser == 'Mahasiswa' ||
                          selectedOptionUser == 'Dosen') {
                        //Mahasiswa atau Dosen
                        // Cek field ada yang kosong tidak
                        if (namaEditingController.text.isNotEmpty &&
                            nimEditingController.text.isNotEmpty &&
                            emailEditingController.text.isNotEmpty &&
                            nohpEditingController.text.isNotEmpty &&
                            passwordEditingController.text.isNotEmpty &&
                            confrimPasswordEditingController.text.isNotEmpty) {
                          //Cek Password sama dengan confirm password tidak
                          if (passwordEditingController.text ==
                              confrimPasswordEditingController.text) {
                            isNamaMandatoryFieldFilled = true;
                            isNimMandatoryFieldFilled = true;
                            isEmailMandatoryFieldFilled = true;
                            isNoHPMandatoryFieldFilled = true;
                            isPasswordMandatoryFieldFilled = true;
                            isConfirmPasswordMandatoryFieldFilled = true;
                            isPasswordSameWithConfirmPassword = true;
                            registerWithEmailAndPassword(
                                emailEditingController.text,
                                passwordEditingController.text);
                            print('berhasil register');
                          } else {
                            setState(() {
                              isPasswordMandatoryFieldFilled = true;
                              isConfirmPasswordMandatoryFieldFilled = true;
                              isPasswordSameWithConfirmPassword = false;
                              isLoading = false;
                            });
                          }
                        } else {
                          setState(() {
                            if (namaEditingController.text.isEmpty) {
                              isNamaMandatoryFieldFilled = false;
                            } else if (namaEditingController.text.isNotEmpty) {
                              isNamaMandatoryFieldFilled = true;
                            }
                            if (nimEditingController.text.isEmpty) {
                              isNimMandatoryFieldFilled = false;
                            } else if (nimEditingController.text.isNotEmpty) {
                              isNimMandatoryFieldFilled = true;
                            }
                            if (emailEditingController.text.isEmpty) {
                              isEmailMandatoryFieldFilled = false;
                            } else if (emailEditingController.text.isNotEmpty) {
                              isEmailMandatoryFieldFilled = true;
                            }
                            if (nohpEditingController.text.isEmpty) {
                              isNoHPMandatoryFieldFilled = false;
                            } else if (nohpEditingController.text.isNotEmpty) {
                              isNoHPMandatoryFieldFilled = true;
                            }
                            if (passwordEditingController.text.isEmpty) {
                              isPasswordMandatoryFieldFilled = false;
                            } else if (passwordEditingController
                                .text.isNotEmpty) {
                              isPasswordMandatoryFieldFilled = true;
                            }
                            if (confrimPasswordEditingController.text.isEmpty) {
                              isConfirmPasswordMandatoryFieldFilled = false;
                            } else if (confrimPasswordEditingController
                                .text.isNotEmpty) {
                              isConfirmPasswordMandatoryFieldFilled = true;
                            }
                            isLoading = false;
                          });
                        }
                      } else {
                        //Pengurus Lab
                        // Cek field ada yang kosong tidak
                        if (namaEditingController.text.isNotEmpty &&
                            emailEditingController.text.isNotEmpty &&
                            nohpEditingController.text.isNotEmpty &&
                            passwordEditingController.text.isNotEmpty &&
                            confrimPasswordEditingController.text.isNotEmpty) {
                          //tambah data disini
                        } else {
                          setState(() {
                            if (namaEditingController.text.isEmpty) {
                              isNamaMandatoryFieldFilled = false;
                            } else if (namaEditingController.text.isNotEmpty) {
                              isNamaMandatoryFieldFilled = true;
                            }
                            if (emailEditingController.text.isEmpty) {
                              isEmailMandatoryFieldFilled = false;
                            } else if (emailEditingController.text.isNotEmpty) {
                              isEmailMandatoryFieldFilled = true;
                            }
                            if (nohpEditingController.text.isEmpty) {
                              isNoHPMandatoryFieldFilled = false;
                            } else if (nohpEditingController.text.isNotEmpty) {
                              isNoHPMandatoryFieldFilled = true;
                            }
                            if (passwordEditingController.text.isEmpty) {
                              isPasswordMandatoryFieldFilled = false;
                            } else if (passwordEditingController
                                .text.isNotEmpty) {
                              isPasswordMandatoryFieldFilled = true;
                            }
                            if (confrimPasswordEditingController.text.isEmpty) {
                              isConfirmPasswordMandatoryFieldFilled = false;
                            } else if (confrimPasswordEditingController
                                .text.isNotEmpty) {
                              isConfirmPasswordMandatoryFieldFilled = true;
                            }
                            isLoading = false;
                          });
                        }
                      }
                    },
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Create Account',
                          style: TextStyle(color: Colors.white),
                        )),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                  ),
                ),
          SizedBox(
            height: 10,
          ),
          (isLoading)
              ? SizedBox()
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                    onPressed: () {
                      // Insert the code you want to run when the button is pressed
                      Navigator.pop(context);
                    },
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text('Login')),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
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
    );
  }
}
