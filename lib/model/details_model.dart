import 'dart:convert';

DetailsModel detailsModelFromJson(String str) =>
    DetailsModel.fromJson(json.decode(str));

String detailsModelToJson(DetailsModel data) => json.encode(data.toJson());

class DetailsModel {
  String? status;
  List<Employee>? employees;

  DetailsModel({
    this.status,
    this.employees,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
        status: json["status"],
        employees: json["employees"] == null
            ? []
            : List<Employee>.from(
                json["employees"]!.map((x) => Employee.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "employees": employees == null
            ? []
            : List<dynamic>.from(employees!.map((x) => x.toJson())),
      };
}

class Employee {
  String? id;
  String? employeeName;
  String? designation;

  Employee({
    this.id,
    this.employeeName,
    this.designation,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        employeeName: json["employee_name"],
        designation: json["designation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_name": employeeName,
        "designation": designation,
      };
}
