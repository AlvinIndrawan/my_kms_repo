import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class DetailKnowledge extends StatelessWidget {
  final String title;
  final String type;
  final String category;
  final String author;
  final String image_cover;
  final String penjelasan;
  final String attachment_file;
  final String attachment_file_name;

  DetailKnowledge(
      {required this.title,
      required this.type,
      required this.category,
      required this.author,
      required this.image_cover,
      required this.penjelasan,
      required this.attachment_file,
      required this.attachment_file_name});

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

  // Future<void> _downloadFileHTTP(String url, String fileName) async {
  //   final response = await http.get(Uri.parse(url));

  //   if (response.statusCode == 200) {
  //     final directory = '/storage/emulated/0/Download';
  //     final filePath =
  //         '${directory}/${fileName}'; // Replace with your desired file name

  //     final File file = File(filePath);
  //     await file.writeAsBytes(response.bodyBytes);

  //     // You can now use the 'file' variable to get information about the downloaded file
  //     print('File downloaded to: $filePath');
  //   } else {
  //     // Handle the error
  //     print('Failed to download file. Status code: ${response.statusCode}');
  //   }
  // }

  // Future<void> downloadFileFirebase(
  //     String storagePath, String localPath) async {
  //   final storageRef = FirebaseStorage.instance.ref();
  //   final islandRef = storageRef
  //       .child("knowledge_files/1703850566679_LOA Peserta MSIB 5 (313).pdf");

  //   final fileName = 'downloaded ' + localPath;
  //   final filePath = "/storage/emulated/0/Download/$fileName";
  //   final file = File(filePath);

  //   final downloadTask = islandRef.writeToFile(file);
  //   downloadTask.snapshotEvents.listen((taskSnapshot) {
  //     switch (taskSnapshot.state) {
  //       case TaskState.running:
  //         // TODO: Handle this case.
  //         break;
  //       case TaskState.paused:
  //         // TODO: Handle this case.
  //         break;
  //       case TaskState.success:
  //         print('Download success');
  //         break;
  //       case TaskState.canceled:
  //         // TODO: Handle this case.
  //         break;
  //       case TaskState.error:
  //         print('ERROR: Download failed');
  //         break;
  //     }
  //   });
  // }

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
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          (image_cover == '')
              ? Image.asset(
                  'assets/images/contoh card.png',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                )
              : Image.network(
                  image_cover,
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
          SizedBox(
            height: 30,
          ),
          Text(
            penjelasan,
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 30,
          ),
          (attachment_file == '' || attachment_file_name == '')
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
                        downloadFile(attachment_file, attachment_file_name);
                        // _downloadFileHTTP(attachment_file, attachment_file_name);
                        // downloadFileFirebase(attachment_file, attachment_file_name);
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
                              truncateText(attachment_file_name, 30),
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
          TextField(
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.send),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              hintText: 'Tulis komentar..',
            ),
          ),
          SizedBox(height: 10),
          Comment(),
          Comment(),
        ],
      ),
    );
  }
}

//CUSTOM WIDGET
class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nama User',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tortor id aliquet lectus proin nibh nisl condimentum id.',
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
