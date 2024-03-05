import 'dart:convert';

ProjectModel projectFromJson(String str) => ProjectModel.fromJson(json.decode(str));

String projectToJson(ProjectModel data) => json.encode(data.toJson());

class ProjectModel {
  String projectName;
  String description;

  ProjectModel({
    required this.projectName,
    required this.description,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
    projectName: json["projectName"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "projectName": projectName,
    "description": description,
  };
}
