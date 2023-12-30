import 'package:flutter/material.dart';
import '../../services/logout-service.dart';

class Profile extends StatelessWidget {
  String statusUser = 'Mahasiswa';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.black, // Set container background color
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Set shadow color
                spreadRadius: 3, // Set the spread radius of the shadow
                blurRadius: 5, // Set the blur radius of the shadow
                offset: Offset(0, 3), // Set the offset of the shadow
              ),
            ],
          ),
          child: Center(
            child: Column(
              children: [
                Spacer(),
                CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Colors.white, // Circle background color
                  child: Icon(
                    Icons.person,
                    size: 60.0, // Icon size
                    color: Colors.black, // Icon color
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Nama User',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  statusUser,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (statusUser == 'Mahasiswa' || statusUser == 'Dosen')
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text('Jurusan'),
                        SizedBox(height: 10),
                        Text(
                          'Teknik Informatika',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(
                          height: 20, // Adjust the height of the divider
                          color: Colors.grey, // Change the color of the divider
                        ),
                        SizedBox(height: 10),
                        Text('NIM/NIDN'),
                        SizedBox(height: 10),
                        Text(
                          '1234567890',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(
                          height: 20, // Adjust the height of the divider
                          color: Colors.grey, // Change the color of the divider
                        ),
                      ],
                    )
                  : SizedBox(),
              SizedBox(height: 10),
              Text('Email'),
              SizedBox(height: 10),
              Text(
                'alvin.av639@student.esaunggul.ac.id',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Divider(
                height: 20, // Adjust the height of the divider
                color: Colors.grey, // Change the color of the divider
              ),
              SizedBox(height: 10),
              Text('No HP'),
              SizedBox(height: 10),
              Text(
                '081234567890',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Divider(
                height: 20, // Adjust the height of the divider
                color: Colors.grey, // Change the color of the divider
              ),
              SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    // Insert the code you want to run when the button is pressed
                    Future<String> req_message = logoutUser();
                    req_message.then((value) {
                      String message = value;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: (message == 'Berhasil logout')
                              ? Colors.green
                              : Colors.red,
                          content: Text(message),
                        ),
                      );
                      if (message == 'Berhasil logout') {
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Logout',
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
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: () {
                    // Insert the code you want to run when the button is pressed
                  },
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text('Change Password')),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(width: 1.0, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
