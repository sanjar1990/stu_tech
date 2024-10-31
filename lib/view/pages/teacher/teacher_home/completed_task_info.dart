import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stu_tech/data/tools/styles/res_colors.dart';
import 'package:stu_tech/view/pages/detail_page/widgets/detail_page_widgets.dart';
import 'package:stu_tech/view/pages/teacher/teacher_home/controller/teacher_home_controller.dart';
import 'package:stu_tech/view/widgets/custom_widgets.dart';
import 'package:stu_tech/view/widgets/file_upload/title_list.dart';

class CompletedTaskInfo extends StatefulWidget {
  const CompletedTaskInfo({super.key});

  @override
  State<CompletedTaskInfo> createState() => _CompletedTaskInfoState();
}

class _CompletedTaskInfoState extends State<CompletedTaskInfo> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeacherHomeController>(
        init: TeacherHomeController(),
        builder: (controller){
          return Scaffold(
            backgroundColor: ResColors.backgroundColor,
            appBar: customAppBar(controller.completedTask['task_title']),
            body: controller.isLoading
                ?  Center(
                child: CircularProgressIndicator(
                  color: ResColors.primaryElement,
                ))
                : Container(
              margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Student name:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                   controller.completedTask['student_name'],
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    getText(
                        title: 'Task Title',
                        content: controller.completedTask['task_title']),
                    getText(
                        title: 'Task description',
                        content: controller.task['description']),
                    getText(
                        title: 'Task Created date',
                        content: controller.task['created_date']),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Task files:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            height: (30 * controller.task.length)
                                .toDouble(),
                            width: double.maxFinite,
                            child: ListView.builder(
                                itemCount:
                                controller.task['task_files'].length,
                                itemBuilder: (ctx, index) {
                                  return TitleList(
                                    isTask: true,
                                    title: controller
                                        .task['task_files'].keys
                                        .elementAt(index),
                                    fileUrl: controller
                                        .task['task_files'].values
                                        .elementAt(index),
                                    index: index,
                                  );
                                })),
                      ],
                    ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Divider(
                          thickness: 1,
                          color: ResColors.borderColor,
                          indent: 2,
                          endIndent: 2,
                        ),
                            Container(
                              color: ResColors.primaryBackground,
                              padding: EdgeInsets.only(
                                  top: 16
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  getText(
                                      title: 'Answer description',
                                      content: controller.completedTask['description']),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Student Answers',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      height: 50 +
                                          (50 *
                                              controller
                                                  .completedTask['task_files'].length)
                                              .toDouble(),
                                      width: double.maxFinite,
                                      child: ListView.builder(
                                          itemCount: controller
                                              .completedTask['task_files'].length,
                                          itemBuilder: (ctx, index) {
                                            return TitleList(
                                              isTask: false,
                                              title: controller
                                                  .completedTask['task_files'].keys
                                                  .elementAt(index),
                                              fileUrl: controller
                                                  .completedTask['task_files'].values
                                                  .elementAt(index),
                                              index: index,
                                            );
                                          })),
                                ],
                              ),
                            ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),

                    Container(
                      child: Column(
                        children: [
                          customButton(context, 'Passed', ()async{
                            await controller.checkTask('PASSED');
                          }, buttonColor: ResColors.primaryElement),
                          SizedBox(
                            height: 20,
                          ),
                          customButton(context, 'Failed', ()async{
                            await controller.checkTask('FAILED');
                          }, buttonColor: ResColors.primaryElement),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
