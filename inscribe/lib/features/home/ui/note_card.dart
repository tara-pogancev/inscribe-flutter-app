import 'package:flutter/material.dart';
import 'package:inscribe/core/consts.dart';
import 'package:inscribe/core/data/model/note/note.dart';
import 'package:inscribe/core/data/model/note_type.dart';
import 'package:inscribe/core/presentation/app_color_scheme.dart';
import 'package:inscribe/core/presentation/app_text_styles.dart';
import 'package:inscribe/features/home/ui/card_profile_image.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    Key? key,
    required this.note,
    this.onClick,
  }) : super(key: key);

  final Note note;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    final textColor = (note.isPinned)
        ? lightAppColorScheme.white
        : AppColorScheme.of(context).black;

    final boxDecoration = (note.isPinned && !note.isDeleted)
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            image: const DecorationImage(
                image: AssetImage("assets/images/wave_profile_cover.png"),
                fit: BoxFit.cover),
          )
        : BoxDecoration(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            border: Border.all(
              color: AppColorScheme.of(context).black,
              width: 3,
            ),
          );

    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: cardProfileImageSize / 2),
            child: InkWell(
              onTap: (onClick != null)
                  ? () {
                      onClick!();
                    }
                  : null,
              child: Container(
                width: double.infinity,
                decoration: boxDecoration,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 15,
                      top: ((cardProfileImageSize / 2) + 10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          note.name,
                          style: AppTextStyles.of(context)
                              .cardTitle
                              .copyWith(color: textColor),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        note.type?.getString(context) ?? "-",
                        style: AppTextStyles.of(context)
                            .cardSubtitle
                            .copyWith(color: textColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: CardProfileImage(imageName: note.assetImage),
          ),
        ),
      ],
    );
  }
}
