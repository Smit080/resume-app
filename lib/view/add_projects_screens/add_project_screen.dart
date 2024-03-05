import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_resume/models/project_model.dart';
import 'package:simple_resume/utils/navigation.dart';
import 'package:simple_resume/view/widgets/common_textfield.dart';
import 'package:simple_resume/view/widgets/custom_btn.dart';

import '../../controller/controller.dart';

class AddProjectScreen extends ConsumerStatefulWidget {
  final int? index;
  final ProjectModel? projectModel;

  const AddProjectScreen({super.key, this.index, this.projectModel});

  @override
  AddProjectScreenState createState() => AddProjectScreenState();
}

class AddProjectScreenState extends ConsumerState<AddProjectScreen> {
  TextEditingController projectName = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    if (widget.projectModel != null) {
      projectName.text = widget.projectModel!.projectName;
      description.text = widget.projectModel!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool load = ref.watch(internalLoading);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project"),
      ),
      body: ListView(
        padding: commonPad(),
        children: [
          TextFormFieldWidget(
            title: "Project Name",
            controller: projectName,
          ),
          TextFormFieldWidget(
            title: "Description",
            controller: description,
            minlines: 5,
            maxlines: 5,
          ),
          CustomBtn(
            onTap: () {
              if (projectName.text.isNotEmpty && description.text.isNotEmpty) {
                ref.read(controller.notifier).addUpdateProject(
                    data: ProjectModel(
                      description: description.text,
                      projectName: projectName.text,
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
