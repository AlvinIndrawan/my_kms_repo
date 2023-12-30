import 'dart:io';

import 'package:flutter/material.dart';
import '../../services/create-knowledge-service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

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
  bool any_image = false;
  bool any_file = false;
  bool file_oversized = false;

  String attachment_file = '';
  String image_cover = '';
  File? _selectedImage;
  File? _selectedFile;
  String _selectedFileName = '';
  String _uploadedFileName = '';
  final picker = ImagePicker();

  bool isLoading = false;

  List<String> splitStringBySingleQuote(String inputString) {
    List<String> separatedStrings = inputString.split("'");
    return separatedStrings;
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        any_image = true;
        print('ada gambar');
        _selectedImage = File(pickedFile.path);
      } else {
        any_image = false;
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
        return downloadURL.toString();
      } catch (error) {
        print('Error uploading image: $error');
        return '';
      }
    }
    return ''; // No image selected
  }

  Future<void> _pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    setState(() {
      if (result != null && result.files.isNotEmpty) {
        any_file = true;
        int totalSize = result.files
            .fold(0, (int acc, PlatformFile file) => acc + file.size!);
        if (totalSize > 5 * 1024 * 1024) {
          file_oversized = true;
          print('Total file size exceeds 5 MB.');
          _selectedFile = null;
        } else {
          file_oversized = false;
          _selectedFile = File(result.files.single.path!);
          List<String> separatedStrings = splitStringBySingleQuote(
              File(result.files.single.name).toString());
          _selectedFileName = separatedStrings[1].toString();
        }
      } else {
        any_file = false;
        _selectedFileName = '';
        print('No file selected.');
      }
    });
  }

  Future<String?> _uploadFile() async {
    if (_selectedFile != null) {
      try {
        _uploadedFileName =
            '${DateTime.now().millisecondsSinceEpoch}_${_selectedFile!.uri.pathSegments.last}';
        String fileName = 'knowledge_files/$_uploadedFileName';

        UploadTask uploadTask =
            FirebaseStorage.instance.ref(fileName).putFile(_selectedFile!);

        TaskSnapshot taskSnapshot =
            await uploadTask.whenComplete(() => print('Upload complete'));
        String downloadURL = await taskSnapshot.ref.getDownloadURL();

        print('File uploaded. Download URL: $downloadURL');
        return downloadURL.toString();
      } catch (error) {
        print('Error uploading file: $error');
        return '';
      }
    }
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
        _selectedFile != null
            ? Text(_selectedFileName.toString())
            : SizedBox(height: 0),
        (file_oversized)
            ? Text(
                'File lebih dari 5 MB',
                style: TextStyle(color: Colors.red),
              )
            : SizedBox(),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextButton(
            onPressed: _pickFile,
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
        (isLoading)
            ? Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.4,
                ),
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
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
                      if (any_image == true) {
                        final String? imageDownloadUrl = await _uploadImage();
                        print(imageDownloadUrl);
                        image_cover = imageDownloadUrl.toString();
                      } else {
                        image_cover = '';
                      }
                      if (any_file == true) {
                        final String? fileDownloadUrl = await _uploadFile();
                        print(fileDownloadUrl);
                        attachment_file = fileDownloadUrl.toString();
                      } else {
                        attachment_file = '';
                      }

                      Future<String> req_message = createKnowledge(
                          status: "publish",
                          type: selectedOptionCategory,
                          title: judulEditingController.text,
                          category: matkul_atau_kategori,
                          image_cover: image_cover,
                          penjelasan: penjelasanEditingController.text,
                          attachment_file: attachment_file,
                          attachment_file_name: _uploadedFileName.toString());
                      req_message.then((value) {
                        String message = value;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: (message ==
                                        'Knowledge berhasil dipublish' ||
                                    message ==
                                        'Knowledge berhasil disimpan sebagai draft')
                                ? Colors.green
                                : Colors.red,
                            content: Text(message),
                          ),
                        );
                      });
                      setState(() {
                        isJudulMandatoryFieldFilled = true;
                        isPenjelasanMandatoryFieldFilled = true;
                        isLoading = false;
                      });
                    } else if (judulEditingController.text.isEmpty &&
                        penjelasanEditingController.text.isNotEmpty) {
                      setState(() {
                        isJudulMandatoryFieldFilled = false;
                        isPenjelasanMandatoryFieldFilled = true;
                        isLoading = false;
                      });
                    } else if (judulEditingController.text.isNotEmpty &&
                        penjelasanEditingController.text.isEmpty) {
                      setState(() {
                        isJudulMandatoryFieldFilled = true;
                        isPenjelasanMandatoryFieldFilled = false;
                        isLoading = false;
                      });
                    } else {
                      setState(() {
                        isJudulMandatoryFieldFilled = false;
                        isPenjelasanMandatoryFieldFilled = false;
                        isLoading = false;
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
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                ),
              ),
        SizedBox(
          height: 10,
        ),
        //BUTTON Simpan Draft
        (isLoading)
            ? SizedBox()
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: () {
                    // Insert the code you want to run when the button is pressed
                  },
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text('Simpan Draft')),
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
    );
  }
}
