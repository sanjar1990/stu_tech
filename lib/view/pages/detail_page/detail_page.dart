import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stu_tech/data/tools/styles/res_colors.dart';
import 'package:stu_tech/view/pages/application/controller/application_controller.dart';
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
  void delete(BuildContext context, String id) {

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: ResColors.primaryElement,
      content: Column(
        children: [
          Text("Do you want to delete?"),
          Row(children: [
            TextButton(onPressed: (){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              FirebaseFirestore.instance.collection('tasks').doc(id).delete();
              Get.back();
            }, child: Text('YES', style: TextStyle(
                color: Colors.white
            ),)),
            TextButton(onPressed: (){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }, child: Text('Cancel',style: TextStyle(
                color: Colors.white
            ),))
          ],)
        ],
      ),
      duration: const Duration(seconds: 4),

    ));
  }
  void update(Map<String, dynamic> task)async{
    CreatePostController controller=Get.find<CreatePostController>();
    await controller.setIsUpdate(task);
    // Get.find<ApplicationController>().setPageIndex(1);
    Get.toNamed('/create_post');
  }
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
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: ResColors.backgroundColor,
              foregroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              actions: [
                Get.find<ApplicationController>().isTeacher?
                Padding(
                  padding: EdgeInsets.only(top: 7.h, right: 15.w, bottom: 15.h),
                  child:    PopupMenuButton(
                    // constraints: BoxConstraints.expand(width: 110.w, height: 110.h),
                    child: Container(
                      width: 30.w,
                      height: 30.h,

                      margin: EdgeInsets.only(top: 4.w, right: 4.w),
                      child: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                              AssetImage('assets/icons/three_dot.png'),
                            )),
                      ),
                    ),
                    onSelected: (value) async {
                      if (value == "update") {
                        update(controller.task);
                      } else if (value == "delete") {
                        delete(context, controller.task['task_id']);
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry>[
                      PopupMenuItem(
                        value: "update",
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: Icon(Icons.edit, size: 20),
                            ),
                            Text(
                              Strings.updatePost.tr,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "delete",
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: Icon(Icons.delete_outline_outlined,
                                  size: 20),
                            ),
                            Text(
                              Strings.delete.tr,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // IconButton(
                  //     onPressed: () {
                  //
                  //     },
                  //     icon: Container(
                  //       child: Image.asset('/assets/icons/three_dot.png'),
                  //     )),
                ):Container(),
              ],
              flexibleSpace: Container(
                  width: 360.w,
                  decoration: Platform.isIOS
                      ? BoxDecoration(
                      color: ResColors.primaryElement,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24.r),
                          bottomRight: Radius.circular(24.r)))
                      :  BoxDecoration(color: ResColors.primaryElement),
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 40.h),
                      child: customText(controller.task['title'],
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          textColor: ResColors.white),
                    ),
                  )),
            ),
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
