import 'package:flutter/material.dart';
import 'package:notes/database/notes_database.dart';
import 'package:notes/models/note.dart';
import 'package:notes/screens/home_screen.dart';


class ViewNote extends StatefulWidget {

 static const routeName = "/view-note";


  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  int counter = 0;

  late Note note;

  var titleController = TextEditingController();

  var descriptionController = TextEditingController(text: "hello");
 
  bool edit = false;
  int visibility = 1;

  Future deleteNote(Note note) async {
    await NotesDatabase.instance.delete(note.id!);
  }

  Future updateNote(String title, String description, Note note) async {
    final newNote = note.copy(
      title: title,
       isImportant: true,
       number: 00,
      description: description,
      createdTime: DateTime.now(),
    );

    await NotesDatabase.instance.update(newNote);
  }

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

  @override
  Widget build(BuildContext context) {
    counter++;

    var c = MediaQuery.of(context).size.width;

    final route = ModalRoute.of(context);

    if(route == null)
      return SizedBox(height: 1);
    else {
      final routeArgs = route.settings.arguments as Map<String, Note>;
      if(counter == 1){
      titleController.text = routeArgs["note"]!.title;
      descriptionController.text = routeArgs["note"]!.description;
      } 

      titleController.selection = TextSelection.fromPosition(TextPosition(offset: titleController.text.length));
      descriptionController.selection = TextSelection.fromPosition(TextPosition(offset: descriptionController.text.length));

      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text("View Note", style: TextStyle(fontFamily: "Montserrat", color: Colors.black),),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.only(
              top: 0.07 * c,
              left: 0.070 * c,
              right: 0.070 * c,
              bottom: 0.081 * c),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 0.027 * c, right: 0.027 * c),
                  margin: EdgeInsets.only(bottom: 0.054 * c),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(0.0405 * c)),
                      border: Border.all(
                          color: Color.fromRGBO(255, 170, 167, 1),
                          width: 0.0108 * c)),
                  child: TextField(
                    enabled: edit,
                    //onChanged: (_) => refresh(),
                    style: TextStyle(fontFamily: "Montserrat", fontSize: 0.0494 * c, fontWeight: FontWeight.bold),
                    controller: titleController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Title", hintStyle: TextStyle(fontFamily: "Montserrat", fontSize: 0.0494 * c),),
                  ),
                ),
                Container(
                  height: 1.2 * c,
                  padding: EdgeInsets.only(left: 0.027 * c, right: 0.027 * c),
                  margin: EdgeInsets.only(bottom: 0.054 * c),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(0.0405 * c)),
                      border: Border.all(
                          color: Color.fromRGBO(255, 171, 115, 1),
                          width: 0.0108 * c)),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: TextField(
                      enabled: edit,
                      //onChanged: (_) => refresh(),
                      style: TextStyle(fontFamily: "Montserrat", fontSize: 0.0494 * c),
                      controller: descriptionController,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintMaxLines: 2,
                          hintText: "The note comes here!",
                          hintStyle: TextStyle(fontFamily: "Montserrat", fontSize: 0.0494 * c),
                          contentPadding: EdgeInsets.only(top: 0.0405 * c)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.13 * c,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 0.208 * c,
                      height: 0.208 * c,
                      child: visibility == 1 ? new RawMaterialButton(
                        fillColor: Color.fromRGBO(255, 146, 146, 1),
                        shape: new CircleBorder(),
                        elevation: 0.0,
                        child: Icon(
                          Icons.delete,
                          size: 0.104 * c,
                        ),
                      onPressed: (){
                        deleteNote(routeArgs["note"]!);
                        Navigator.of(context).pop();
                        //Navigator.of(context).pop();
                      },
                      ) : SizedBox(height: 1,)),
                      Container(
                      width: 0.208 * c,
                      height: 0.208 * c,
                      child: new RawMaterialButton(
                        fillColor: Color.fromRGBO(232, 228, 110, 1),
                        shape: new CircleBorder(),
                        elevation: 0.0,
                        child: visibility == 1 ? Icon(
                          Icons.edit,
                          size: 0.104 * c,
                        ) : Icon(Icons.done, size: 40,),
                      onPressed: (){
                        if(visibility == 1){
                          setState(() {
                          edit = true;
                          visibility = 0;
                        });
                        } else {
                          setState(() {
                            edit = false;
                            visibility = 1;
                            print(descriptionController.text);
                            updateNote(titleController.text, descriptionController.text, routeArgs["note"]!);
                          });
                        }
                      },
                      )),
                  ]
                )
              ]
            ),
          ),
        ),
      );
    }
  }
}