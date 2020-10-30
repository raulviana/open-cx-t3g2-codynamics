import 'package:flutter/material.dart';

import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String b = "NANI?!";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(primaryColor: Colors.red),
      home: SetUpPage(),
    );
  }
}


class SetUpPage extends StatefulWidget {
  @override
  _SetUpPageState createState() => _SetUpPageState();
}

class _SetUpPageState extends State<SetUpPage> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  var _counter = 0;
  final _biggerFont = TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('                           Lobby'),
          actions: [
            IconButton(icon: Icon(Icons.settings), onPressed: _pushSaved),
          ],
        ),
        body: new Container(
            padding: new EdgeInsets.all(32.0),
            child: new Center(
              child: new Column(

                children:  <Widget>[
                  Image(image: AssetImage("images/speed_meeting.jpeg"),),
                  Padding( padding: EdgeInsets.only(top: 50),
                      child: new ElevatedButton(onPressed: _pushSaved,
                          child: Text("Create an Event",textAlign: TextAlign.center,),
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.red),
                            foregroundColor:  MaterialStateProperty.resolveWith((states) => Colors.black),))),
                  new ElevatedButton(onPressed: _pushSaved,
                    child: Text("Participate in an Event",textAlign: TextAlign.center,textDirection: TextDirection.ltr,),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.red),
                      foregroundColor:  MaterialStateProperty.resolveWith((states) => Colors.black),),),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children : <Widget>[new ElevatedButton(onPressed: _pushSaved,
                    child: Text("Edit Profile",textAlign: TextAlign.center,),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.red),
                        foregroundColor:  MaterialStateProperty.resolveWith((states) => Colors.black)),),
                    new ElevatedButton(onPressed: _pushSaved,
                      child: Text("Edit Event",textAlign: TextAlign.center,),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.red),
                          foregroundColor:  MaterialStateProperty.resolveWith((states) => Colors.black)),)])
                ],
              ),

            )));
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            for(WordPair wp in generateWordPairs().take(10)) {
              if (!_suggestions.contains(wp))
                _suggestions.add(wp);
            }
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final already_saved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(   // NEW from here...
        already_saved ? Icons.favorite : Icons.favorite_border,
        color: already_saved ? Colors.red : null,
      ),
      onTap: () {      // NEW lines from here...
        setState(() {
          if (already_saved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved(){
    _counter++;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Redirect'),
            ),
            body: _buildSuggestions()
          );
        }, // ...to here.
      ),
    );
  }

}



















