import 'package:json_annotation/json_annotation.dart'; 

part 'information_plugin.g.dart';


@JsonSerializable()
  class InformationPlugin extends Object {

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'data')
  Data data;

  @JsonKey(name: 'ok')
  bool ok;

  InformationPlugin(this.status,this.msg,this.data,this.ok,);

  factory InformationPlugin.fromJson(Map<String, dynamic> srcJson) => _$InformationPluginFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InformationPluginToJson(this);

}
  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'records')
  List<Records> records;

  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'size')
  int size;

  @JsonKey(name: 'current')
  int current;

  @JsonKey(name: 'orders')
  List<dynamic> orders;

  @JsonKey(name: 'optimizeCountSql')
  bool optimizeCountSql;

  @JsonKey(name: 'hitCount')
  bool hitCount;

  @JsonKey(name: 'searchCount')
  bool searchCount;

  @JsonKey(name: 'pages')
  int pages;

  Data(this.records,this.total,this.size,this.current,this.orders,this.optimizeCountSql,this.hitCount,this.searchCount,this.pages,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
@JsonSerializable()
  class Records extends Object {

  @JsonKey(name: 'articleId')
  int articleId;

  @JsonKey(name: 'articleTitle')
  String articleTitle;

  @JsonKey(name: 'titleUrl')
  String titleUrl;

  @JsonKey(name: 'imgUrl')
  String imgUrl;

  @JsonKey(name: 'summary')
  String summary;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'author')
  String author;

  Records(this.articleId,this.articleTitle,this.titleUrl,this.imgUrl,this.summary,this.createTime,this.content,this.author,);

  factory Records.fromJson(Map<String, dynamic> srcJson) => _$RecordsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecordsToJson(this);

}

  
