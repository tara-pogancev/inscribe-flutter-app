import 'package:flutter/material.dart';
import 'package:inscribe/core/data/model/note.dart';
import 'package:inscribe/core/extensions/field_validation_extensions.dart';
import 'package:inscribe/core/i18n/strings.g.dart';
import 'package:inscribe/core/injection_container.dart';
import 'package:inscribe/core/presentation/widgets/form_fields/app_date_form_field.dart';
import 'package:inscribe/core/presentation/widgets/form_fields/app_dropdown_form_field.dart';
import 'package:inscribe/core/presentation/widgets/form_fields/app_form_field.dart';
import 'package:inscribe/features/new_note/bloc/new_note_bloc.dart';

class NoteOverviewPage extends StatefulWidget {
  const NoteOverviewPage({super.key});

  @override
  State<NoteOverviewPage> createState() => _NoteOverviewPageState();
}

class _NoteOverviewPageState extends State<NoteOverviewPage> {
  final _bloc = IC.getIt<NewNoteBloc>();

  String? description;
  NoteType? noteType;
  DateTime? dateOfBirth;

  List<String> getCategoryNames() {
    return NoteType.values.map((e) => e.getString(context)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          AppDropdownFormField(
            label: Translations.of(context).newNoteScreen.category,
            items: getCategoryNames(),
            validator: (value) {
              return value.isRequired(context);
            },
            onSaved: (value) {
              if (value != null) {
                noteType = NoteType.values
                    .firstWhere((e) => e.getString(context) == value);
              }
            },
            icon: Icons.favorite_border_rounded,
          ),
          AppDateFormField(
            label: Translations.of(context).newNoteScreen.date_of_birth,
            validator: (value) {
              return null;
            },
            onSaved: (value) {},
          ),
          AppFormField(
            label: Translations.of(context).newNoteScreen.description,
            hint: Translations.of(context).newNoteScreen.description_hint,
            // icon: Icons.featured_play_list_outlined,
            minLines: 4,
            maxLines: 16,
            validator: (value) {
              return null;
            },
            onSaved: (value) {},
          )
        ],
      ),
    );
  }
}
