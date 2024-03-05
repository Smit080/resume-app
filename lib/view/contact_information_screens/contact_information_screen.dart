import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_resume/controller/controller.dart';
import 'package:simple_resume/models/info_model.dart';
import 'package:simple_resume/models/resume_model.dart';
import 'package:simple_resume/utils/navigation.dart';
import 'package:simple_resume/view/widgets/common_textfield.dart';
import 'package:simple_resume/view/widgets/custom_btn.dart';

class ContactInformationScreen extends ConsumerStatefulWidget {
  const ContactInformationScreen({super.key});

  @override
  ContactInformationScreenState createState() => ContactInformationScreenState();
}

class ContactInformationScreenState extends ConsumerState<ContactInformationScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  String image = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ResumeModel dummyResume = ref.watch(resume);
      if (dummyResume.info != null) {
        name.text = dummyResume.info!.name;
        email.text = dummyResume.info!.email;
        phone.text = dummyResume.info!.mobile;
        address.text = dummyResume.info!.address;
        image = dummyResume.info!.image;
        setState(() {});
        debugPrint(image);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool load = ref.watch(internalLoading);
    return ListView(
      padding: commonPad(),
      children: [
        GestureDetector(
          onTap: () async {
            final ImagePicker picker = ImagePicker();

            await picker.pickImage(source: ImageSource.gallery).then((value) {
              if (value != null) {
                setState(() {
                  image = value.path;
                });
              }
            });
          },
          child: CircleAvatar(
            radius: 40,
            backgroundImage: image.isEmpty ? null : FileImage(File(image)),
            child: image.isEmpty ? const Icon(Icons.add) : const SizedBox(),
          ),
        ),
        const SizedBox(height: 15),
        TextFormFieldWidget(
          title: "Name",
          controller: name,
        ),
        TextFormFieldWidget(
          title: "Email Address",
          controller: email,
          keyboardType: TextInputType.emailAddress,
        ),
        TextFormFieldWidget(
          title: "Mobile Number",
          controller: phone,
          keyboardType: TextInputType.phone,
        ),
        TextFormFieldWidget(
          title: "Address",
          controller: address,
          maxlines: 3,
          minlines: 3,
        ),
        CustomBtn(
          onTap: () {
            if (name.text.isNotEmpty && email.text.isNotEmpty) {
              ref.read(controller.notifier).addResumeData(
                    index: ref.watch(currentIndex),
                    ref: ref,
                    info: InfoModel(
                      name: name.text,
                      image: image,
                      address: address.text,
                      email: email.text,
                      mobile: phone.text,
                    ),
                  );
            }
          },
          title: load ? "Loading" : "Update",
        )
      ],
    );
  }
}
