import 'package:flutter/material.dart';
import 'detail-knowledge.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // Add your state variables here
  String selectedOptionCategory = 'Project Base';
  String selectedOptionMatkul = 'Semua';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(15),
      children: [
        TextField(
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            hintText: 'Cari Knowledge..',
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Container(
              width: (MediaQuery.of(context).size.width - 30) / 2,
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
                value: selectedOptionCategory,
                onChanged: (newValue) {
                  setState(() {
                    selectedOptionCategory = newValue!;
                  });
                },
                items: ['Project Base', 'Modul Kuliah', 'Informasi', 'Helpdesk']
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
            Container(
              width: (MediaQuery.of(context).size.width - 30) / 2,
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
                value: selectedOptionMatkul,
                onChanged: (newValue) {
                  setState(() {
                    selectedOptionMatkul = newValue!;
                  });
                },
                items: [
                  'Semua',
                  'Pemrograman Web',
                  'Algoritma',
                  'Pemrograman Mobile'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                isExpanded: true,
                underline: Container(),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        CustomCard(),
        CustomCard(),
      ],
    );
  }
}

//CUSTOM WIDGET

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle the tap action here
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailKnowledge()),
        );
      },
      child: Container(
        // padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(bottom: 20),
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
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.asset(
                'assets/images/contoh card.png',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 180,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Belajar Framework Bootstrap Untuk Pemrograman Web',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        'Kategori : ',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Project Base',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Mata Kuliah : ',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Pemrograman Web',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Author : ',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Alvin Indrawan',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
