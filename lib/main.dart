import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
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

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class CeremonyListState extends State<CeremonyList> {
  final _ceremonies = ["Ice Breakers", "Retrospectives", "Backlog Grooming", "Sprint Planning", "Stand-ups", "Sprint Review", "Showcase"];
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
        icon: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border),
        color: alreadySaved ? Colors.red : null,
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