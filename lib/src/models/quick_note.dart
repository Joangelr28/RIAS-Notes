import 'package:hive/hive.dart';

part 'quick_note.g.dart';

@HiveType(typeId: 1)
class QuickNote {
  @HiveField(0)
  List? content;

  QuickNote({
    this.content,
  });

  QuickNote.fromJson(Map<String, dynamic> json) : content = json['content'];

  Map<String, dynamic> toJson() => {
        'content': content,
      };
}
