import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/screens/view_note_screen.dart';

class NoteThumbnail extends StatelessWidget {
  final Note note;
  final int index;
  final Function refresh;
   List<Color> colors = [Color.fromRGBO(148, 208, 204, 1), Color.fromRGBO(234, 226, 182, 1), Color.fromRGBO(229, 178, 153, 1), Color.fromRGBO(178, 171, 140, 1), Color.fromRGBO(167, 196, 188, 1), Color.fromRGBO(213, 219, 179, 1), Color.fromRGBO(182, 201, 240, 1), Color.fromRGBO(244, 169, 168, 1)];

  NoteThumbnail(
    this.note,
    this.index,
    this.refresh,
  );

  @override
  Widget build(BuildContext context) {

    var c = MediaQuery.of(context).size.width;

    return GestureDetector(
          child: Container(
            margin: EdgeInsets.only(top: 0.026 * c, bottom: 0.026 * c),
        padding: EdgeInsets.symmetric(vertical: 0.052 * c, horizontal: 0.052 * c),
        height: 0.27 * c,
        decoration: BoxDecoration(
          color: colors[index % 8],
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Center(
          child: Text(note.title, style: TextStyle(
            fontFamily: "Montserrat", fontSize: 0.052 * c, fontWeight: FontWeight.bold), textAlign: TextAlign.center,
            ),
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed(ViewNote.routeName, arguments: {
        "note": note,
      }).then((value) => refresh()),
    );
  }
}