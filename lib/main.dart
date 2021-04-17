import 'package:flutter/material.dart';
import 'package:sql_lite_crud/models/contact.dart';

const darkBlueColor = Color(0xff486579);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Crud',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: MyHomePage(title: 'SQLite Crud Operations'),
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
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Contact _contact = Contact();
  List<Contact> _contacts = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(
          child: Text(widget.title,
          style: TextStyle(color: darkBlueColor),),
          ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _form(), _list()          
          ],
        ),
      ),
    );
  }

  //Define functions to define the form and the listview widget
  _form() => Container(
    color: Colors.white, //Every sub-widget inside this container should have the background white
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    child: Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Full Name'),
            onSaved: (val) => setState(() => _contact.name = val),
            validator: (val) => (val.length == 0 ? 'This field is required': null),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Mobile'),
            onSaved: (val) => setState(() => _contact.mobile = val),
            validator: (val) => (val.length < 10 ? 'Atleast 10 characters required': null),
          ),
          
          Container(
            margin: EdgeInsets.all(10.0),
            // ignore: deprecated_member_use
            child: RaisedButton(
              onPressed: ()=> _onSubmit(),
              child: Text('Submit'),
              color: darkBlueColor,
              textColor: Colors.white,)
          )
        ],
      ),
    ),
  );

  _onSubmit(){
    var form = _formKey.currentState;
    if(form.validate()){
      form.save();
      setState(() {
        _contacts.add(Contact(id:null, name:_contact.name, mobile: _contact.mobile));
      });
      form.reset();
    }
  }

  _list() => Expanded(
    child: Card(
      margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index){
          return Column(
            children: <Widget>[
              ListTile(
                  leading: Icon(Icons.account_circle, color:darkBlueColor, size: 40.0),
                  title: Text(_contacts[index].name.toUpperCase(),
                  style: TextStyle(color: darkBlueColor, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(_contacts[index].mobile),
              ),
              Divider(
                height: 5.0,
              ),
            ]
          );
        },
        itemCount: _contacts.length,
        ),
      )
    
    );

}
