import 'package:inscribe/core/data/model/note/note.dart';
import 'package:inscribe/core/domain/model/usecase.dart';

class UpdateNoteUseCase extends UseCase {
  Future<void> call(Note note) async {
    final noteToSave = note.copyWith(updatedAt: DateTime.now());
    return notesRepository.updateNote(noteToSave);
  }
}
