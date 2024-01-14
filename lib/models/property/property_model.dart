// To parse this JSON data, do
//
//     final propertyModel = propertyModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/documents/documents_model.dart';
import 'package:smart_rent/models/general/smart_model.dart';

PropertyModel propertyModelFromJson(String str) => PropertyModel.fromJson(json.decode(str));

String propertyModelToJson(PropertyModel data) => json.encode(data.toJson());

class PropertyModel extends SmartPropertyModel {
  int? id;
  String? name;
  String? description;
  int? organisationId;
  String? squareMeters;
  int? propertyTypeId;
  int? categoryTypeId;
  String? location;
  String? mainImage;
  DocumentsModel? documents;

  PropertyModel({
    this.id,
    this.name,
    this.description,
    this.organisationId,
    this.squareMeters,
    this.propertyTypeId,
    this.categoryTypeId,
    this.location,
    this.mainImage,
    this.documents,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    organisationId: json["organisation_id"],
    squareMeters: json["square_meters"],
    propertyTypeId: json["property_type_id"],
    categoryTypeId: json["category_type_id"],
    location: json["location"],
    mainImage: json["main_image"],
    documents: json["documents"] == null ? null : DocumentsModel.fromJson(json["documents"]),

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "organisation_id": organisationId,
    "square_meters": squareMeters,
    "property_type_id": propertyTypeId,
    "category_type_id": categoryTypeId,
    "location": location,
    "main_image": mainImage,
    "documents": documents?.toJson(),

  };

  @override
  int getCategoryTypeId() { return categoryTypeId!;
  }

  @override
  String getDescription() { return description!;
  }

  @override
  int getId() { return id!;
  }

  @override
  String getLocation() { return location!;
  }

  @override
  String getName() { return name!;
  }

  @override
  int getOrganisationId() { return organisationId!;
  }

  @override
  int getPropertyTypeId() { return propertyTypeId!;  }

  @override
  String getSquareMeters() { return squareMeters!;
  }

  @override
  String getMainImage() { return mainImage.toString();
  }

  @override
  String getImageDocUrl() { return documents!.fileUrl.toString();
  }
}
