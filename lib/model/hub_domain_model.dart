import 'dart:convert';

HubDomainModel hubDomainModelFromJson(String str) => HubDomainModel.fromJson(json.decode(str));

String hubDomainModelToJson(HubDomainModel data) => json.encode(data.toJson());

class HubDomainModel {
  HubDomainModel({
    this.id,
    this.apiEndpoint,
    this.title,
  });

  String? id;
  String? apiEndpoint;
  String? title;

  factory HubDomainModel.fromJson(Map<String, dynamic> json) => HubDomainModel(
    id: json["id"],
    apiEndpoint: json["apiEndpoint"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "apiEndpoint": apiEndpoint,
    "title": title,
  };
}
