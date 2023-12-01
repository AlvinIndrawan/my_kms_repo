import 'package:flutter/material.dart';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Buat variabel-variabel state di sini
  String selectedOptionJurusan = 'Teknik Informatika';
  String selectedOptionUser = 'Mahasiswa';

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
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nama',
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
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'NIM/NIDN',
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
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Email',
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
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'No HP',
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
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Password',
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
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Confirm Password',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                // Insert the code you want to run when the button is pressed
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text('Create Account')),
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
                Navigator.pop(context);
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text('Login')),
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
    );
  }
}
