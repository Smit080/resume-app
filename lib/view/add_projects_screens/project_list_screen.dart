import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_resume/controller/controller.dart';
import 'package:simple_resume/models/project_model.dart';
import 'package:simple_resume/utils/navigation.dart';
import 'package:simple_resume/view/add_projects_screens/add_project_screen.dart';
import 'package:simple_resume/view/widgets/custom_btn.dart';

class ProjectListScreen extends ConsumerWidget {
  const ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ProjectModel> projectListData = ref.watch(projectList);
    bool load = ref.watch(internalLoading);
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ListView.builder(
          padding: commonPad(),
          itemCount: projectListData.length + 1,
          itemBuilder: (context, index) {
            if (index != projectListData.length) {
              return GestureDetector(
                onTap: () => pushPage(
                    context,
                    AddProjectScreen(
                      index: index,
                      projectModel: projectListData[index],
                    )),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * 0.65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              projectListData[index].projectName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              projectListData[index].description,
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          ref.read(controller.notifier).addUpdateEducation(
                            ref,
                            isDelete: true,
                            index: index,
                          );
                        },
                        icon: const Icon(Icons.delete),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Column(
                children: [
                  IconButton(
                    onPressed: () => pushPage(context, const AddProjectScreen()),
                    icon: const CircleAvatar(
                      child: Icon(Icons.add),
                    ),
                  ),
                  CustomBtn(
                    onTap: () {
                      if (projectListData.isEmpty) {
                        snack(context, "Please enter at least one Experience Data");
                      } else {
                        ref.read(controller.notifier).addResumeData(
                          index: ref.watch(currentIndex),
                          ref: ref,
                          projectList: projectListData,
                        );
                      }
                    },
                    title: load ? "Loading" : "Update",
                  ),
                ],
              );
            }
          },
        ),
        if (load) const Center(child: CircularProgressIndicator())
      ],
    );
  }
}
