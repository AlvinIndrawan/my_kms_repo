import 'package:flutter/material.dart';

class DetailKnowledge extends StatelessWidget {
  String textdummy =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tortor id aliquet lectus proin nibh nisl condimentum id. Iaculis nunc sed augue lacus viverra vitae congue eu. Augue ut lectus arcu bibendum. Erat pellentesque adipiscing commodo elit at imperdiet dui accumsan sit. Nibh sit amet commodo nulla facilisi nullam vehicula ipsum. Sed nisi lacus sed viverra tellus in hac. Ipsum suspendisse ultrices gravida dictum. Et netus et malesuada fames ac turpis egestas integer eget. \n\n A diam sollicitudin tempor id eu. Sagittis nisl rhoncus mattis rhoncus urna neque viverra justo. Vitae ultricies leo integer malesuada nunc vel risus commodo. Feugiat nibh sed pulvinar proin. Nunc vel risus commodo viverra. Platea dictumst quisque sagittis purus sit amet volutpat. Tortor vitae purus faucibus ornare suspendisse sed nisi. Adipiscing elit ut aliquam purus sit amet luctus venenatis lectus. Venenatis lectus magna fringilla urna porttitor rhoncus dolor purus. Ipsum nunc aliquet bibendum enim. Vel risus commodo viverra maecenas. Elit ullamcorper dignissim cras tincidunt. Aliquam sem et tortor consequat id porta nibh venenatis. Nulla malesuada pellentesque elit eget gravida cum sociis natoque penatibus. Leo a diam sollicitudin tempor. Nullam ac tortor vitae purus faucibus ornare suspendisse sed. Pulvinar neque laoreet suspendisse interdum consectetur libero id faucibus.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KMS',
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
            'Belajar Framework Bootstrap Untuk Pemrograman Web',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Image.asset(
            'assets/images/contoh card.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                'Mata Kuliah : ',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                'Pemrograman Web',
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
                'Alvin Indrawan',
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
            textdummy,
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Attachment File',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Container(
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
                  'Nama File.pdf',
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
          SizedBox(
            height: 30,
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
