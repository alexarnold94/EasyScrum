import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'CeremonyTemplate.dart';

class CeremonyListState extends State<CeremonyList> {
  final _ceremonies = ["blank", "what", "is", "Love", "Baby", "Don't", "hurt", "me"];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = Set<String>();
  String ceremonyKey;

  CeremonyListState(String ceremonyKey){
    this.ceremonyKey = ceremonyKey;
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ceremonyKey),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list)),
        ],
      ),
      body: _buildList(),
    );
  }

  void _navigateToCeremonyTemplate(ceremony) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CeremonyTemplate(ceremony)),

    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {

        return _buildRow(_ceremonies[i]);
      },
      itemCount: (_ceremonies.length),
    );

  }

  Widget _buildRow(String ceremony) {
    final bool alreadySaved = _saved.contains(ceremony);

    return ListTile(
        title: Text(
          ceremony,
          style: _biggerFont,
        ),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: () {
            setState(() {
              if (alreadySaved) {
                _saved.remove(ceremony);
              } else {
                _saved.add(ceremony);
              }
            });
          },
        ),
        onTap: () {
          _navigateToCeremonyTemplate(ceremony);
        }
    );
  }
}

class CeremonyList extends StatefulWidget {

  String ceremonyKey;

  CeremonyList(String ceremonyKey){
    this.ceremonyKey = ceremonyKey;
  }

  @override
  CeremonyListState createState() => CeremonyListState(ceremonyKey);
}