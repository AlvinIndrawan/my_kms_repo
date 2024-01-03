import 'dart:io';
import 'package:flutter/material.dart';
import '../../services/create-knowledge-service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../../services/delete-knowledge-service.dart';
import '../../services/get-user-service.dart';
import '../../services/update-knowledge-service.dart';
import 'homepage.dart';

class EditKnowledge extends StatefulWidget {
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

  EditKnowledge(
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
  _EditKnowledgeState createState() => _EditKnowledgeState();
}

class _EditKnowledgeState extends State<EditKnowledge> {
  // Add your state variables here

  TextEditingController judulEditingController = TextEditingController();
  TextEditingController penjelasanEditingController = TextEditingController();

  //dosen : project base, modul kuliah, information
  // mahasiswa : project base, information, helpdesk
  // lab : helpdesk

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
  String imageName = '';
  File? _selectedImage;
  File? _selectedFile;
  String _selectedFileName = '';
  String _uploadedFileName = '';
  final picker = ImagePicker();

  bool isLoading = false;

  var user;

  List<String> list_category = [''];

  @override
  void initState() {
    super.initState();

    selectedOptionCategory = widget.type;
    judulEditingController.text = widget.title;
    selectedOptionMatkul = widget.category;
    image_cover = widget.image_cover;
    penjelasanEditingController.text = widget.penjelasan;
    attachment_file = widget.attachment_file_name;

    print('document id : ' + widget.document_id);

    Future<String> user_email = getEmailUser();
    user_email.then((value) async {
      var data_user = getDataUserByEmail(value);
      data_user.then((value) {
        setState(() {
          user = value;
        });
        setState(() {
          if (user['status'] == 'Dosen') {
            // selectedOptionCategory = 'Project Base';
            list_category = ['Project Base', 'Modul Kuliah', 'Informasi'];
          } else if (user['status'] == 'Mahasiswa') {
            // selectedOptionCategory = 'Project Base';
            list_category = ['Project Base', 'Informasi', 'Helpdesk'];
          } else {
            // selectedOptionCategory = 'Helpdesk';
            list_category = ['Helpdesk'];
          }
        });
        print('cek data : $value');
        print(value?['jurusan']);
      });
    });
  }

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
        imageName = '${DateTime.now().millisecondsSinceEpoch}.png';

        UploadTask uploadTask = FirebaseStorage.instance
            .ref('knowledge_images/$imageName')
            .putFile(_selectedImage!);

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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Knowledge Management System',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            // Navigate back to the previous screen
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          Text(
            'Edit Knowledge',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          (user != null)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        items: list_category.map((String value) {
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
                        errorText: isJudulMandatoryFieldFilled
                            ? null
                            : 'Field tidak boleh kosong',
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
                            ? Column(
                                children: [
                                  Image.file(_selectedImage!),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              )
                            : (image_cover != '')
                                ? Column(
                                    children: [
                                      Image.network(
                                        image_cover,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // height: 180,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        (loadingProgress
                                                                .expectedTotalBytes ??
                                                            1)
                                                    : null,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      SizedBox(height: 10)
                                    ],
                                  )
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
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xffdedede)),
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
                        : (attachment_file != '')
                            ? Text(attachment_file)
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
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xffdedede)),
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
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.4,
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
                                } else if (selectedOptionCategory ==
                                    'Modul Kuliah') {
                                  matkul_atau_kategori = selectedOptionMatkul;
                                } else if (selectedOptionCategory ==
                                    'Informasi') {
                                  matkul_atau_kategori =
                                      selectedOptionKategoriInformasi;
                                } else {
                                  matkul_atau_kategori =
                                      selectedOptionKategoriHelpdesk;
                                }
                                //Cek field judul kosong atau tidak
                                if (judulEditingController.text.isNotEmpty &&
                                    penjelasanEditingController
                                        .text.isNotEmpty) {
                                  if (any_image == true) {
                                    final String? imageDownloadUrl =
                                        await _uploadImage();
                                    print(imageDownloadUrl);
                                    image_cover = imageDownloadUrl.toString();
                                    deleteImage(widget.image_cover_name);
                                  } else if (any_image == false &&
                                      image_cover != '') {
                                    image_cover = widget.image_cover;
                                    imageName = widget.image_cover_name;
                                  } else {
                                    image_cover = '';
                                    imageName = '';
                                  }
                                  if (any_file == true) {
                                    final String? fileDownloadUrl =
                                        await _uploadFile();
                                    print(fileDownloadUrl);
                                    attachment_file =
                                        fileDownloadUrl.toString();
                                    deleteFile(widget.attachment_file_name);
                                  } else if (any_file == false &&
                                      attachment_file != '') {
                                    attachment_file =
                                        widget.attachment_file_name;
                                  } else {
                                    attachment_file = '';
                                  }

                                  Future<String> req_message = updateKnowledge(
                                      document_id: widget.document_id,
                                      status: "publish",
                                      type: selectedOptionCategory,
                                      title: judulEditingController.text,
                                      category: matkul_atau_kategori,
                                      image_cover: image_cover,
                                      image_cover_name: imageName,
                                      penjelasan:
                                          penjelasanEditingController.text,
                                      attachment_file: attachment_file,
                                      attachment_file_name:
                                          _uploadedFileName.toString(),
                                      author_name: user['nama'],
                                      author_email: user['email']);
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
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Homepage(index_start: 3)),
                                    );
                                  });
                                  setState(() {
                                    isJudulMandatoryFieldFilled = true;
                                    isPenjelasanMandatoryFieldFilled = true;
                                    isLoading = false;
                                  });
                                } else if (judulEditingController
                                        .text.isEmpty &&
                                    penjelasanEditingController
                                        .text.isNotEmpty) {
                                  setState(() {
                                    isJudulMandatoryFieldFilled = false;
                                    isPenjelasanMandatoryFieldFilled = true;
                                    isLoading = false;
                                  });
                                } else if (judulEditingController
                                        .text.isNotEmpty &&
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
                                    'Publish',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
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
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                //Cek nilai category atau matkul
                                if (selectedOptionCategory == 'Project Base') {
                                  matkul_atau_kategori = selectedOptionMatkul;
                                } else if (selectedOptionCategory ==
                                    'Modul Kuliah') {
                                  matkul_atau_kategori = selectedOptionMatkul;
                                } else if (selectedOptionCategory ==
                                    'Informasi') {
                                  matkul_atau_kategori =
                                      selectedOptionKategoriInformasi;
                                } else {
                                  matkul_atau_kategori =
                                      selectedOptionKategoriHelpdesk;
                                }
                                //Cek field judul kosong atau tidak
                                if (judulEditingController.text.isNotEmpty &&
                                    penjelasanEditingController
                                        .text.isNotEmpty) {
                                  if (any_image == true) {
                                    final String? imageDownloadUrl =
                                        await _uploadImage();
                                    print(imageDownloadUrl);
                                    image_cover = imageDownloadUrl.toString();
                                    deleteImage(widget.image_cover_name);
                                  } else if (image_cover != '') {
                                    image_cover = widget.image_cover;
                                    imageName = widget.image_cover_name;
                                  } else {
                                    image_cover = '';
                                    imageName = '';
                                  }
                                  if (any_file == true) {
                                    final String? fileDownloadUrl =
                                        await _uploadFile();
                                    print(fileDownloadUrl);
                                    attachment_file =
                                        fileDownloadUrl.toString();
                                    deleteFile(widget.attachment_file_name);
                                  } else if (attachment_file != '') {
                                    attachment_file =
                                        widget.attachment_file_name;
                                  } else {
                                    attachment_file = '';
                                  }

                                  Future<String> req_message = updateKnowledge(
                                      document_id: widget.document_id,
                                      status: "draft",
                                      type: selectedOptionCategory,
                                      title: judulEditingController.text,
                                      category: matkul_atau_kategori,
                                      image_cover: image_cover,
                                      image_cover_name: imageName,
                                      penjelasan:
                                          penjelasanEditingController.text,
                                      attachment_file: attachment_file,
                                      attachment_file_name:
                                          _uploadedFileName.toString(),
                                      author_name: user['nama'],
                                      author_email: user['email']);
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
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Homepage(index_start: 3)),
                                    );
                                  });
                                  setState(() {
                                    isJudulMandatoryFieldFilled = true;
                                    isPenjelasanMandatoryFieldFilled = true;
                                    isLoading = false;
                                  });
                                } else if (judulEditingController
                                        .text.isEmpty &&
                                    penjelasanEditingController
                                        .text.isNotEmpty) {
                                  setState(() {
                                    isJudulMandatoryFieldFilled = false;
                                    isPenjelasanMandatoryFieldFilled = true;
                                    isLoading = false;
                                  });
                                } else if (judulEditingController
                                        .text.isNotEmpty &&
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
                                  child: Text('Simpan Draft')),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                side: MaterialStateProperty.all<BorderSide>(
                                  BorderSide(width: 1.0, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                  ],
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.4,
                  ),
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }
}