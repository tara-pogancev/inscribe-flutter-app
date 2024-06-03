import 'package:inscribe/core/data/model/note/note.dart';
import 'package:inscribe/core/domain/model/app_bloc.dart';
import 'package:inscribe/features/new_note/usecases/save_note_usecase.dart';

part 'new_note_event.dart';
part 'new_note_state.dart';

class NewNoteBloc extends AppBloc<NewNoteEvent, NewNoteState> {
  final saveNoteUseCase = SaveNoteUseCase();

  NewNoteBloc() : super(NewNoteState()) {
    on<SaveNoteEvent>((event, emit) async {
      print("Saving note: ${state.note}");
      await saveNoteUseCase(state.note);
      emit(state.copyWith(isSuccess: true));
      emit(NewNoteState());
    });

    on<UpdateNoteEvent>((event, emit) {
      emit(state.copyWith(note: event.note));
    });

    on<UpdateNoteNameEvent>((event, emit) {
      emit(state.copyWith(note: state.note.copyWith(name: event.noteName)));
    });

    on<UpdateNoteDescriptionEvent>((event, emit) {
      emit(state.copyWith(
          note: state.note.copyWith(description: event.noteDescription)));
    });

    on<UpdateNoteTypeEvent>((event, emit) {
      emit(state.copyWith(note: state.note.copyWith(type: event.noteType)));
    });

    on<UpdateDateOfBirthEvent>((event, emit) {
      emit(state.copyWith(
          note: state.note.copyWith(dateOfBirth: event.dateOfBirth)));
    });

    on<UpdateGiftIdeasEvent>((event, emit) {
      emit(state.copyWith(
          note: state.note.copyWith(giftIdeas: event.giftIdeas)));
    });
  }
}
