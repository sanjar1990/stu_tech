import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stu_tech/view/pages/completed_detail/controller/completed_detail_controller.dart';

import '../../../data/tools/styles/res_colors.dart';
import '../../widgets/custom_widgets.dart';
import '../../widgets/file_upload/title_list.dart';
import '../detail_page/widgets/detail_page_widgets.dart';

class CompletedDetailPage extends StatefulWidget {
  const CompletedDetailPage({super.key});

  @override
  State<CompletedDetailPage> createState() => _CompletedDetailPageState();
}

class _CompletedDetailPageState extends State<CompletedDetailPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompletedDetailController>(
        init: CompletedDetailController(),
        builder: (controller){
          return Scaffold(
            backgroundColor: ResColors.backgroundColor,
            appBar: customAppBar(controller.task['title']),
            body: controller.isLoading
                ? Center(
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
                      'Task title:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      controller.task['title'],
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    getText(
                        title: 'Task title:',
                        content: controller.task['title']),
                    getText(
                        title: 'Task Description',
                        content: controller.task['description']),
                    getText(
                        title: 'My description',
                        content: controller.completedTask['description']),
                    getText(
                        title: 'Task completed date',
                        content: controller.completedTask['created_date']),
                //Tasks
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
                    //Tasks
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Answer files:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            height: (30 * controller.completedTask.length)
                                .toDouble(),
                            width: double.maxFinite,
                            child: ListView.builder(
                                itemCount:
                                controller.completedTask['task_files'].length,
                                itemBuilder: (ctx, index) {
                                  return TitleList(
                                    isTask: true,
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

                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
