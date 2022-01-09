import 'dart:convert';

ListDomainModel listDomainModelFromJson(String str) =>
    ListDomainModel.fromJson(json.decode(str));

String listDomainModelToJson(ListDomainModel data) =>
    json.encode(data.toJson());

class ListDomainModel {
  ListDomainModel({
    this.code,
    this.response,
    this.content,
  });

  int? code;
  String? response;
  List<Content>? content;

  factory ListDomainModel.fromJson(Map<String, dynamic> json) =>
      ListDomainModel(
        code: json["code"],
        response: json["response"],
        content:
        List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "response": response,
    "content": List<dynamic>.from(content!.map((x) => x.toJson())),
  };
}

class Content {
  Content({
    this.id,
    this.rev,
    this.titles,
    this.thumbnail,
    this.theme,
    this.modules,
    this.subs,
    this.domain,
    this.modified,
    this.modifiedid,
    this.ipaddress,
    this.createid,
    this.created,
    this.computer,
    this.note,
  });

  String? id;
  String? rev;
  List<Title>? titles;
  dynamic thumbnail;
  dynamic theme;
  List<dynamic>? modules;
  List<dynamic>? subs;
  String? domain;
  dynamic modified;
  dynamic modifiedid;
  dynamic ipaddress;
  dynamic createid;
  dynamic created;
  dynamic computer;
  dynamic note;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    id: json["id"],
    rev: json["_rev"],
    titles: List<Title>.from(json["titles"].map((x) => Title.fromJson(x))),
    thumbnail: json["thumbnail"],
    theme: json["theme"],
    modules: List<dynamic>.from(json["modules"].map((x) => x)),
    subs: List<dynamic>.from(json["subs"].map((x) => x)),
    domain: json["domain"],
    modified: json["modified"],
    modifiedid: json["modifiedid"],
    ipaddress: json["ipaddress"],
    createid: json["createid"],
    created: json["created"],
    computer: json["computer"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "_rev": rev,
    "titles": List<dynamic>.from(titles!.map((x) => x.toJson())),
    "thumbnail": thumbnail,
    "theme": theme,
    "modules": List<dynamic>.from(modules!.map((x) => x)),
    "subs": List<dynamic>.from(subs!.map((x) => x)),
    "domain": domain,
    "modified": modified,
    "modifiedid": modifiedid,
    "ipaddress": ipaddress,
    "createid": createid,
    "created": created,
    "computer": computer,
    "note": note,
  };
}

class Title {
  Title({
    this.code,
    this.text,
  });

  Code? code;
  String? text;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
    code: codeValues.map[json["code"]],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "code": codeValues.reverse![code],
    "text": text,
  };
}

enum Code { LO, EN_US }

final codeValues = EnumValues({"en-US": Code.EN_US, "lo": Code.LO});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
