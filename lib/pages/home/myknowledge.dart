import 'package:flutter/material.dart';
import '../../services/get-user-service.dart';
import '../../services/get-myknowledge-service.dart';
import 'detail-knowledge.dart';

class Myknowledge extends StatefulWidget {
  @override
  _MyknowledgeState createState() => _MyknowledgeState();
}

class _MyknowledgeState extends State<Myknowledge>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  var user;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future<String> user_email = getEmailUser();
    user_email.then((value) async {
      var data_user = getDataUserByEmail(value);
      data_user.then((value) async {
        setState(() {
          user = value;
        });
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: TabBar(
            indicatorColor: Colors.black,
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                height: 60,
                child: Text(
                  'Published',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                height: 60,
                child: Text(
                  'Draft',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            labelColor: Colors.black,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              //PUBLISHED TAB
              (user != null)
                  ? Padding(
                      padding: EdgeInsets.all(15),
                      child: FutureBuilder(
                        future: getMyPublishedKnowledge(user['email']),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<Map<String, dynamic>> documents =
                                snapshot.data as List<Map<String, dynamic>>;
                            // Process your documents here
                            return (documents.length > 0)
                                ? ListView.builder(
                                    itemCount: documents.length,
                                    itemBuilder: (context, index) {
                                      // Build your UI based on the retrieved data
                                      return CustomCard(
                                        document_id: documents[index]
                                                ['document id']
                                            .toString(),
                                        title: documents[index]['title']
                                            .toString(),
                                        image_cover: documents[index]
                                                ['image cover']
                                            .toString(),
                                        image_cover_name: documents[index]
                                                ['image cover name']
                                            .toString(),
                                        type:
                                            documents[index]['type'].toString(),
                                        attachment_file: documents[index]
                                                ['attachment file']
                                            .toString(),
                                        attachment_file_name: documents[index]
                                                ['attachment file name']
                                            .toString(),
                                        author: documents[index]['nama author']
                                            .toString(),
                                        category: documents[index]['category']
                                            .toString(),
                                        email_author: documents[index]
                                                ['email author']
                                            .toString(),
                                        penjelasan: documents[index]
                                                ['penjelasan']
                                            .toString(),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Image.asset(
                                      'assets/images/not found.png',
                                      width: 180,
                                    ),
                                  );
                          }
                        },
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
              //DRAFT TAB
              (user != null)
                  ? Padding(
                      padding: EdgeInsets.all(15),
                      child: FutureBuilder(
                        future: getMyDraftKnowledge(user['email']),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<Map<String, dynamic>> documents =
                                snapshot.data as List<Map<String, dynamic>>;
                            // Process your documents here
                            return (documents.length > 0)
                                ? ListView.builder(
                                    itemCount: documents.length,
                                    itemBuilder: (context, index) {
                                      // Build your UI based on the retrieved data
                                      return CustomCard(
                                        document_id: documents[index]
                                                ['document id']
                                            .toString(),
                                        title: documents[index]['title']
                                            .toString(),
                                        image_cover: documents[index]
                                                ['image cover']
                                            .toString(),
                                        image_cover_name: documents[index]
                                                ['image cover name']
                                            .toString(),
                                        type:
                                            documents[index]['type'].toString(),
                                        attachment_file: documents[index]
                                                ['attachment file']
                                            .toString(),
                                        attachment_file_name: documents[index]
                                                ['attachment file name']
                                            .toString(),
                                        author: documents[index]['nama author']
                                            .toString(),
                                        category: documents[index]['category']
                                            .toString(),
                                        email_author: documents[index]
                                                ['email author']
                                            .toString(),
                                        penjelasan: documents[index]
                                                ['penjelasan']
                                            .toString(),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Image.asset(
                                      'assets/images/not found.png',
                                      width: 180,
                                    ),
                                  );
                          }
                        },
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ],
    );
  }
}

// CUSTOM WIDGET

class CustomCard extends StatelessWidget {
  final String document_id;
  final String title;
  final String image_cover;
  final String image_cover_name;
  final String type;
  final String category;
  final String author;
  final String email_author;
  final String penjelasan;
  final String attachment_file;
  final String attachment_file_name;

  CustomCard(
      {required this.document_id,
      required this.title,
      required this.image_cover,
      required this.image_cover_name,
      required this.type,
      required this.category,
      required this.author,
      required this.email_author,
      required this.penjelasan,
      required this.attachment_file,
      required this.attachment_file_name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailKnowledge(
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
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: (image_cover == '')
                  ? Image.asset(
                      'assets/images/image background default.jpg',
                      fit: BoxFit.cover,
                      width: (MediaQuery.of(context).size.width - 30) * 0.35,
                      height: 100,
                    )
                  : Image.network(
                      image_cover,
                      fit: BoxFit.cover,
                      width: (MediaQuery.of(context).size.width - 30) * 0.35,
                      height: 100,
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
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width:
                        ((MediaQuery.of(context).size.width - 30) * 0.65) - 20,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width:
                        ((MediaQuery.of(context).size.width - 30) * 0.65) - 20,
                    child: Text(
                      type,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
