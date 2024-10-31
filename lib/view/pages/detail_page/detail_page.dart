import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stu_tech/data/tools/styles/res_colors.dart';
import 'package:stu_tech/view/pages/application/controller/application_controller.dart';
import 'package:stu_tech/view/pages/create_post/widgets/file_upload.dart';
import 'package:stu_tech/view/pages/detail_page/widgets/detail_page_widgets.dart';
import 'package:stu_tech/view/widgets/custom_widgets.dart';
import 'package:stu_tech/view/widgets/file_upload/title_list.dart';

import '../../../data/tools/strings/string.dart';
import '../create_post/controller/create_post_controller.dart';
import 'controller/detail_page_controller.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        // Get.find<HomeController>().clearHome();
      },
      child: GetBuilder<DetailPageController>(
        init: DetailPageController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: ResColors.backgroundColor,
            appBar: customAppBar(controller.task['title']),
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
                            'Task status:',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            controller.isCompleted?"Task Completed":'New Task',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          getText(
                              title: 'Title',
                              content: controller.task['title']),
                          getText(
                              title: 'Created date',
                              content: controller.task['created_date']),
                          getText(
                              title: 'description',
                              content: controller.task['description']),
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
                          if (!Get.find<ApplicationController>().isTeacher)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                createAnswerDescription(context, (value) {
                                  controller.update();
                                  controller.description = value;
                                }),
                                Text(
                                  'Upload your answers:',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.find<CreatePostController>().uploadFileLoading=false;
                                    Get.toNamed('/file_upload');
                                  },
                                  child: Container(
                                    width: 70.w,
                                    height: 70.h,
                                    decoration: BoxDecoration(
                                        color: ResColors.white,
                                        border: Border.all(
                                            width: 1,
                                            color: controller.filesEmpty
                                                ? ResColors.emptyError
                                                : ResColors.primaryBackground)),
                                    margin: EdgeInsets.only(right: 7.w),
                                    child: Center(
                                      child: SizedBox(
                                        width: 24.w,
                                        height: 24.h,
                                        child: Image.asset(
                                            'assets/icons/plus_photo.png'),
                                      ),
                                    ),
                                  ),
                                ),
                                if (controller.uploadedFiles.isNotEmpty)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'My Answers',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          height: 50 +
                                              (50 *
                                                      controller
                                                          .uploadedFiles.length)
                                                  .toDouble(),
                                          width: double.maxFinite,
                                          child: ListView.builder(
                                              itemCount: controller
                                                  .uploadedFiles.length,
                                              itemBuilder: (ctx, index) {
                                                return TitleList(
                                                  isTask: false,
                                                  title: controller
                                                      .uploadedFiles.keys
                                                      .elementAt(index),
                                                  fileUrl: controller
                                                      .uploadedFiles.values
                                                      .elementAt(index),
                                                  index: index,
                                                );
                                              })),
                                    ],
                                  ),
                                SizedBox(
                                  height: 20,
                                ),
                                customButton(
                                  isLoading: controller.isLoading,
                                  buttonColor: ResColors.primaryElement,
                                  context,
                                  'Complete task',
                                  controller.isLoading
                                      ? () {}
                                      : () async {
                                    if (controller.isLoading) {
                                    } else {
                                      if(controller.isCompleted){
                                        Get.snackbar(Strings.appName.tr, 'You already completed Task');
                                      }else{
                                        controller.checkField();
                                        controller.completeTask();
                                      }

                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
