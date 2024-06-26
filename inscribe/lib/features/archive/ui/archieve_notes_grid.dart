import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:inscribe/core/consts.dart';
import 'package:inscribe/core/data/model/note/note.dart';
import 'package:inscribe/core/extensions/context_extensions.dart';
import 'package:inscribe/core/i18n/strings.g.dart';
import 'package:inscribe/core/injection_container.dart';
import 'package:inscribe/core/presentation/widgets/faded_edges_container.dart';
import 'package:inscribe/features/archive/cubit/archive_cubit.dart';
import 'package:inscribe/features/archive/ui/delete_note_forever_dialog.dart';
import 'package:inscribe/features/home/ui/note_card.dart';

class ArchieveNotesGrid extends StatefulWidget {
  const ArchieveNotesGrid({super.key});

  @override
  State<ArchieveNotesGrid> createState() => _ArchieveNotesGridState();
}

class _ArchieveNotesGridState extends State<ArchieveNotesGrid> {
  final _cubit = IC.getIt<ArchiveCubit>();

  var _tapPosition;

  double _getScrollViewHeight(BuildContext context) {
    return (MediaQuery.of(context).size.height) - appBarPreferedSize;
  }

  void _restoreNote(Note note) {
    _cubit.restoreNote(note);
    context.showSnackbar(
        snackbarText: Translations.of(context).archivedNotes.note_restored);
  }

  void _deleteNoteForever(Note note) async {
    final shouldDelete = await showDialog(
        context: context,
        builder: (context) => DeleteNoteForeversDialog()) as bool?;

    if (shouldDelete ?? false) {
      _cubit.deleteNote(note);
      context.showSnackbar(
          snackbarText: Translations.of(context).archivedNotes.note_deleted);
    }
  }

  void _getTapPosition(TapDownDetails tapPosition) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(tapPosition.globalPosition);
      print(_tapPosition);
    });
  }

  void _showContextMenu(Note note) async {
    final RenderBox? overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox?;

    if (overlay != null) {
      await showMenu(
        context: context,
        position: RelativeRect.fromRect(
          Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 100, 100),
          Rect.fromLTWH(0, 0, overlay.paintBounds.size.width,
              overlay.paintBounds.size.height),
        ),
        items: <PopupMenuItem>[
          PopupMenuItem(
            child: Text(Translations.of(context).archivedNotes.restore),
            onTap: () => _restoreNote(note),
          ),
          PopupMenuItem(
            child: Text(Translations.of(context).archivedNotes.delete_forever),
            onTap: () => _deleteNoteForever(note),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArchiveCubit, ArchiveState>(
      bloc: _cubit,
      builder: (context, state) {
        return Container(
          height: _getScrollViewHeight(context),
          child: FadedEdgesContainer(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: gradientHeight,
                  ),
                ),
                getGridForNotes(state.notes, state.isGridView)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getGridForNotes(List<Note> notes, bool isGridView) {
    return SliverMasonryGrid.count(
      crossAxisCount: (isGridView) ? 2 : 1,
      crossAxisSpacing: 15,
      mainAxisSpacing: 10,
      childCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return GestureDetector(
          onTapDown: (position) {
            _getTapPosition(position);
          },
          onLongPress: () {
            Vibrate.feedback(FeedbackType.medium);
            _showContextMenu(note);
          },
          child: NoteCard(
            note: note,
          ),
        );
      },
    );
  }
}
