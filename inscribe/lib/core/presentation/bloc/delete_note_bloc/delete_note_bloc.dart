import 'package:bloc/bloc.dart';
import 'package:inscribe/core/data/model/note/note.dart';
import 'package:inscribe/core/injection_container.dart';
import 'package:inscribe/features/home/bloc/home_bloc.dart';
import 'package:inscribe/features/new_note/usecases/archive_note_usecase.dart';
import 'package:inscribe/features/new_note/usecases/undo_archive_note_usecase.dart';
import 'package:meta/meta.dart';

part 'delete_note_event.dart';
part 'delete_note_state.dart';

class DeleteNoteBloc extends Bloc<DeleteNoteEvent, DeleteNoteState> {
  final archiveNoteUseCase = ArchiveNoteUseCase();
  final undoArchiveNoteUseCase = UndoArchiveNoteUseCase();
  final homeBloc = IC.getIt<HomeBloc>();

  DeleteNoteBloc() : super(DeleteNoteState()) {
    on<ArchiveNote>((event, emit) {
      archiveNoteUseCase(event.note);
      emit(state.copyWith(lastDeletedNote: event.note));
      homeBloc.add(HomeFetchEvent());
    });

    on<UndoArchive>((event, emit) {
      if (state.lastDeletedNote != null) {
        undoArchiveNoteUseCase(state.lastDeletedNote!);
        emit(state.copyWith(lastDeletedNote: null));
        homeBloc.add(HomeFetchEvent());
      }
    });
  }
}
