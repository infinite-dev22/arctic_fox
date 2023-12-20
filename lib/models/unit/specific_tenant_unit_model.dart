// To parse this JSON data, do
//
//     final specificTenantUnitModel = specificTenantUnitModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

List<SpecificTenantUnitModel> specificTenantUnitModelFromJson(String str) => List<SpecificTenantUnitModel>.from(json.decode(str).map((x) => SpecificTenantUnitModel.fromJson(x)));

String specificTenantUnitModelToJson(List<SpecificTenantUnitModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpecificTenantUnitModel extends SmartSpecificTenantUnitModel{
  int? id;
  int? amount;
  DateTime? fromDate;
  DateTime? toDate;
  Tenants? tenants;
  Units? units;
  int? unitId;
  int? tenantId;

  SpecificTenantUnitModel({
    this.id,
    this.amount,
    this.fromDate,
    this.toDate,
    this.tenants,
    this.units,
    this.unitId,
    this.tenantId,
  });

  factory SpecificTenantUnitModel.fromJson(Map<String, dynamic> json) => SpecificTenantUnitModel(
    id: json["id"],
    amount: json["amount"],
    fromDate: json["from_date"] == null ? null : DateTime.parse(json["from_date"]),
    toDate: json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
    tenants: json["tenants"] == null ? null : Tenants.fromJson(json["tenants"]),
    units: json["units"] == null ? null : Units.fromJson(json["units"]),
    unitId: json["unit_id"],
    tenantId: json["tenant_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "from_date": fromDate?.toIso8601String(),
    "to_date": toDate?.toIso8601String(),
    "tenants": tenants?.toJson(),
    "units": units?.toJson(),
    "unit_id": unitId,
    "tenant_id": tenantId,
  };

  @override
  int getAmount() { return amount!;
  }

  @override
  DateTime getFromDate() { return fromDate!;
  }

  @override
  int getId() { return id!;
  }

  @override
  int getTenantId() { return tenantId!;
  }

  @override
  DateTime getToDate() { return toDate!;
  }

  @override
  int getUnitId() { return unitId!;
  }

  @override
  String getUnitNumber() { return units!.unitNumber.toString();
  }

  @override
  String getTenantName() { return tenants!.name.toString();
  }
}

class Tenants {
  String? name;

  Tenants({
    this.name,
  });

  factory Tenants.fromJson(Map<String, dynamic> json) => Tenants(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class Units {
  String? unitNumber;

  Units({
    this.unitNumber,
  });

  factory Units.fromJson(Map<String, dynamic> json) => Units(
    unitNumber: json["unit_number"],
  );

  Map<String, dynamic> toJson() => {
    "unit_number": unitNumber,
  };
}
