import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_resume/models/education_model.dart';
import 'package:simple_resume/utils/navigation.dart';
import 'package:simple_resume/view/add_education_screens/add_education_screen.dart';
import 'package:simple_resume/view/widgets/custom_btn.dart';

import '../../controller/controller.dart';

class EducationListScreen extends ConsumerWidget {
  const EducationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<EducationModel> educationListData = ref.watch(educationList);
    bool load = ref.watch(internalLoading);
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ListView.builder(
          padding: commonPad(),
          itemCount: educationListData.length + 1,
          itemBuilder: (context, index) {
            if (index != educationListData.length) {
              return GestureDetector(
                onTap: () => pushPage(
                    context,
                    AddEducationScreen(
                      index: index,
                      educationModel: educationListData[index],
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
                              educationListData[index].course,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              educationListData[index].clg,
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
                    onPressed: () => pushPage(context, const AddEducationScreen()),
                    icon: const CircleAvatar(
                      child: Icon(Icons.add),
                    ),
                  ),
                  CustomBtn(
                    onTap: () {
                      if (educationListData.isEmpty) {
                        snack(context, "Please enter at least one Education Detail");
                      } else {
                        ref.read(controller.notifier).addResumeData(
                              index: ref.watch(currentIndex),
                              ref: ref,
                              educationList: educationListData,
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
