import 'package:flutter/material.dart';

class Myknowledge extends StatefulWidget {
  @override
  _MyknowledgeState createState() => _MyknowledgeState();
}

class _MyknowledgeState extends State<Myknowledge>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
              ListView(
                padding: EdgeInsets.all(15),
                children: [
                  CustomCard(),
                  CustomCard(),
                  CustomCard(),
                ],
              ),
              //DRAFT TAB
              ListView(
                padding: EdgeInsets.all(15),
                children: [
                  CustomCard(),
                  CustomCard(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// CUSTOM WIDGET

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Image.asset(
              'assets/images/contoh card.png',
              fit: BoxFit.cover,
              width: (MediaQuery.of(context).size.width - 30) * 0.35,
              height: 100,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: ((MediaQuery.of(context).size.width - 30) * 0.65) - 20,
                  child: Text(
                    'Belajar Framework Bootstrap Untuk Pemrograman Web',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: ((MediaQuery.of(context).size.width - 30) * 0.65) - 20,
                  child: Text(
                    'Pemrograman Berorientasi Objek',
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
    );
  }
}
