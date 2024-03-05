import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_resume/controller/controller.dart';
import 'package:simple_resume/models/experience_model.dart';
import 'package:simple_resume/utils/navigation.dart';
import 'package:simple_resume/view/add_experience_screens/add_experience_screen.dart';
import 'package:simple_resume/view/widgets/custom_btn.dart';

class ExperienceListScreen extends ConsumerWidget {
  const ExperienceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ExperienceModel> experienceListData = ref.watch(experienceList);
    bool load = ref.watch(internalLoading);
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ListView.builder(
          padding: commonPad(),
          itemCount: experienceListData.length + 1,
          itemBuilder: (context, index) {
            if (index != experienceListData.length) {
              ExperienceModel data = experienceListData[index];
              return GestureDetector(
                onTap: () => pushPage(
                    context,
                    AddExperienceScreen(
                      index: index,
                      experienceModel: data,
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
                              data.company,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Designation: ${data.designation}"
                              "(${data.totalExp})",
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Role: ${data.role}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
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
                    onPressed: () => pushPage(context, const AddExperienceScreen()),
                    icon: const CircleAvatar(
                      child: Icon(Icons.add),
                    ),
                  ),
                  CustomBtn(
                    onTap: () {
                      if (experienceListData.isEmpty) {
                        snack(context, "Please enter at least one Experience Data");
                      } else {
                        ref.read(controller.notifier).addResumeData(
                              index: ref.watch(currentIndex),
                              ref: ref,
                              experienceList: experienceListData,
                            );
                      }
                    },
                    title:load ? "Loading" :  "Update",
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
