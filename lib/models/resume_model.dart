import 'package:simple_resume/models/education_model.dart';
import 'package:simple_resume/models/experience_model.dart';
import 'package:simple_resume/models/info_model.dart';
import 'package:simple_resume/models/project_model.dart';

class ResumeModel {
  List<EducationModel>? education;
  List<ExperienceModel>? experience;
  List<ProjectModel>? project;
  List<String>? skill;
  InfoModel? info;

  ResumeModel({
    this.education,
    this.experience,
    this.project,
    this.skill,
    this.info,
  });
}
