// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import '../../services/delete-knowledge-service.dart';
import '../../services/get-user-service.dart';
import '../../services/comment-knowledge-service.dart';
import '../../services/update-knowledge-service.dart';
import 'edit-knowledge.dart';
import 'homepage.dart';

class DetailKnowledge extends StatefulWidget {
  final String previous_page;
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

  DetailKnowledge(
      {required this.previous_page,
      required this.document_id,
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
  _DetailKnowledgeState createState() => _DetailKnowledgeState();
}

class _DetailKnowledgeState extends State<DetailKnowledge> {
  // Deklarasikan variabel state di sini

  TextEditingController commentEditingController = TextEditingController();
  TextEditingController replyEditingController = TextEditingController();
  bool button_reply_clicked = false;

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
  var comments;
  int jumlah_comment = 0;
  bool already_get_comment = false;
  String komen_email_yang_dibalas = '';
  String komen_pesan_yang_dibalas = '';

  @override
  void initState() {
    super.initState();
    Future<String> user_email = getEmailUser();
    user_email.then((value) async {
      if (widget.email_author == value) {
        nonActivateNotification(document_id: widget.document_id);
      }
      var data_user = getDataUserByEmail(value);
      data_user.then((value) async {
        setState(() {
          user = value;
        });
        print('cek data : $value');
        print('document id: ' + widget.document_id.toString());
        comments =
            await getCommentKnowledge(knowledgeDocument: widget.document_id);
        jumlah_comment = comments.length;
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
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Knowledge Management System',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            // Navigate back to the previous screen
            if (widget.previous_page == 'search') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Homepage(index_start: 1)),
              );
            } else if (widget.previous_page == 'myknowledge') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Homepage(index_start: 3)),
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          (user != null)
              ? (widget.email_author == user['email'])
                  ? Row(
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width - 30) * 0.7,
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width:
                              (MediaQuery.of(context).size.width - 30) * 0.15,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditKnowledge(
                                            document_id: widget.document_id,
                                            title: widget.title,
                                            type: widget.type,
                                            category: widget.category,
                                            author: widget.author,
                                            email_author: widget.email_author,
                                            image_cover: widget.image_cover,
                                            image_cover_name:
                                                widget.image_cover_name,
                                            penjelasan: widget.penjelasan,
                                            attachment_file:
                                                widget.attachment_file_name,
                                            attachment_file_name:
                                                widget.attachment_file_name,
                                          )),
                                );
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  EdgeInsets.symmetric(
                                      vertical: 15), // Set the padding here
                                ),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Colors
                                        .orangeAccent; // Default background color
                                  },
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        4), // Set the radius here
                                  ),
                                ),
                              )),
                        ),
                        Container(
                          width:
                              (MediaQuery.of(context).size.width - 30) * 0.15,
                          child: ElevatedButton(
                              onPressed: () {
                                showConfirmationDialog(context);
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  EdgeInsets.symmetric(
                                      vertical: 15), // Set the padding here
                                ),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Colors
                                        .red; // Default background color
                                  },
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        4), // Set the radius here
                                  ),
                                ),
                              )),
                        )
                      ],
                    )
                  : Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
              : Text(
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
                          color: Color.fromARGB(255, 158, 198, 236),
                          border: Border.all(
                            color: Colors.blueAccent,
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
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueAccent),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueAccent),
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
                                    activateNotification(
                                        document_id: widget.document_id);
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
                                    comments = await getCommentKnowledge(
                                        knowledgeDocument: widget.document_id);
                                    jumlah_comment = comments.length;
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
                                          Colors.blueAccent),
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
                      children: comments
                          .map<Widget>((comment) =>
                              // Comment(
                              //       document_id: comment['document id'],
                              //       name: comment['nama'],
                              //       message: comment['comment'],
                              //       author_email: widget.email_author,
                              //       user_email: user['email'],
                              //       button_reply_clicked: false,
                              //     )
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 158, 198, 236),
                                  border: Border.all(
                                    color: Colors.blueAccent,
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comment['nama'],
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      comment['comment'],
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    (widget.email_author == user['email'] &&
                                            comment['reply'] == '')
                                        ? Row(
                                            children: [
                                              Spacer(),
                                              TextButton(
                                                  onPressed: () {
                                                    if (button_reply_clicked) {
                                                      button_reply_clicked =
                                                          false;
                                                      komen_pesan_yang_dibalas =
                                                          '';
                                                      komen_email_yang_dibalas =
                                                          '';
                                                    } else {
                                                      button_reply_clicked =
                                                          true;
                                                      komen_pesan_yang_dibalas =
                                                          comment['comment'];
                                                      komen_email_yang_dibalas =
                                                          comment['email'];
                                                    }
                                                    setState(() {});
                                                  },
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty.all<
                                                            EdgeInsetsGeometry>(
                                                      EdgeInsets.all(
                                                          0), // Set the padding here
                                                    ),
                                                  ),
                                                  child: Text(
                                                    (button_reply_clicked ==
                                                                true &&
                                                            komen_pesan_yang_dibalas ==
                                                                comment[
                                                                    'comment'] &&
                                                            komen_email_yang_dibalas ==
                                                                comment[
                                                                    'email'])
                                                        ? 'Cancel'
                                                        : 'Reply',
                                                    textAlign: TextAlign.end,
                                                  ))
                                            ],
                                          )
                                        : SizedBox(),
                                    (button_reply_clicked &&
                                            komen_pesan_yang_dibalas ==
                                                comment['comment'] &&
                                            komen_email_yang_dibalas ==
                                                comment['email'])
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        65) *
                                                    0.8,
                                                child: TextField(
                                                  controller:
                                                      replyEditingController,
                                                  maxLines: 4,
                                                  minLines: 1,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black),
                                                    ),
                                                    hintText:
                                                        'Tulis balasan komentar..',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        65) *
                                                    0.2,
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    //Cek komentar kosong atau tidak
                                                    if (replyEditingController
                                                            .text ==
                                                        '') {
                                                      print(
                                                          'Tidak ada komentar');
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          backgroundColor:
                                                              Colors.red,
                                                          content: Text(
                                                              'Tidak ada balasan komentar'),
                                                        ),
                                                      );
                                                    } else {
                                                      String req_message =
                                                          await replyComment(
                                                              knowledgeDocumentId:
                                                                  widget
                                                                      .document_id,
                                                              commentDocumentId:
                                                                  comment[
                                                                      'document id'],
                                                              updatedData: {
                                                            'reply':
                                                                replyEditingController
                                                                    .text,

                                                            // Add more fields as needed
                                                          });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          backgroundColor:
                                                              (req_message ==
                                                                      'Balasan komentar berhasil dikirim')
                                                                  ? Colors.green
                                                                  : Colors.red,
                                                          content:
                                                              Text(req_message),
                                                        ),
                                                      );
                                                      // Navigator.pushReplacement(
                                                      //   context,
                                                      //   MaterialPageRoute(
                                                      //       builder: (context) =>
                                                      //           DetailKnowledge(
                                                      //             attachment_file:
                                                      //                 widget
                                                      //                     .attachment_file,
                                                      //             attachment_file_name:
                                                      //                 widget
                                                      //                     .attachment_file_name,
                                                      //             author: widget
                                                      //                 .author,
                                                      //             category: widget
                                                      //                 .category,
                                                      //             document_id:
                                                      //                 widget
                                                      //                     .document_id,
                                                      //             email_author:
                                                      //                 widget
                                                      //                     .email_author,
                                                      //             image_cover:
                                                      //                 widget
                                                      //                     .image_cover,
                                                      //             penjelasan: widget
                                                      //                 .penjelasan,
                                                      //             title: widget
                                                      //                 .title,
                                                      //             type: widget
                                                      //                 .type,
                                                      //           )),
                                                      // );
                                                      comments =
                                                          await getCommentKnowledge(
                                                              knowledgeDocument:
                                                                  widget
                                                                      .document_id);
                                                      jumlah_comment =
                                                          comments.length;
                                                      already_get_comment =
                                                          true;
                                                      setState(() {
                                                        replyEditingController
                                                            .text = '';
                                                        button_reply_clicked =
                                                            false;
                                                        komen_pesan_yang_dibalas =
                                                            '';
                                                        komen_email_yang_dibalas =
                                                            '';
                                                      });

                                                      // setState(() {});
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.send,
                                                    color: Colors.white,
                                                  ),
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty.all<
                                                            EdgeInsetsGeometry>(
                                                      EdgeInsets.symmetric(
                                                          vertical:
                                                              20), // Set the padding here
                                                    ),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                4), // Set the radius here
                                                      ),
                                                    ),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Colors.black),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        : SizedBox(),
                                    (comment['reply'] != '')
                                        ? Row(
                                            children: [
                                              Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  SizedBox(height: 20),
                                                  Text(
                                                    widget.author + ' (Author)',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    comment['reply'],
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        : SizedBox()
                                  ],
                                ),
                              ))
                          .toList(),
                    )
                  : SizedBox()
              : SizedBox()
        ],
      ),
    );
  }

  Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Yakin ingin menghapus knowledge ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Perform the action when confirmed
                Navigator.of(context).pop();
                performAction();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                // Dismiss the dialog when canceled
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  void performAction() {
    // Add your action logic here
    if (widget.image_cover != '') {
      deleteImage(widget.image_cover_name);
    }
    if (widget.attachment_file_name != '') {
      deleteFile(widget.attachment_file_name);
    }
    Future<String> req_message =
        deleteKnowledge(document_id: widget.document_id);
    req_message.then((value) {
      String message = value;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: (message == 'Knowledge berhasil di delete')
              ? Colors.green
              : Colors.red,
          content: Text(message),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage(index_start: 3)),
      );
    });
  }
}

//CUSTOM WIDGET
class Comment extends StatelessWidget {
  final String document_id;
  final String name;
  final String message;
  final String author_email;
  final String user_email;
  late final bool button_reply_clicked;

  Comment({
    required this.document_id,
    required this.name,
    required this.message,
    required this.author_email,
    required this.user_email,
    required this.button_reply_clicked,
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
          (author_email == user_email)
              ? Row(
                  children: [
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          button_reply_clicked = true;
                        },
                        style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.all(0), // Set the padding here
                          ),
                        ),
                        child: Text(
                          'Reply',
                          textAlign: TextAlign.end,
                        ))
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }
}
