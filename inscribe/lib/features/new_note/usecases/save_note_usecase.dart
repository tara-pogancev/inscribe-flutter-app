import 'package:inscribe/core/data/model/note/note.dart';
import 'package:inscribe/core/domain/model/usecase.dart';

class SaveNoteUseCase extends UseCase {
  Future<void> call(Note note) async {
    final createdAt =
        (note.createdAt == null) ? DateTime.now() : note.createdAt;
    final noteToSave = note.copyWith(
        id: uuid.v1(), updatedAt: DateTime.now(), createdAt: createdAt);
    return notesRepository.addNote(noteToSave);
  }
}
