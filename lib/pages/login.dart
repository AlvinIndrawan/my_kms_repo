import 'package:flutter/material.dart';
import 'home/homepage.dart';
import 'register.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Halaman Stateless'),
        // ),
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Center(
            child: Text(
              'Login KMS',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
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
          Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                // Insert the code you want to run when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text('Login')),
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
