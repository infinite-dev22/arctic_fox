// To parse this JSON data, do
//
//     final documentsModel = documentsModelFromJson(jsonString);

import 'dart:convert';

DocumentsModel documentsModelFromJson(String str) => DocumentsModel.fromJson(json.decode(str));

String documentsModelToJson(DocumentsModel data) => json.encode(data.toJson());

class DocumentsModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? updatedBy;
  String? fileUrl;
  String? name;
  String? extension;
  int? documentTypeId;
  String? externalKey;

  DocumentsModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.updatedBy,
    this.fileUrl,
    this.name,
    this.extension,
    this.documentTypeId,
    this.externalKey,
  });

  factory DocumentsModel.fromJson(Map<String, dynamic> json) => DocumentsModel(
    id: json["id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    updatedBy: json["updated_by"],
    fileUrl: json["file_url"],
    name: json["name"],
    extension: json["extension"],
    documentTypeId: json["document_type_id"],
    externalKey: json["external_key"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "updated_by": updatedBy,
    "file_url": fileUrl,
    "name": name,
    "extension": extension,
    "document_type_id": documentTypeId,
    "external_key": externalKey,
  };
}




// class Documents {
//   String? fileUrl;
//
//   Documents({
//     this.fileUrl,
//   });
//
//   factory Documents.fromJson(Map<String, dynamic> json) => Documents(
//     fileUrl: json["file_url"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "file_url": fileUrl,
//   };
// }
