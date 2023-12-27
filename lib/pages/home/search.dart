import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../services/search-knowledge-service.dart';
import 'detail-knowledge.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // Add your state variables here

  TextEditingController searchEditingController = TextEditingController();
  // Stream<QuerySnapshot<Map<String, dynamic>>>? _searchResults;
  Stream<QuerySnapshot<Map<String, dynamic>>>? _searchResults;
  var data;
  int jumlah_data = 0;
  bool already_search = false;

  String selectedOptionCategory = 'Project Base';
  String selectedOptionMatkul = 'Semua';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(15),
      children: [
        TextField(
          controller: searchEditingController,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            hintText: 'Cari Knowledge..',
          ),
          onEditingComplete: () async {
            if (searchEditingController.text.isEmpty) {
              already_search = false;
              setState(() {});
            } else {
              data =
                  await getAllDataFromFirestore(searchEditingController.text);
              jumlah_data = data.length;
              already_search = true;
              setState(() {});
            }
          },
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
        (already_search)
            ? (jumlah_data > 0)
                ? Column(
                    children: data
                        .map<Widget>((knowledge) => CustomCard(
                              title: knowledge['title'],
                              type: knowledge['type'],
                              category: knowledge['category'],
                              author: 'Alvin Indrawan',
                              image_cover: 'assets/images/contoh card.png',
                              penjelasan: knowledge['penjelasan'],
                              attachment_file: knowledge['attachment file'],
                            ))
                        .toList(),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Center(
                      child: Image.asset(
                        'assets/images/not found.png',
                        width: 180,
                      ),
                    ),
                  )
            : Padding(
                padding: EdgeInsets.only(top: 100),
                child: Center(
                  child: Image.asset(
                    'assets/images/search.png',
                    width: 180,
                  ),
                ),
              ),
      ],
    );
  }
}

//CUSTOM WIDGET

class CustomCard extends StatelessWidget {
  final String title;
  final String type;
  final String category;
  final String author;
  final String image_cover;
  final String penjelasan;
  final String attachment_file;

  CustomCard(
      {required this.title,
      required this.type,
      required this.category,
      required this.author,
      required this.image_cover,
      required this.penjelasan,
      required this.attachment_file});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle the tap action here
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailKnowledge(
                    title: title,
                    type: type,
                    category: category,
                    author: author,
                    image_cover: image_cover,
                    penjelasan: penjelasan,
                    attachment_file: attachment_file,
                  )),
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
                image_cover,
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
                    title,
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
                        'Jenis Knowledge : ',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        type,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      (type == 'Project Base' || type == 'Modul Kuliah')
                          ? Text(
                              'Mata Kuliah : ',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            )
                          : Text(
                              'Kategori : ',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                      Text(
                        category,
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
                        author,
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
