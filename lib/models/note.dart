import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String content;

  const Note({required this.title, required this.content});
}
