import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_resume/controller/controller.dart';
import 'package:simple_resume/models/resume_model.dart';
import 'package:simple_resume/utils/navigation.dart';

import '../widgets/custom_btn.dart';

class AddSkillScreen extends ConsumerStatefulWidget {
  const AddSkillScreen({super.key});

  @override
  AddSkillScreenState createState() => AddSkillScreenState();
}

class AddSkillScreenState extends ConsumerState<AddSkillScreen> {
  List<TextEditingController> dummySkill = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ResumeModel dummyResume = ref.watch(resume);
      if (dummyResume.skill != null) {
        ref.read(controller.notifier).addSkillList(list: dummyResume.skill!, ref: ref);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool load = ref.watch(internalLoading);
    bool skillLoad = ref.watch(skillLoading);
    List<TextEditingController> list = ref.watch(skillsList);
    return ListView.builder(
      padding: commonPad(),
      itemCount: list.length + 1,
      itemBuilder: (context, index) {
        if (index == list.length) {
          return Column(
            children: [
              IconButton(
                onPressed: () {
                    ref.read(controller.notifier).addSkillList(
                      list: [],
                      ref: ref,
                      isNewAdd: true,
                    );
                },
                icon: skillLoad
                    ? const CircularProgressIndicator()
                    : const CircleAvatar(
                        child: Icon(Icons.add),
                      ),
              ),
              CustomBtn(
                onTap: () {
                  if (list.isEmpty) {
                    snack(context, "Please enter at least one skill");
                  } else {
                    if (list.any((element) => element.text.isEmpty)) {
                      snack(context, "Please fill above skills");
                    } else {
                      ref.read(controller.notifier).addResumeData(
                            index: ref.watch(currentIndex),
                            ref: ref,
                            skillList: list.map((e) => e.text).toList(),
                          );
                    }
                  }
                },
                title: load ? "Loading" : "Update",
              ),
            ],
          );
        } else {
          return TextFormField(
            initialValue: list[index].value.text,
            onChanged: (_) {
              ref.read(controller.notifier).updateSkills(
                    index: index,
                    ref: ref,
                    skill: _,
                  );
            },
          );
        }
      },
    );
  }
}
