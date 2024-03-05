import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_resume/models/education_model.dart';
import 'package:simple_resume/models/experience_model.dart';
import 'package:simple_resume/models/info_model.dart';
import 'package:simple_resume/models/project_model.dart';
import 'package:simple_resume/models/resume_model.dart';
import 'package:simple_resume/utils/app_icon.dart';
import 'package:simple_resume/view/add_education_screens/education_list_screen.dart';
import 'package:simple_resume/view/add_experience_screens/experience_list_screen.dart';
import 'package:simple_resume/view/add_projects_screens/project_list_screen.dart';
import 'package:simple_resume/view/add_skills_screens/add_skill_screen..dart';
import 'package:simple_resume/view/contact_information_screens/contact_information_screen.dart';

import '../models/api_state.dart';
import '../models/screens_model.dart';

StateProvider<String> selectedScreen = StateProvider<String>((ref) => "Information");
StateProvider<List<ResumeModel>> resumeList = StateProvider<List<ResumeModel>>((ref) => []);
StateProvider<ResumeModel> resume = StateProvider<ResumeModel>((ref) => ResumeModel());
StateProvider<int> currentIndex = StateProvider<int>((ref) => 0);

/// add details variables
StateProvider<List<EducationModel>> educationList =
    StateProvider<List<EducationModel>>((ref) => []);
StateProvider<List<ExperienceModel>> experienceList =
    StateProvider<List<ExperienceModel>>((ref) => []);
StateProvider<List<ProjectModel>> projectList = StateProvider<List<ProjectModel>>((ref) => []);
StateProvider<List<TextEditingController>> skillsList =
    StateProvider<List<TextEditingController>>((ref) => []);
StateProvider<InfoModel> info = StateProvider<InfoModel>((ref) => InfoModel());
StateProvider<bool> internalLoading = StateProvider<bool>((ref) => false);
StateProvider<bool> loading = StateProvider<bool>((ref) => false);
StateProvider<bool> skillLoading = StateProvider<bool>((ref) => false);

List<ScreenModel> screenList = [
  ScreenModel(title: "Information", icon: AppIcon.info, screen: const ContactInformationScreen()),
  ScreenModel(title: "Education", icon: AppIcon.education, screen: const EducationListScreen()),
  ScreenModel(title: "Experience", icon: AppIcon.work, screen: const ExperienceListScreen()),
  ScreenModel(title: "Projects", icon: AppIcon.project, screen: const ProjectListScreen()),
  ScreenModel(title: "Skills", icon: AppIcon.skills, screen: const AddSkillScreen()),
];

final controller = StateNotifierProvider<Controller, ApiState>(
  (ref) => Controller(),
);

class Controller extends StateNotifier<ApiState> {
  Controller() : super(ApiState.initial());

  void changeInternalLoading(bool value, WidgetRef ref) {
    ref.read(internalLoading.notifier).state = value;
  }

  void changeLoading(bool value, WidgetRef ref) {
    ref.read(loading.notifier).state = value;
  }

  void changeSkillLoading(bool value, WidgetRef ref) {
    ref.read(skillLoading.notifier).state = value;
  }

  void addUpdateEducation(
    WidgetRef ref, {
    int? index,
    bool isDelete = false,
    EducationModel? data,
  }) {
    changeInternalLoading(true, ref);
    List<EducationModel> dummyList = ref.watch(educationList);
    if (isDelete) {
      dummyList.removeAt(index!);
    } else {
      if (index != null) {
        dummyList.removeAt(index);
        dummyList.insert(index, data!);
      } else {
        dummyList.add(data!);
      }
    }
    ref.read(educationList.notifier).state = dummyList;
    Future.delayed(const Duration(milliseconds: 250), () => changeInternalLoading(false, ref));
  }

  void addUpdateExperience(
    WidgetRef ref, {
    int? index,
    bool isDelete = false,
    ExperienceModel? data,
  }) {
    changeInternalLoading(true, ref);
    List<ExperienceModel> dummyList = ref.watch(experienceList);
    if (isDelete) {
      dummyList.removeAt(index!);
    } else {
      if (index != null) {
        dummyList.removeAt(index);
        dummyList.insert(index, data!);
      } else {
        dummyList.add(data!);
      }
    }
    ref.read(experienceList.notifier).state = dummyList;
    Future.delayed(const Duration(milliseconds: 250), () => changeInternalLoading(false, ref));
  }

  void addUpdateProject(
    WidgetRef ref, {
    int? index,
    bool isDelete = false,
    ProjectModel? data,
  }) {
    changeInternalLoading(true, ref);
    List<ProjectModel> dummyList = ref.watch(projectList);
    if (isDelete) {
      dummyList.removeAt(index!);
    } else {
      if (index != null) {
        dummyList.removeAt(index);
        dummyList.insert(index, data!);
      } else {
        dummyList.add(data!);
      }
    }
    ref.read(projectList.notifier).state = dummyList;
    Future.delayed(const Duration(milliseconds: 250), () => changeInternalLoading(false, ref));
  }

  void addResumeData({
    List<EducationModel>? educationList,
    List<ExperienceModel>? experienceList,
    InfoModel? info,
    List<ProjectModel>? projectList,
    List<String>? skillList,
    required int index,
    required WidgetRef ref,
  }) {
    changeLoading(true, ref);
    List<ResumeModel> dummyList = ref.watch(resumeList);
    debugPrint("==>> ${dummyList.length} == $index");
    if (index < dummyList.length) {
      dummyList.removeAt(index);
    debugPrint("==>> 2${dummyList.length} == $index");
    }
    ResumeModel data = ResumeModel(
      info: info ?? ref.watch(resume).info,
      education: educationList ?? ref.watch(resume).education,
      experience: experienceList ?? ref.watch(resume).experience,
      project: projectList ?? ref.watch(resume).project,
      skill: skillList ?? ref.watch(resume).skill,
    );
    dummyList.insert(
      index,
      data,
    );
    debugPrint("==>> 3${dummyList.length} == $index");
    ref.read(resume.notifier).state = data;
    ref.read(resumeList.notifier).state = dummyList;
    Future.delayed(const Duration(milliseconds: 250), () => changeLoading(false, ref));
  }

  void removeResumeData({
    required int index,
    required WidgetRef ref,
  }) {
    changeLoading(true, ref);
    List<ResumeModel> dummyList = ref.watch(resumeList);
    dummyList.removeAt(index);
    ref.read(resumeList.notifier).state = dummyList;
    Future.delayed(const Duration(milliseconds: 250), () => changeLoading(false, ref));
  }

  void addSkillList({
    required List<String> list,
    required WidgetRef ref,
    bool isNewAdd = false,
  }) {
    changeSkillLoading(true, ref);

    List<TextEditingController> dummy = isNewAdd ? ref.watch(skillsList) : [];
    if (isNewAdd) {
      dummy.add(TextEditingController());
    } else {
      for (String skill in list) {
        debugPrint("==$skill=");
        dummy.add(TextEditingController(text: skill));
      }
    }
    ref.read(skillsList.notifier).state = dummy;
    Future.delayed(const Duration(milliseconds: 250), () => changeSkillLoading(false, ref));
  }

  void updateSkills({
    String? skill,
    required int index,
    required WidgetRef ref,
    bool isDelete = false,
  }) {
    changeInternalLoading(true, ref);
    List<TextEditingController> dummy = ref.watch(skillsList);
    if (isDelete) {
      dummy.removeAt(index);
    } else {
      dummy.removeAt(index);
      dummy.insert(index, TextEditingController(text: skill));
    }
    ref.read(skillsList.notifier).state = dummy;
    Future.delayed(const Duration(milliseconds: 250), () => changeInternalLoading(false, ref));
  }
}
