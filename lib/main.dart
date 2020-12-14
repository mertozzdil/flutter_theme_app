import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      initialData: false,
      stream: bloc.darkThemeEnabled,
      builder: (context, snapshot) => new MaterialApp(
          theme: snapshot.data?ThemeData.dark():ThemeData.light(),    
          home: HomePage(snapshot.data)
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  bool darkThemeEnabled;
  HomePage(this.darkThemeEnabled);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Dynamic Theme"),
        ),
        body: new Center(
          child: new Text("Hello motherfucker"),
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new ListTile(
                  title: new Text("Dark Theme"),
                  trailing: new Switch(
                      value: darkThemeEnabled,
                      onChanged: bloc.changeTheme
                  ))
            ],
          ),
        ),
      );
  }
}

class Bloc{
  final _themeController = StreamController<bool>();
  get changeTheme => _themeController.sink.add;
  get darkThemeEnabled => _themeController.stream;
}

final bloc = Bloc();
