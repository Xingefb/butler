// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'information_plugin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InformationPlugin _$InformationPluginFromJson(Map<String, dynamic> json) {
  return InformationPlugin(
    json['status'] as int,
    json['msg'] as String,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
    json['ok'] as bool,
  );
}

Map<String, dynamic> _$InformationPluginToJson(InformationPlugin instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'data': instance.data,
      'ok': instance.ok,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    (json['records'] as List)
        ?.map((e) =>
            e == null ? null : Records.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['total'] as int,
    json['size'] as int,
    json['current'] as int,
    json['orders'] as List,
    json['optimizeCountSql'] as bool,
    json['hitCount'] as bool,
    json['searchCount'] as bool,
    json['pages'] as int,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'records': instance.records,
      'total': instance.total,
      'size': instance.size,
      'current': instance.current,
      'orders': instance.orders,
      'optimizeCountSql': instance.optimizeCountSql,
      'hitCount': instance.hitCount,
      'searchCount': instance.searchCount,
      'pages': instance.pages,
    };

Records _$RecordsFromJson(Map<String, dynamic> json) {
  return Records(
    json['articleId'] as int,
    json['articleTitle'] as String,
    json['titleUrl'] as String,
    json['imgUrl'] as String,
    json['summary'] as String,
    json['createTime'] as String,
    json['content'] as String,
    json['author'] as String,
  );
}

Map<String, dynamic> _$RecordsToJson(Records instance) => <String, dynamic>{
      'articleId': instance.articleId,
      'articleTitle': instance.articleTitle,
      'titleUrl': instance.titleUrl,
      'imgUrl': instance.imgUrl,
      'summary': instance.summary,
      'createTime': instance.createTime,
      'content': instance.content,
      'author': instance.author,
    };
