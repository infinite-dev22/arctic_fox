// To parse this JSON data, do
//
//     final propertyModel = propertyModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/documents/documents_model.dart';
import 'package:smart_rent/models/general/smart_model.dart';
import 'package:smart_rent/models/payment_schedule/payment_schedule_model.dart';
import 'package:smart_rent/models/property/property_unit_model.dart';
import 'package:smart_rent/models/unit/unit_model.dart';

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
  int? mainImage;
  DocumentsModel? documents;
  PaymentScheduleModel? paymentDurations;
  UnitModel? units;
  PropertyUnitModel? propertyUnitModel;

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
    this.paymentDurations,
    this.units,
    this.propertyUnitModel,
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
    paymentDurations: json["payment_schedules"] == null ? null : PaymentScheduleModel.fromJson(json["payment_schedules"]),
    units: json["units"] == null ? null : UnitModel.fromJson(json["units"]),
    propertyUnitModel: json["property_units"] == null ? null : PropertyUnitModel.fromJson(json["property_units"][0]),


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
    "payment_schedules": paymentDurations?.toJson(),
    "units": units?.toJson(),
    "property_units": propertyUnitModel?.toJson(),

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
  int getMainImage() { return mainImage!;
  }

  @override
  String getImageDocUrl() { return documents!.fileUrl.toString();
  }

  @override
  String getNumber() {
    // TODO: implement getNumber
    throw UnimplementedError();
  }

  @override
  String getPropertyCategoryName() {
    // TODO: implement getPropertyCategoryName
    throw UnimplementedError();
  }
}


// PropertyUnitModel propertyUnitModelFromJson(String str) => PropertyUnitModel.fromJson(json.decode(str));
//
// String propertyUnitModelToJson(PropertyUnitModel data) => json.encode(data.toJson());

class PropertyUnitModel extends SmartPropertyUnitModel{
  int? id;
  int? propertyId;
  int? totalUnits;
  int? available;
  int? occupied;
  int? revenue;

  PropertyUnitModel({
    this.id,
    this.propertyId,
    this.totalUnits,
    this.available,
    this.occupied,
    this.revenue,
  });

  factory PropertyUnitModel.fromJson(Map<String, dynamic> json) => PropertyUnitModel(
    id: json["id"],
    propertyId: json["property_id"],
    totalUnits: json["total_units"],
    available: json["available"],
    occupied: json["occupied"],
    revenue: json["revenue"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "property_id": propertyId,
    "total_units": totalUnits,
    "available": available,
    "occupied": occupied,
    "revenue": revenue,
  };

  @override
  int getAvailableUnits() { return available!;
  }

  @override
  int getId() { return id!;
  }

  @override
  int getOccupiedUnits() { return occupied!;
  }

  @override
  int getPropertyId() { return propertyId!;
  }

  @override
  int getRevenue() { return revenue!;
  }

  @override
  int getTotalUnits() { return totalUnits!;
  }
}
