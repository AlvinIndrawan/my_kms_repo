import 'dart:io';

import 'package:flutter/material.dart';
import '../../services/create-knowledge-service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CreateKnowledge extends StatefulWidget {
  @override
  _CreateKnowledgeState createState() => _CreateKnowledgeState();
}

class _CreateKnowledgeState extends State<CreateKnowledge> {
  // Add your state variables here
  TextEditingController judulEditingController = TextEditingController();
  TextEditingController penjelasanEditingController = TextEditingController();

  String selectedOptionMatkul = 'Pemrograman Web';
  String selectedOptionKategoriInformasi = 'Perkuliahan';
  String selectedOptionKategoriHelpdesk = 'Software';
  String selectedOptionCategory = 'Project Base';

  String matkul_atau_kategori = '';

  bool isJudulMandatoryFieldFilled = true;
  bool isPenjelasanMandatoryFieldFilled = true;

  File? _selectedImage;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String> _uploadImage() async {
    if (_selectedImage != null) {
      try {
        String imageName =
            'knowledge_images/${DateTime.now().millisecondsSinceEpoch}.png';

        UploadTask uploadTask =
            FirebaseStorage.instance.ref(imageName).putFile(_selectedImage!);

        await uploadTask.whenComplete(() => print('Upload complete'));
        final String downloadURL =
            await uploadTask.snapshot.ref.getDownloadURL();

        print('Image uploaded. Download URL: $downloadURL');
        return downloadURL;
      } catch (error) {
        print('Error uploading image: $error');
        return '';
      }
    }
    return ''; // No image selected
  }

  @override
  Widget build(BuildContext context) {
    Widget selectedWidgetKategori;
    if (selectedOptionCategory == 'Project Base' ||
        selectedOptionCategory == 'Modul Kuliah') {
      selectedWidgetKategori = Container(
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
      );
    } else if (selectedOptionCategory == 'Informasi') {
      selectedWidgetKategori = Container(
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
          value: selectedOptionKategoriInformasi,
          onChanged: (newValue) {
            setState(() {
              selectedOptionKategoriInformasi = newValue!;
            });
          },
          items: [
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
      selectedWidgetKategori = Container(
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
          value: selectedOptionKategoriHelpdesk,
          onChanged: (newValue) {
            setState(() {
              selectedOptionKategoriHelpdesk = newValue!;
            });
          },
          items: [
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
      selectedWidgetKategori = SizedBox();
    }

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
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     _selectedImage != null
        //         ? Image.file(_selectedImage!)
        //         : Text('No image selected'),
        //     SizedBox(height: 20),
        //     ElevatedButton(
        //       onPressed: _pickImage,
        //       child: Text('Pick Image'),
        //     ),
        //     ElevatedButton(
        //       onPressed: _uploadImage,
        //       child: Text('Upload Image'),
        //     ),
        //   ],
        // ),
        // Center(
        //   child: Image.network(
        //     'https://firebasestorage.googleapis.com/v0/b/kms-esaunggul.appspot.com/o/knowledge_images%2F1703688198850.png?alt=media&token=348e434d-8d28-4dc1-a767-41749b65b348',
        //     loadingBuilder: (BuildContext context, Widget child,
        //         ImageChunkEvent? loadingProgress) {
        //       if (loadingProgress == null) {
        //         return child;
        //       } else {
        //         return Center(
        //           child: CircularProgressIndicator(
        //             value: loadingProgress.expectedTotalBytes != null
        //                 ? loadingProgress.cumulativeBytesLoaded /
        //                     (loadingProgress.expectedTotalBytes ?? 1)
        //                 : null,
        //           ),
        //         );
        //       }
        //     },
        //   ),
        // ),
        Row(
          children: [
            Text('Jenis Knowledge'),
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
        SizedBox(
          height: 10,
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
          controller: judulEditingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Judul Knowledge',
            errorText:
                isJudulMandatoryFieldFilled ? null : 'Field tidak boleh kosong',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        //MATA KULIAH
        Row(
          children: [
            (selectedOptionCategory == 'Project Base' ||
                    selectedOptionCategory == 'Modul Kuliah')
                ? Text('Mata kuliah')
                : Text('Kategori'),
            Text(
              '*', // Add your mandatory icon (e.g., an asterisk)
              style: TextStyle(
                color: Colors.red,
              ),
            )
          ],
        ),
        selectedWidgetKategori,
        SizedBox(
          height: 10,
        ),
        //UPLOAD GAMBAR COVER
        Text('Gambar cover'),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage != null
                ? Image.file(_selectedImage!)
                : SizedBox(height: 0),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: _pickImage,
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
          ],
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
          controller: penjelasanEditingController,
          maxLines: 7,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Penjelasan isi knowledge',
            errorText: isPenjelasanMandatoryFieldFilled
                ? null
                : 'Field tidak boleh kosong',
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
            onPressed: () async {
              //Cek nilai category atau matkul
              if (selectedOptionCategory == 'Project Base') {
                matkul_atau_kategori = selectedOptionMatkul;
              } else if (selectedOptionCategory == 'Modul Kuliah') {
                matkul_atau_kategori = selectedOptionMatkul;
              } else if (selectedOptionCategory == 'Informasi') {
                matkul_atau_kategori = selectedOptionKategoriInformasi;
              } else {
                matkul_atau_kategori = selectedOptionKategoriHelpdesk;
              }
              //Cek field judul kosong atau tidak
              if (judulEditingController.text.isNotEmpty &&
                  penjelasanEditingController.text.isNotEmpty) {
                final String? imageDownloadUrl = await _uploadImage();
                print(imageDownloadUrl);
                Future<String> req_message = createKnowledge(
                    status: "publish",
                    type: selectedOptionCategory,
                    title: judulEditingController.text,
                    category: matkul_atau_kategori,
                    image_cover: imageDownloadUrl.toString(),
                    penjelasan: penjelasanEditingController.text,
                    attachment_file: "ini attachment file");
                req_message.then((value) {
                  String message = value;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                    ),
                  );
                });
                setState(() {
                  isJudulMandatoryFieldFilled = true;
                  isPenjelasanMandatoryFieldFilled = true;
                });
              } else if (judulEditingController.text.isEmpty &&
                  penjelasanEditingController.text.isNotEmpty) {
                setState(() {
                  isJudulMandatoryFieldFilled = false;
                  isPenjelasanMandatoryFieldFilled = true;
                });
              } else if (judulEditingController.text.isNotEmpty &&
                  penjelasanEditingController.text.isEmpty) {
                setState(() {
                  isJudulMandatoryFieldFilled = true;
                  isPenjelasanMandatoryFieldFilled = false;
                });
              } else {
                setState(() {
                  isJudulMandatoryFieldFilled = false;
                  isPenjelasanMandatoryFieldFilled = false;
                });
              }
            },
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Create & Publish',
                  style: TextStyle(color: Colors.white),
                )),
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
