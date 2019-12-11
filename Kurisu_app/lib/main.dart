import 'package:flutter/material.dart';
import 'func.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assistant Getter',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Press Button To Summon Assistant'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tinacount = 0;
  String kurl = 'https://i.imgur.com/E8X13s8.png';
  String text = "Press Button To Summon Assistant";
  Future<void> _searchtinas() 
  async {
    tinacount++;
    kurl = await getAssistant();
    if(tinacount > 1)
      {text = 'You have pushed the button $tinacount times.';}
    else if (tinacount == 1)
      {text ='You have pushed the button $tinacount time.';}
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(text),
            Image.network(kurl),
           
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          _searchtinas();

        },
        tooltip: 'Assistant Summoner',
        child: Icon(Icons.alternate_email),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
