import 'dart:convert';

EducationModel educationFromJson(String str) => EducationModel.fromJson(json.decode(str));

String educationToJson(EducationModel data) => json.encode(data.toJson());

class EducationModel {
  String course;
  String clg;
  String yearOfParsing;

  EducationModel({
    this.course = "",
    this.clg = "",
    this.yearOfParsing = "",
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) => EducationModel(
        course: json["course"],
        clg: json["clg"],
        yearOfParsing: json["yearOfParsing"],
      );

  Map<String, dynamic> toJson() => {
        "course": course,
        "clg": clg,
        "yearOfParsing": yearOfParsing,
      };
}
