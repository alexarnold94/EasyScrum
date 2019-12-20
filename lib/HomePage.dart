import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'CeremonyList.dart';

class HomePageState extends State<HomePage> {
  final databaseReference = Firestore.instance;
  final _ceremonies = ["Ice Breakers", "Retrospectives", "Backlog Grooming", "Sprint Planning", "Stand-ups", "Sprint Review", "Showcase"];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = Set<String>();

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EasyScrum'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _navigateToCeremonyList(ceremony) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CeremonyList(ceremony)),

    );
  }

  void getData() {
    databaseReference
        .collection("ceremonies")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  void _pushSaved() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (BuildContext context) {
              final Iterable<ListTile> tiles = _saved.map(
                      (String ceremony) {
                    return ListTile(
                        title: Text(
                          ceremony,
                          style: _biggerFont,
                        )
                    );
                  }
              );
              final List<Widget> divided = ListTile
                  .divideTiles(
                context: context,
                tiles: tiles,
              ).toList();
              return Scaffold(
                appBar: AppBar(
                  title: Text('Saved Suggestions'),
                ),
                body: ListView(children: divided),
              );
            }
        )
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {

        return _buildRow(_ceremonies[i]);
      },
      itemCount: (_ceremonies.length),
    );

  }

  void _favourite(alreadySaved, ceremony) {
    setState(() {
      if (alreadySaved) {
        _saved.remove(ceremony);
      } else {
        _saved.add(ceremony);
      }
    });
  }

  Widget _buildRow(String ceremony) {
    final bool alreadySaved = _saved.contains(ceremony);

    return ListTile(
        title: Text(
          ceremony,
          style: _biggerFont,
        ),
        trailing: IconButton(
          icon: Icon(alreadySaved ? Icons.arrow_forward : Icons.arrow_forward_ios),
          color: alreadySaved ? Colors.red : null,
          onPressed: () {
            setState(() {
              getData();
              if (alreadySaved) {
                _saved.remove(ceremony);
              } else {
                _saved.add(ceremony);
              }
            });
          },
        ),

        onTap: () {
          _navigateToCeremonyList(ceremony);
        }
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}