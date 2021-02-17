import 'package:flutter/material.dart';
import 'package:nalandha/pages/screens/note_screen.dart';
import 'package:nalandha/pages/screens/notes_screen.dart';


class Notepad extends StatelessWidget {
  bool indexTab;
  Notepad({this.indexTab});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: NotesScreen.routeName,
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          NotesScreen.routeName: (context) => NotesScreen(indexTab:indexTab),
          NoteScreen.routeName: (context) => NoteScreen(settings.arguments)
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
    );
  }
}
