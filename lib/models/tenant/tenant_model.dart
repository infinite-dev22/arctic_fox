// To parse this JSON data, do
//
//     final tenantModel = tenantModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';



// To parse this JSON data, do
//
//     final tenantModel = tenantModelFromJson(jsonString);

import 'dart:convert';

TenantModel tenantModelFromJson(String str) => TenantModel.fromJson(json.decode(str));

String tenantModelToJson(TenantModel data) => json.encode(data.toJson());

class TenantModel extends SmartTenantModel{
  int id;
  String name;
  int tenantTypeId;
  int nationId;
  String tenantNo;
  int businessTypeId;
  String description;

  TenantModel({
    required this.id,
    required this.name,
    required this.tenantTypeId,
    required this.nationId,
    required this.tenantNo,
    required this.businessTypeId,
    required this.description,
  });

  factory TenantModel.fromJson(Map<String, dynamic> json) => TenantModel(
    id: json["id"],
    name: json["name"],
    tenantTypeId: json["tenant_type_id"],
    nationId: json["nation_id"],
    tenantNo: json["tenant_no"],
    businessTypeId: json["business_type_id"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "tenant_type_id": tenantTypeId,
    "nation_id": nationId,
    "tenant_no": tenantNo,
    "business_type_id": businessTypeId,
    "description": description,
  };

  @override
  int getBusinessTypeId() { return businessTypeId;
  }

  @override
  String getDescription() { return description;
  }

  @override
  int getId() { return id;
  }

  @override
  String getName() { return name;
  }

  @override
  int getNationId() { return id;
  }

  @override
  String getTenantNo() { return tenantNo;
  }

  @override
  int getTenantTypeId() { return tenantTypeId;
  }
}




//
// TenantModel tenantModelFromJson(String str) => TenantModel.fromJson(json.decode(str));
//
// String tenantModelToJson(TenantModel data) => json.encode(data.toJson());
//
// class TenantModel extends SmartModel{
//   int id;
//   String name;
//
//   TenantModel({
//     required this.id,
//     required this.name,
//   });
//
//   factory TenantModel.fromJson(Map<String, dynamic> json) => TenantModel(
//     id: json["id"],
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//   };
//
//   @override
//   int getId() { return id;
//   }
//
//   @override
//   String getName() { return name;
//   }
// }
