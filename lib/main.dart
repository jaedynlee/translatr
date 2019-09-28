import 'package:flutter/material.dart';
import 'package:translatr/translationService.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'translatr',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'translatr'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked 'final'.

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textController = new TextEditingController();
  String _translation = 'Select an option from the dropdown menu and press Translate!';
  String _selectedDialect;

  void _translate() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      String defaultText = 'Select an option from the dropdown menu and press Translate!';
      String inputText = textController.text;
      if (inputText == '') {
        _translation = defaultText;
      } else {
        TranslationService.translate(_selectedDialect, inputText).then((t) {
          _translation = t;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15.0),
              child: Text('ENGLISH',
                style: new TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    border: InputBorder.none,
                    hintText: 'Enter text to translate...'
                ),
                maxLines: null,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                children: <Widget>[
                  DropdownButton<String>(
                    style: new TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    hint: Text('--- SELECT A DIALECT ---'),
                    value: _selectedDialect,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedDialect = newValue;
                      });
                    },
                    items: Dialects.asList().map((d) {
                      return DropdownMenuItem(
                        child: new Text(d.toUpperCase()),
                        value: d,
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: _translate,
                      color: Colors.teal,
                      textColor: Colors.white,
                      splashColor: Colors.tealAccent,
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      child: Text('Translate'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(30.0),
              child: Text(
                '$_translation',
                style: new TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
