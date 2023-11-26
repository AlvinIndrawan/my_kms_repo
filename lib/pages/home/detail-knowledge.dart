import 'package:flutter/material.dart';

class DetailKnowledge extends StatelessWidget {
  String textdummy =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tortor id aliquet lectus proin nibh nisl condimentum id. Iaculis nunc sed augue lacus viverra vitae congue eu. Augue ut lectus arcu bibendum. Erat pellentesque adipiscing commodo elit at imperdiet dui accumsan sit. Nibh sit amet commodo nulla facilisi nullam vehicula ipsum. Sed nisi lacus sed viverra tellus in hac. Ipsum suspendisse ultrices gravida dictum. Et netus et malesuada fames ac turpis egestas integer eget. \n\n A diam sollicitudin tempor id eu. Sagittis nisl rhoncus mattis rhoncus urna neque viverra justo. Vitae ultricies leo integer malesuada nunc vel risus commodo. Feugiat nibh sed pulvinar proin. Nunc vel risus commodo viverra. Platea dictumst quisque sagittis purus sit amet volutpat. Tortor vitae purus faucibus ornare suspendisse sed nisi. Adipiscing elit ut aliquam purus sit amet luctus venenatis lectus. Venenatis lectus magna fringilla urna porttitor rhoncus dolor purus. Ipsum nunc aliquet bibendum enim. Vel risus commodo viverra maecenas. Elit ullamcorper dignissim cras tincidunt. Aliquam sem et tortor consequat id porta nibh venenatis. Nulla malesuada pellentesque elit eget gravida cum sociis natoque penatibus. Leo a diam sollicitudin tempor. Nullam ac tortor vitae purus faucibus ornare suspendisse sed. Pulvinar neque laoreet suspendisse interdum consectetur libero id faucibus.';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(15),
      children: [
        Text(
          'Belajar Framework Bootstrap Untuk Pemrograman Web',
          style: TextStyle(
            fontSize: 15,
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
      ],
    );
  }
}
