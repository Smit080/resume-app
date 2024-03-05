import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_resume/controller/controller.dart';
import 'package:simple_resume/models/resume_model.dart';
import 'package:simple_resume/utils/navigation.dart';
import 'package:simple_resume/view/add_details_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<ResumeModel> resumeListData = ref.watch(resumeList);
    bool load = ref.watch(loading);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(currentIndex.notifier).state = resumeListData.length;
          ref.read(selectedScreen.notifier).state = 'Information';
          pushPage(context, const AddDetailsScreen());
        },
        child: const Icon(Icons.add),
      ),
      body: resumeListData.isEmpty
          ? Center(
              child: Text(load ? "Loading" : "Please add Resume"),
            )
          : ReorderableListView.builder(
              padding: commonPad(),
              itemCount: resumeListData.length,
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex = newIndex - 1;
                  }
                });
                final resume = ref.read(resumeList.notifier).state.removeAt(oldIndex);
                ref.read(resumeList.notifier).state.insert(newIndex, resume);
              },
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  key: ValueKey(index),
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12),
                    color: Colors.orange.shade50,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: resumeListData[index].info != null &&
                                    resumeListData[index].info!.image.isNotEmpty
                                ? FileImage(
                                    File(resumeListData[index].info!.image),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child: Text(resumeListData[index].info != null
                                ? resumeListData[index].info!.name
                                : "Name"),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(height: 0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              ref.read(selectedScreen.notifier).state = 'Information';
                              ref.read(currentIndex.notifier).state = index;

                              pushPage(
                                  context,
                                  AddDetailsScreen(
                                    data: resumeListData[index],
                                  ));
                            },
                            child: const Text("Edit"),
                          ),
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(controller.notifier)
                                  .removeResumeData(index: index, ref: ref);
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              /*child: ListView.builder(
                itemCount: resumeListData.length,
                padding: commonPad(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black12),
                      color: Colors.orange.shade50,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: resumeListData[index].info != null &&
                                      resumeListData[index].info!.image.isNotEmpty
                                  ? FileImage(
                                      File(resumeListData[index].info!.image),
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 200,
                              child: Text(resumeListData[index].info != null
                                  ? resumeListData[index].info!.name
                                  : "Name"),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(height: 0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                ref.read(selectedScreen.notifier).state = 'Information';
                                ref.read(currentIndex.notifier).state = index;

                                pushPage(
                                    context,
                                    AddDetailsScreen(
                                      data: resumeListData[index],
                                    ));
                              },
                              child: const Text("Edit"),
                            ),
                            TextButton(
                              onPressed: () {
                                ref
                                    .read(controller.notifier)
                                    .removeResumeData(index: index, ref: ref);
                              },
                              child: const Text("Delete"),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),*/
            ),
    );
  }
}
