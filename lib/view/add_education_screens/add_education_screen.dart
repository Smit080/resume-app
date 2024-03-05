import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_resume/controller/controller.dart';
import 'package:simple_resume/models/education_model.dart';
import 'package:simple_resume/utils/navigation.dart';
import 'package:simple_resume/view/widgets/common_textfield.dart';
import 'package:simple_resume/view/widgets/custom_btn.dart';

class AddEducationScreen extends ConsumerStatefulWidget {
  final int? index;
  final EducationModel? educationModel;

  const AddEducationScreen({super.key, this.index, this.educationModel});

  @override
  AddEducationScreenState createState() => AddEducationScreenState();
}

class AddEducationScreenState extends ConsumerState<AddEducationScreen> {
  TextEditingController course = TextEditingController();
  TextEditingController clg = TextEditingController();
  TextEditingController year = TextEditingController();

  @override
  void initState() {
    if (widget.educationModel != null) {
      course.text = widget.educationModel!.course;
      clg.text = widget.educationModel!.clg;
      year.text = widget.educationModel!.yearOfParsing;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool load = ref.watch(internalLoading);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Education"),
      ),
      body: ListView(
        padding: commonPad(),
        children: [
          TextFormFieldWidget(
            title: "Course",
            controller: course,
          ),
          TextFormFieldWidget(
            title: "College",
            controller: clg,
          ),
          TextFormFieldWidget(
            title: "Year of Parsing",
            controller: year,
            keyboardType: TextInputType.phone,
          ),
          CustomBtn(
            onTap: () {
              if (clg.text.isNotEmpty && course.text.isNotEmpty && year.text.isNotEmpty) {
                ref.read(controller.notifier).addUpdateEducation(
                    data: EducationModel(
                      clg: clg.text,
                      course: course.text,
                      yearOfParsing: year.text,
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
