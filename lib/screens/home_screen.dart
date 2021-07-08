import 'package:flutter/material.dart';
import 'package:notes/database/notes_database.dart';
import 'package:notes/models/intro_description.dart';
import 'package:notes/models/note.dart';
import 'package:notes/screens/add_note_screen.dart';
import 'package:notes/screens/main_drawer.dart';
import 'package:notes/widgets/note-thumbnail.dart';

class HomeScreen extends StatefulWidget {
 static const routeName = "/home";

  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int counter = 0;

  late List<Note> notes;
  bool isLoading = true;

  Future addNote(String title, String description) async {
    final note = Note(
      title: title,
      isImportant: true,
      number: 0,
      description: description,
      createdTime: DateTime.now(),
    );

    await NotesDatabase.instance.create(note);
  }

  Future refreshNotes() async {
    setState(() {
      isLoading = true;
    });
    this.notes = await NotesDatabase.instance.readAllNotes();
    if(this.notes.isEmpty && counter == 1) {
      addNote("A Note, Only For You ❤️", DESCRIPTION);
      this.notes = await NotesDatabase.instance.readAllNotes();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Widget build(BuildContext context) {
    counter++;

    var c = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("My Notes", style: TextStyle(fontFamily: "Montserrat", color: Colors.black),),
        elevation: 0,
      ),
      drawer: MainDrawer(),
      body: isLoading ? Center(child: CircularProgressIndicator())
      : notes.isEmpty ? Center(child: Text("NO NOTES")) : Container(
        margin: EdgeInsets.only(left: 0.039 * c, right: 0.039 * c,),
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext ctx, index) {
            return NoteThumbnail(notes[index], index, refreshNotes);
          },
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 0.5 * c,
            childAspectRatio: 2.5 / 2.3,
            crossAxisSpacing: 0.05 * c,
            mainAxisSpacing: 0
          ),
          itemCount: notes.length,
        ),
      ),
      floatingActionButtonLocation:  FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(232, 228, 30, 1),
        foregroundColor: Colors.black,
        elevation: 0,
        child: Icon(Icons.add, size: 0.104 * c),
        onPressed: () => {Navigator.of(context).pushNamed(AddNote.routeName).then((value) => refreshNotes())},
      ),
    );
  }
}