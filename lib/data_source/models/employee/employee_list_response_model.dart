// To parse this JSON data, do
//
//     final employeeModel = employeeModelFromJson(jsonString);

import 'dart:convert';

List<EmployeeModel> employeeModelFromJson(String str) => List<EmployeeModel>.from(json.decode(str).map((x) => EmployeeModel.fromJson(x)));

String employeeModelToJson(List<EmployeeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeModel {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  int? isActive;
  String? theme;
  DateTime? createdAt;
  DateTime? updatedAt;
  Employee? employee;

  EmployeeModel({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.isActive,
    this.theme,
    this.createdAt,
    this.updatedAt,
    this.employee,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    isActive: json["is_active"],
    theme: json["theme"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    employee: json["employee"] == null ? null : Employee.fromJson(json["employee"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "is_active": isActive,
    "theme": theme,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "employee": employee?.toJson(),
  };
}

class Employee {
  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? telephone;
  DateTime? dateOfBirth;
  int? gender;
  dynamic code;
  dynamic idNumber;
  dynamic nssfNumber;
  dynamic tinNumber;
  dynamic personalEmail;
  dynamic permanentAddress;
  dynamic presentAddress;
  dynamic officeNumber;
  dynamic mobileNumber;
  int? userId;
  int? branchId;
  dynamic maritalStatusId;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Employee({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.telephone,
    this.dateOfBirth,
    this.gender,
    this.code,
    this.idNumber,
    this.nssfNumber,
    this.tinNumber,
    this.personalEmail,
    this.permanentAddress,
    this.presentAddress,
    this.officeNumber,
    this.mobileNumber,
    this.userId,
    this.branchId,
    this.maritalStatusId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    telephone: json["telephone"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    gender: json["gender"],
    code: json["code"],
    idNumber: json["id_number"],
    nssfNumber: json["nssf_number"],
    tinNumber: json["tin_number"],
    personalEmail: json["personal_email"],
    permanentAddress: json["permanent_address"],
    presentAddress: json["present_address"],
    officeNumber: json["office_number"],
    mobileNumber: json["mobile_number"],
    userId: json["user_id"],
    branchId: json["branch_id"],
    maritalStatusId: json["marital_status_id"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "telephone": telephone,
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "code": code,
    "id_number": idNumber,
    "nssf_number": nssfNumber,
    "tin_number": tinNumber,
    "personal_email": personalEmail,
    "permanent_address": permanentAddress,
    "present_address": presentAddress,
    "office_number": officeNumber,
    "mobile_number": mobileNumber,
    "user_id": userId,
    "branch_id": branchId,
    "marital_status_id": maritalStatusId,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
