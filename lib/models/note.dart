final String tableNotes = "notes";

class NoteFields {
  static final List<String> values = [id, isImportant, number, title, description, createdTime];
  static final String id = "_id";
  static final String isImportant = "isImportant";
  static final String number = "number";
  static final String title = "title";
  static final String description = "description";
  static final String createdTime = "time";
}

class Note {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;

  const Note ({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Map<String, Object?> toJson() => {
    NoteFields.id : id,
    NoteFields.title : title,
    NoteFields.number : number,
    NoteFields.isImportant : isImportant ? 1 : 0,
    NoteFields.description : description,
    NoteFields.createdTime : createdTime.toIso8601String(),
  };

  Note copy ({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) => Note (
    id : id ?? this.id,
    isImportant: isImportant ?? this.isImportant,
    number: number ?? this.number,
    title: title ?? this.title,
    description: description ?? this.description,
    createdTime: createdTime ?? this.createdTime,
  );

  static Note fromJson (Map<String, Object?> json) => Note(
    id: json[NoteFields.id] as int?,
    number: json[NoteFields.number] as int,
    title: json[NoteFields.title] as String,
    description: json[NoteFields.description] as String,
    createdTime: DateTime.parse(json[NoteFields.createdTime] as String),
    isImportant: json[NoteFields.isImportant] == 1,
  );
}