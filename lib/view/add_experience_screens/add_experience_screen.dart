import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_resume/models/experience_model.dart';
import 'package:simple_resume/utils/navigation.dart';
import 'package:simple_resume/view/widgets/common_textfield.dart';
import 'package:simple_resume/view/widgets/custom_btn.dart';

import '../../controller/controller.dart';

class AddExperienceScreen extends ConsumerStatefulWidget {
  final int? index;
  final ExperienceModel? experienceModel;

  const AddExperienceScreen({super.key, this.index, this.experienceModel});

  @override
  AddExperienceScreenState createState() => AddExperienceScreenState();
}

class AddExperienceScreenState extends ConsumerState<AddExperienceScreen> {
  TextEditingController company = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController role = TextEditingController();
  TextEditingController totalExp = TextEditingController();

  @override
  void initState() {
    if (widget.experienceModel != null) {
      company.text = widget.experienceModel!.company;
      designation.text = widget.experienceModel!.designation;
      role.text = widget.experienceModel!.role;
      totalExp.text = widget.experienceModel!.totalExp;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool load = ref.watch(internalLoading);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Experience"),
      ),
      body: ListView(
        padding: commonPad(),
        children: [
          TextFormFieldWidget(
            title: "Company Name",
            controller: company,
          ),
          TextFormFieldWidget(
            title: "Designation",
            controller: designation,
          ),
          TextFormFieldWidget(
            title: "Role",
            controller: role,
          ),
          TextFormFieldWidget(
            title: "Total Experience",
            controller: totalExp,
            keyboardType: TextInputType.phone,
          ),
          CustomBtn(
            onTap: () {
              if (company.text.isNotEmpty &&
                  designation.text.isNotEmpty &&
                  role.text.isNotEmpty &&
                  totalExp.text.isNotEmpty) {
                ref.read(controller.notifier).addUpdateExperience(
                    data: ExperienceModel(
                      company: company.text,
                      designation: designation.text,
                      role: role.text,
                      totalExp: totalExp.text,
                    ),
                    ref,
                    index: widget.index);
                popPage(context);
              } else {
                snack(context, "Please enter all fields");
              }
            },
            title: load
                ? "Loading"
                : widget.index != null
                    ? "Update"
                    : "Add",
          )
        ],
      ),
    );
  }
}
