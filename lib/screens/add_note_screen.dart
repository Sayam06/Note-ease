import 'package:flutter/material.dart';
import 'package:notes/database/notes_database.dart';
import 'package:notes/models/note.dart';

class AddNote extends StatefulWidget {
  static const routeName = "/add-note-screen";

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  void refresh() {
    setState(() {
    });
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
    var c = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("Add A Note", style: TextStyle(fontFamily: "Montserrat", color: Colors.black),),
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
                  onChanged: (_) => refresh(),
                  style: TextStyle(fontFamily: "Montserrat", fontSize: 0.0494 * c, fontWeight: FontWeight.bold),
                  controller: titleController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Title", hintStyle: TextStyle(fontFamily: "Montserrat", fontSize: 0.0494 * c),),
                ),
              ),
              Container(
                height: 1.5 * c,
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
                    onChanged: (_) => refresh(),
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
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:  FloatingActionButtonLocation.endFloat,
      floatingActionButton: titleController.text.length != 0 && descriptionController.text.length != 0 ? FloatingActionButton(
        backgroundColor: Color.fromRGBO(232, 228, 30, 1),
        foregroundColor: Colors.black,
        elevation: 0,
        child: Icon(Icons.done),
        onPressed: (){
          addNote(titleController.text, descriptionController.text);
          Navigator.of(context).pop();
        },
      ) : SizedBox(),
    );
  }
}


   