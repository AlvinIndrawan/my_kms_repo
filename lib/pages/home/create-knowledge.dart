import 'package:flutter/material.dart';

class CreateKnowledge extends StatefulWidget {
  @override
  _CreateKnowledgeState createState() => _CreateKnowledgeState();
}

class _CreateKnowledgeState extends State<CreateKnowledge> {
  // Add your state variables here

  @override
  Widget build(BuildContext context) {
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
      ],
    );
  }
}
