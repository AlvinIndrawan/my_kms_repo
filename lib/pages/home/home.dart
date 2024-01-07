import 'package:flutter/material.dart';
import '../../services/get-user-service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Declare your state variables here
  var user;

  @override
  void initState() {
    super.initState();
    Future<String> user_email = getEmailUser();
    user_email.then((value) async {
      var data_user = getDataUserByEmail(value);
      data_user.then((value) {
        setState(() {
          user = value;
        });
        print('cek data : $value');
        print(value?['jurusan']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(15),
      children: [
        Text(
          'Welcome to KMS,',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          (user != null) ? user['nama'] : '',
          // 'Nama User',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
        ),
        SizedBox(
          height: 25,
        ),
        SizedBox(
          height: 107,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                width: 80,
                height: 100,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.build, color: Colors.blueAccent),
                    Text(
                      'Project Base',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                width: 80,
                height: 100,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.book, color: Colors.blueAccent),
                    Text(
                      'Modul Kuliah',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                width: 80,
                height: 100,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info, color: Colors.blueAccent),
                    Text(
                      'Informasi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                width: 80,
                height: 100,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.help_center, color: Colors.blueAccent),
                    Text(
                      'Helpdesk',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(15.0), // Set container background color
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Set shadow color
                spreadRadius: 3, // Set the spread radius of the shadow
                blurRadius: 5, // Set the blur radius of the shadow
                offset: Offset(0, 3), // Set the offset of the shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  'Temukan berbagai knowledge yang ingin anda pelajari disini!',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Spacer(),
              Image.asset(
                'assets/images/image 1.png',
                height: 100,
                // width: MediaQuery.of(context).size.width *
                //     0.25, // Set the height if needed
              )
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(15.0), // Set container background color
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Set shadow color
                spreadRadius: 3, // Set the spread radius of the shadow
                blurRadius: 5, // Set the blur radius of the shadow
                offset: Offset(0, 3), // Set the offset of the shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/images/image 2.png',
                height: 100,
                // width: MediaQuery.of(context).size.width *
                //     0.25, // Set the height if needed
              ),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  'Dapatkan informasi dan mempelajari berbagai knowledge disini!',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Mata Kuliah',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            // Text(
            //   'View All',
            //   style: TextStyle(
            //     fontSize: 15,
            //   ),
            // ),
          ],
        ),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                height: 100,
                width: MediaQuery.of(context).size.width * 0.35,
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
                child: Text(
                  'Pemrograman Web',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                height: 100,
                width: MediaQuery.of(context).size.width * 0.35,
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
                child: Text(
                  'Algoritma',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                height: 100,
                width: MediaQuery.of(context).size.width * 0.35,
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
                child: Text(
                  'Struktur Data',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                height: 100,
                width: MediaQuery.of(context).size.width * 0.35,
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
                child: Text(
                  'Explore Knowledge',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
