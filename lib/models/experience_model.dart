import 'dart:convert';

ExperienceModel experienceFromJson(String str) => ExperienceModel.fromJson(json.decode(str));

String experienceToJson(ExperienceModel data) => json.encode(data.toJson());

class ExperienceModel {
  String company;
  String designation;
  String role;
  String totalExp;

  ExperienceModel({
    this.company = "",
    this.designation = "",
    this.role = "",
    this.totalExp = "",
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) => ExperienceModel(
    company: json["company"],
    designation: json["designation"],
    role: json["role"],
    totalExp: json["totalExp"],
  );

  Map<String, dynamic> toJson() => {
    "company": company,
    "designation": designation,
    "role": role,
    "totalExp": totalExp,
  };
}
