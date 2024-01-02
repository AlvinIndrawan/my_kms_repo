// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import '../../services/get-user-service.dart';
import '../../services/comment-knowledge-service.dart';

class DetailKnowledge extends StatefulWidget {
  final String document_id;
  final String title;
  final String type;
  final String category;
  final String author;
  final String email_author;
  final String image_cover;
  final String penjelasan;
  final String attachment_file;
  final String attachment_file_name;

  DetailKnowledge(
      {required this.document_id,
      required this.title,
      required this.type,
      required this.category,
      required this.author,
      required this.email_author,
      required this.image_cover,
      required this.penjelasan,
      required this.attachment_file,
      required this.attachment_file_name});

  @override
  _DetailKnowledgeState createState() => _DetailKnowledgeState();
}

class _DetailKnowledgeState extends State<DetailKnowledge> {
  // Deklarasikan variabel state di sini

  TextEditingController commentEditingController = TextEditingController();

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return text.substring(0, maxLength) + '...';
  }

  Future<void> downloadFile(String url, String fileName) async {
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: '/storage/emulated/0/Download',
      fileName: fileName,
      // fileName: 'gambar naruto.jpg',
      showNotification: true,
      openFileFromNotification: true,
      headers: {"Range": ""},
    );

    FlutterDownloader.registerCallback((id, status, progress) {
      // Handle download status updates
      print(
          'Download task ($id) is in status ($status) and process ($progress)');
    });
  }

  var user;
  var comment;
  int jumlah_comment = 0;
  bool already_get_comment = false;

  @override
  void initState() {
    super.initState();
    Future<String> user_email = getEmailUser();
    user_email.then((value) async {
      var data_user = getDataUserByEmail(value);
      data_user.then((value) async {
        setState(() {
          user = value;
        });
        print('cek data : $value');
        print(widget.document_id);
        comment =
            await getCommentKnowledge(knowledgeDocument: widget.document_id);
        jumlah_comment = comment.length;
        already_get_comment = true;
        setState(() {});
        print(jumlah_comment);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
            widget.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          (widget.image_cover == '')
              ? Image.asset(
                  'assets/images/image background default.jpg',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                )
              : Image.network(
                  widget.image_cover,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
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
          SizedBox(
            height: 10,
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
                widget.type,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Row(
            children: [
              (widget.type == 'Project Base' || widget.type == 'Modul Kuliah')
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
                widget.category,
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
                widget.author,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            widget.penjelasan,
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 30,
          ),
          (widget.attachment_file == '' || widget.attachment_file_name == '')
              ? SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Attachment File',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        downloadFile(widget.attachment_file,
                            widget.attachment_file_name);
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Color(0xffdedede),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/icon file.png',
                              height: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              truncateText(widget.attachment_file_name, 30),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.file_download, size: 20),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
          Text(
            'Comments',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          (user != null)
              ? (widget.email_author != user['email'])
                  ? Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: (MediaQuery.of(context).size.width - 30) *
                                  0.8,
                              child: TextField(
                                controller: commentEditingController,
                                maxLines: 4,
                                minLines: 1,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  hintText: 'Tulis komentar..',
                                ),
                              ),
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width - 30) *
                                  0.2,
                              child: ElevatedButton(
                                onPressed: () async {
                                  //Cek komentar kosong atau tidak
                                  if (commentEditingController.text == '') {
                                    print('Tidak ada komentar');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text('Tidak ada komentar'),
                                      ),
                                    );
                                  } else {
                                    Future<String> req_message =
                                        commentKnowledge(
                                            widget.document_id,
                                            user['nama'],
                                            user['email'],
                                            commentEditingController.text);
                                    req_message.then((value) {
                                      String message = value;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: (message ==
                                                  'Komentar berhasil dikirim')
                                              ? Colors.green
                                              : Colors.red,
                                          content: Text(message),
                                        ),
                                      );
                                    });
                                    setState(() {
                                      commentEditingController.text = '';
                                    });
                                    comment = await getCommentKnowledge(
                                        knowledgeDocument: widget.document_id);
                                    jumlah_comment = comment.length;
                                    already_get_comment = true;
                                    setState(() {});
                                  }
                                },
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(
                                        vertical: 20), // Set the padding here
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          4), // Set the radius here
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10)
                      ],
                    )
                  : SizedBox()
              : SizedBox(),
          (already_get_comment)
              ? (jumlah_comment > 0)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: comment
                          .map<Widget>((comment) => Comment(
                                document_id: comment['document id'],
                                name: comment['nama'],
                                message: comment['comment'],
                              ))
                          .toList(),
                    )
                  : SizedBox()
              : SizedBox()
        ],
      ),
    );
  }
}

//CUSTOM WIDGET
class Comment extends StatelessWidget {
  final String document_id;
  final String name;
  final String message;

  Comment({
    required this.document_id,
    required this.name,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xffdedede),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            message,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
