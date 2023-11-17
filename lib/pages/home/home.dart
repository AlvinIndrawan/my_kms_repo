import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(15),
      children: [
        Text(
          'Welcome to KMS,',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          'Nama User',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 40,
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
                width: MediaQuery.of(context).size.width * 0.55,
                child: Text(
                  'Temukan berbagai knowledge yang ingin anda pelajari disini!',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Spacer(),
              Image.asset(
                'assets/images/image1.png',
                width: MediaQuery.of(context).size.width *
                    0.25, // Set the height if needed
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
                'assets/images/image2.png',
                width: MediaQuery.of(context).size.width *
                    0.25, // Set the height if needed
              ),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Text(
                  'Temukan berbagai knowledge yang ingin anda pelajari disini!',
                  style: TextStyle(
                    fontSize: 15,
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
