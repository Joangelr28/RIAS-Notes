import 'package:flutter/material.dart';
import 'package:notes_app/src/components/notes.dart';
import 'note_create_screen.dart';
import '../components/action_button.dart';
import '../assets/global_methods.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App de Notas',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: Container(
        child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: SliverGrid.count(
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                children: <Widget>[
                  Note(
                      noteTitle: 'Primera Nota con titulo largo',
                      noteContent:
                          'Contenido de la Primera nota jgnonsoians odinaso iasaslasdasdas das dklas dlaksmd aslkmd asldkm asdlkm'),
                  Note(
                    noteTitle: 'Segunda Nota',
                    noteContent: 'Contenido de la Segunda nota',
                  ),
                  Note(
                    noteTitle: 'Tercera Nota',
                    noteContent: 'Contenido de la Tercera nota',
                  ),
                  Note(
                    noteTitle: 'Cuarta Nota',
                    noteContent: 'Contenido de la Cuarta nota',
                  ),
                  Note(
                    noteTitle: 'Primera Nota',
                    noteContent: 'Contenido de la Primera nota',
                  ),
                  Note(
                    noteTitle: 'Segunda Nota',
                    noteContent: 'Contenido de la Segunda nota',
                  ),
                  Note(
                    noteTitle: 'Tercera Nota',
                    noteContent: 'Contenido de la Tercera nota',
                  ),
                  Note(
                    noteTitle: 'Cuarta Nota',
                    noteContent: 'Contenido de la Cuarta nota',
                  ),
                  Note(
                    noteTitle: 'Primera Nota',
                    noteContent: 'Contenido de la Primera nota',
                  ),
                  Note(
                    noteTitle: 'Segunda Nota',
                    noteContent: 'Contenido de la Segunda nota',
                  ),
                  Note(
                    noteTitle: 'Tercera Nota',
                    noteContent: 'Contenido de la Tercera nota',
                  ),
                  Note(
                    noteTitle: 'Cuarta Nota',
                    noteContent: 'Contenido de la Cuarta nota',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ActionButton(
        iconData: Icons.add,
        onPressed: () => pushScreen(context, NoteCreateScreen()),
      ),
    );
  }
}
