import 'package:flutter/material.dart';

class CreateKnowledge extends StatefulWidget {
  @override
  _CreateKnowledgeState createState() => _CreateKnowledgeState();
}

class _CreateKnowledgeState extends State<CreateKnowledge> {
  // Add your state variables here
  String selectedOptionMatkul = 'Pemrograman Web';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(15),
      children: [
        Text(
          'Create Knowledge',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        //JUDUL
        Row(
          children: [
            Text('Judul'),
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
            hintText: 'Judul Knowledge',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        //MATA KULIAH
        Row(
          children: [
            Text('Mata kuliah'),
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
            value: selectedOptionMatkul,
            onChanged: (newValue) {
              setState(() {
                selectedOptionMatkul = newValue!;
              });
            },
            items: [
              'Pemrograman Web',
              'Algoritma',
              'Pemrograman Mobile',
              'Pemrograman Berorientasi Objek'
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
        SizedBox(
          height: 10,
        ),
        //UPLOAD GAMBAR COVER
        Text('Gambar cover'),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextButton(
            onPressed: () {
              // Insert the code you want to run when the button is pressed
            },
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Upload Gambar',
                  style: TextStyle(color: Colors.black),
                )),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xffdedede)),
            ),
          ),
        ),

        SizedBox(
          height: 10,
        ),
        //PENJELASAN
        Row(
          children: [
            Text('Penjelasan'),
            Text(
              '*', // Add your mandatory icon (e.g., an asterisk)
              style: TextStyle(
                color: Colors.red,
              ),
            )
          ],
        ),
        TextField(
          maxLines: 7,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Penjelasan isi knowledge',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        //UPLOAD ATTACHMENT FILE
        Text('Attachment File'),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextButton(
            onPressed: () {
              // Insert the code you want to run when the button is pressed
            },
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Upload File Attachment',
                  style: TextStyle(color: Colors.black),
                )),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xffdedede)),
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        //BUTTON CREATE & PUBLISH
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              // Insert the code you want to run when the button is pressed
            },
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text('Create & Publish')),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        //BUTTON Simpan Draft
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: OutlinedButton(
            onPressed: () {
              // Insert the code you want to run when the button is pressed
            },
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text('Simpan Draft')),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              side: MaterialStateProperty.all<BorderSide>(
                BorderSide(width: 1.0, color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
