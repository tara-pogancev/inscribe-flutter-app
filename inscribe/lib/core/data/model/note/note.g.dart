// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoteImpl _$$NoteImplFromJson(Map<String, dynamic> json) => _$NoteImpl(
      id: json['id'] as String? ?? null,
      name: json['name'] as String? ?? "",
      assetImage: json['assetImage'] as String? ?? "",
      galleryImage: json['galleryImage'] == null
          ? null
          : Uri.parse(json['galleryImage'] as String),
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      type: $enumDecodeNullable(_$NoteTypeEnumMap, json['type']) ?? null,
      description: json['description'] as String? ?? null,
      giftIdeas: json['giftIdeas'] as String? ?? null,
      isDeleted: json['isDeleted'] as bool? ?? false,
      isPinned: json['isPinned'] as bool? ?? false,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$NoteImplToJson(_$NoteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'assetImage': instance.assetImage,
      'galleryImage': instance.galleryImage?.toString(),
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'type': _$NoteTypeEnumMap[instance.type],
      'description': instance.description,
      'giftIdeas': instance.giftIdeas,
      'isDeleted': instance.isDeleted,
      'isPinned': instance.isPinned,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$NoteTypeEnumMap = {
  NoteType.friend: 'friend',
  NoteType.school: 'school',
  NoteType.work: 'work',
  NoteType.romantic: 'romantic',
  NoteType.family: 'family',
};
