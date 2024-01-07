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

  var data;
  int jumlah_data = 0;
  bool already_search = false;

  String selectedOptionCategory = 'Project Base';
  String selectedOptionMatkul = 'Semua';

  @override
  Widget build(BuildContext context) {
    Widget selected_widget_type;
    if (selectedOptionCategory == 'Project Base' ||
        selectedOptionCategory == 'Modul Kuliah') {
      selected_widget_type = Container(
        width: (MediaQuery.of(context).size.width - 30) / 2,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueAccent,
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
            'Struktur Data',
            'Desain dan Analisa Algoritma',
            'Basis Data',
            'Bahasa Pemograman',
            'Pemograman Berorientasi Objek',
            'Jaringan Komputer',
            'Machine Learning',
            'Pemograman Mobile',
            'Jaringan Komputer lanjut dan Lab'
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          isExpanded: true,
          underline: Container(),
        ),
      );
    } else if (selectedOptionCategory == 'Informasi') {
      selected_widget_type = Container(
        width: (MediaQuery.of(context).size.width - 30) / 2,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueAccent,
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
            'Perkuliahan',
            'Lab',
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          isExpanded: true,
          underline: Container(),
        ),
      );
    } else if (selectedOptionCategory == 'Helpdesk') {
      selected_widget_type = Container(
        width: (MediaQuery.of(context).size.width - 30) / 2,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueAccent,
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
            'Software',
            'Koneksi Internet',
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          isExpanded: true,
          underline: Container(),
        ),
      );
    } else {
      selected_widget_type = SizedBox();
    }

    return ListView(
      padding: EdgeInsets.all(15),
      children: [
        Row(
          children: [
            Container(
              width: (MediaQuery.of(context).size.width - 30) * 0.8,
              child: TextField(
                controller: searchEditingController,
                decoration: InputDecoration(
                  // suffixIcon: Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  hintText: 'Cari Knowledge..',
                ),
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width - 30) * 0.2,
              child: ElevatedButton(
                onPressed: () async {
                  if (searchEditingController.text.isEmpty) {
                    already_search = false;
                    setState(() {});
                  } else {
                    data = await getAllDataFromFirestore(
                        searchEditingController.text,
                        selectedOptionCategory,
                        selectedOptionMatkul);
                    jumlah_data = data.length;
                    already_search = true;
                    setState(() {});
                  }
                },
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 20), // Set the padding here
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(4), // Set the radius here
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueAccent),
                ),
              ),
            )
          ],
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
                  color: Colors.blueAccent,
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
                    selectedOptionMatkul = 'Semua';
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
            selected_widget_type,
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
                              document_id: knowledge['document id'],
                              title: knowledge['title'],
                              type: knowledge['type'],
                              category: knowledge['category'],
                              author: knowledge['nama author'],
                              email_author: knowledge['email author'],
                              image_cover: knowledge['image cover'],
                              image_cover_name: knowledge['image cover name'],
                              penjelasan: knowledge['penjelasan'],
                              attachment_file: knowledge['attachment file'],
                              attachment_file_name:
                                  knowledge['attachment file name'],
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
  final String document_id;
  final String title;
  final String type;
  final String category;
  final String author;
  final String email_author;
  final String image_cover;
  final String image_cover_name;
  final String penjelasan;
  final String attachment_file;
  final String attachment_file_name;

  CustomCard(
      {required this.document_id,
      required this.title,
      required this.type,
      required this.category,
      required this.author,
      required this.email_author,
      required this.image_cover,
      required this.image_cover_name,
      required this.penjelasan,
      required this.attachment_file,
      required this.attachment_file_name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle the tap action here
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailKnowledge(
                    previous_page: 'search',
                    document_id: document_id,
                    title: title,
                    type: type,
                    category: category,
                    author: author,
                    email_author: email_author,
                    image_cover: image_cover,
                    image_cover_name: image_cover_name,
                    penjelasan: penjelasan,
                    attachment_file: attachment_file,
                    attachment_file_name: attachment_file_name,
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
              child: (image_cover == '')
                  ? Image.asset(
                      'assets/images/image background default.jpg',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                    )
                  : Image.network(
                      image_cover,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
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
