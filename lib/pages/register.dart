import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Buat variabel-variabel state di sini
  String selectedOptionJurusan = 'Teknik Informatika';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Halaman StatefulWidget'),
      // ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Center(
              child: Text(
                'Create Account',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            Text('Nama'),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nama',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Jurusan'),
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
            ),
            SizedBox(
              height: 10,
            ),
            Text('NIM/NIDN'),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'NIM/NIDN',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Password'),
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
            Text('Confirm Password'),
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
            Spacer(),
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
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
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
      ),
    );
  }
}
