import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'CeremonyList.dart';

class HomePageState extends State<HomePage> {
  final databaseReference = Firestore.instance;
  var _ceremoniesMap;
  var _ceremonies = ['sad'];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = Set<String>();

  @override
  void initState() {
    super.initState();
    getCeremonies().then((data) {
      setState(() {
        var ceremoniesMap = new Map();
        var keys = data.keys.toList().cast<String>();
        var values = data.values.toList().cast<String>();
        var count = 0;
        values.forEach((f) => {
          ceremoniesMap[f] = keys[count], count++
        });
        this._ceremoniesMap = ceremoniesMap;
        this._ceremonies = values;
        });
      });
    }

  @override
  Widget build(BuildContext buildContext) {

    if (_ceremoniesMap == null){
      getCeremonies();
      return Scaffold();
    }
    else {
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
  }

  void _navigateToCeremonyList(ceremonyKey, ceremony) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CeremonyList(ceremonyKey, ceremony)),

    );
  }

  Future<Map> getCeremonies() async {
    var retVal = new Map();

    await databaseReference
        .collection("ceremonies")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => {
        retVal[f.data['key']] = f.data['name']
      });
    });
    return retVal;
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
              //getData();
              if (alreadySaved) {
                _saved.remove(ceremony);
              } else {
                _saved.add(ceremony);
              }
            });
          },
        ),

        onTap: () {
          _navigateToCeremonyList(_ceremoniesMap[ceremony], ceremony);
        }
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}