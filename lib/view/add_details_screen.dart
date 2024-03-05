import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_resume/controller/controller.dart';
import 'package:simple_resume/models/resume_model.dart';

class AddDetailsScreen extends ConsumerStatefulWidget {
  final ResumeModel? data;

  const AddDetailsScreen({super.key, this.data});

  @override
  AddDetailsScreenState createState() => AddDetailsScreenState();
}

class AddDetailsScreenState extends ConsumerState<AddDetailsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(resume.notifier).state = widget.data == null ? ResumeModel() : widget.data!;
      ref.read(educationList.notifier).state =
          widget.data == null ? [] : widget.data!.education ?? [];
      ref.read(experienceList.notifier).state =
          widget.data == null ? [] : widget.data!.experience ?? [];
      ref.read(projectList.notifier).state = widget.data == null ? [] : widget.data!.project ?? [];
      ref.read(skillsList.notifier).state = [];
      ref.read(selectedScreen.notifier).state = 'Information';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String screen = ref.watch(selectedScreen);
    return PopScope(
      onPopInvoked: (_){
        ref.read(resume.notifier).state = ResumeModel();
        ref.read(educationList.notifier).state = [];
        ref.read(experienceList.notifier).state = [];
        ref.read(projectList.notifier).state = [];
        ref.read(skillsList.notifier).state = [];
      },
      child: Scaffold(
        appBar: AppBar(),
        body: screenList.firstWhere((element) => element.title == screen).screen,
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 10, bottom: MediaQuery.of(context).padding.bottom + 10),
          height: 80,
          color: Colors.black12,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: screenList
                .map((e) => GestureDetector(
                      onTap: () => ref.read(selectedScreen.notifier).state = e.title,
                      child: Container(
                        decoration: BoxDecoration(
                          color: screen == e.title ? Colors.black12 : Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              e.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14),
                            ),
                            Image.asset(
                              e.icon,
                              width: 23,
                              height: 23,
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
