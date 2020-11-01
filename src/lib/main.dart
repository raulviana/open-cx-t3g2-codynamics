import 'package:flutter/material.dart';

import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Speed Dating',
      theme: ThemeData(primaryColor: Colors.red),
      home: SetUpPage(),
      routes: <String, WidgetBuilder> {
        '/CreateEvent' : (context) => CreateEvent()
      },
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
  final _biggerFont = TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Center(child: new Text("HOME PAGE", textAlign: TextAlign.center)),
        ),
        body: new Container(
            padding: new EdgeInsets.all(32.0),
            child: new Center(
              child: new ListView(
                children:  <Widget>[
                  Image(image: AssetImage("images/speed_meeting.jpeg"),),
                  Padding( padding: EdgeInsets.only(top: 50),
                      child: new ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/CreateEvent');
                          },
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
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(   // NEW from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {      // NEW lines from here...
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved(){
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

class CreateEvent extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('CREATE EVENT'),),
      );
  }
}



















