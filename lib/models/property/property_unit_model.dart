// // To parse this JSON data, do
// //
// //     final propertyUnitModel = propertyUnitModelFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:smart_rent/models/general/smart_model.dart';
//
// PropertyUnitModel propertyUnitModelFromJson(String str) => PropertyUnitModel.fromJson(json.decode(str));
//
// String propertyUnitModelToJson(PropertyUnitModel data) => json.encode(data.toJson());
//
// class PropertyUnitModel extends SmartPropertyUnitModel{
//   int? id;
//   int? propertyId;
//   int? totalUnits;
//   int? available;
//   int? occupied;
//   int? revenue;
//
//   PropertyUnitModel({
//     this.id,
//     this.propertyId,
//     this.totalUnits,
//     this.available,
//     this.occupied,
//     this.revenue,
//   });
//
//   factory PropertyUnitModel.fromJson(Map<String, dynamic> json) => PropertyUnitModel(
//     id: json["id"],
//     propertyId: json["property_id"],
//     totalUnits: json["total_units"],
//     available: json["available"],
//     occupied: json["occupied"],
//     revenue: json["revenue"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "property_id": propertyId,
//     "total_units": totalUnits,
//     "available": available,
//     "occupied": occupied,
//     "revenue": revenue,
//   };
//
//   @override
//   int getAvailableUnits() { return available!;
//   }
//
//   @override
//   int getId() { return id!;
//   }
//
//   @override
//   int getOccupiedUnits() { return occupied!;
//   }
//
//   @override
//   int getPropertyId() { return propertyId!;
//   }
//
//   @override
//   int getRevenue() { return revenue!;
//   }
//
//   @override
//   int getTotalUnits() { return totalUnits!;
//   }
// }
