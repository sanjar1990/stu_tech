import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stu_tech/view/pages/teacher/teacher_home/controller/teacher_home_controller.dart';
import 'package:stu_tech/view/widgets/custom_widgets.dart';

import '../../detail_page/controller/detail_page_controller.dart';

class TeacherHomePage extends StatelessWidget {
  const TeacherHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeacherHomeController>(
        init: TeacherHomeController(),
        builder: (controller) {
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('completed_task')
                  .snapshots(),
              builder: (ctx, userSnapshots) {
                if (userSnapshots.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!userSnapshots.hasData ||
                    userSnapshots.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No tasks found!'),
                  );
                }
                if (userSnapshots.hasError) {
                  return Center(
                    child: Text(userSnapshots.error.toString()),
                  );
                }
                final loadedStudent = userSnapshots.data!.docs;
                return Scaffold(
                  appBar: customAppBar('Completed Tasks'),
                  body: Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: ListView.builder(
                        itemCount: loadedStudent.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 10,
                            shadowColor: Colors.grey.shade100,
                            child: ListTile(
                              onTap: () async {
                                await   Get.find<TeacherHomeController>().setTask(loadedStudent[index].data());
                                await   Get.find<TeacherHomeController>().getTaskById();
                                Get.toNamed('/completed_task_info');
                              },
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Check status:'),
                                  customText( loadedStudent[index].data()['check_status']),
                                ],
                              ),
                              title: Column(
                                children: [
                                  customText(
                                      loadedStudent[index].data()['student_name']),
                                  customText(loadedStudent[index]
                                      .data()['task_title']),
                                ],
                              ),
                              trailing: Text(
                                  loadedStudent[index].data()['created_date']),
                            ),
                          );
                        }),
                  ),
                );
              });
        });
  }
}
