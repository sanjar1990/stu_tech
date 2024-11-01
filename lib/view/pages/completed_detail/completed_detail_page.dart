import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stu_tech/view/pages/completed_detail/controller/completed_detail_controller.dart';
import 'package:stu_tech/view/pages/create_post/widgets/file_upload.dart';

import '../../../data/storage/auth/auth_holder.dart';
import '../../../data/tools/strings/string.dart';
import '../../../data/tools/styles/res_colors.dart';
import '../../widgets/custom_widgets.dart';
import '../../widgets/file_upload/title_list.dart';
import '../application/controller/application_controller.dart';
import '../create_post/controller/create_post_controller.dart';
import '../detail_page/widgets/detail_page_widgets.dart';

class CompletedDetailPage extends StatefulWidget {
  const CompletedDetailPage({super.key});

  @override
  State<CompletedDetailPage> createState() => _CompletedDetailPageState();
}

class _CompletedDetailPageState extends State<CompletedDetailPage> {
  void delete(BuildContext context, String id) {

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: ResColors.primaryElement,
      content: Column(
        children: [
          Text("Do you want to delete?"),
          Row(children: [
            TextButton(onPressed: (){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              FirebaseFirestore.instance.collection(Get.find<AuthHolder>().userId,).doc(id).delete();
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
    CompletedDetailController controller=Get.find<CompletedDetailController>();
    if(controller.completedTask['check_status']=='Unchecked'){
      controller.isUpdateCompletedTask=true;
      controller.updateDescription=controller.completedTask['description'];
      controller.update();
    }else{
      Get.snackbar(Strings.appName.tr, 'You can not update your Task');
    }

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompletedDetailController>(
        init: CompletedDetailController(),
        builder: (controller){
          return Scaffold(
            backgroundColor: ResColors.backgroundColor,
            appBar:  AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: ResColors.backgroundColor,
            foregroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            actions: [
              !Get.find<ApplicationController>().isTeacher?
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
                      print('Task id:::${controller.taskId}');
                              delete(context, controller.taskId);
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

                    SizedBox(
                      height: 20,
                    ),
                    getText(
                        title: 'Task title',
                        content: controller.task['title']),
                    getText(
                        title: 'Task Description',
                        content: controller.task['description']),
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
                    //Answers
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          !controller.isUpdateCompletedTask? Column(
                          children: [
                            Divider(thickness: 2, indent: 3,endIndent: 3, color: ResColors.borderColor,),
                            getText(
                                title: 'Check Status',
                                content: controller.completedTask['check_status']),
                            getText(
                                title: 'My Description',
                                content: controller.completedTask['description']),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Answer files:',
                              style: TextStyle(fontSize: 16),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                height: (20 * controller.completedTask.length)
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
                        )
                          :Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Container(
                          height: 190.h,
                          margin: EdgeInsets.only(top: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(Strings.description.tr,),
                              Container(
                                // width: 328.w,
                                  height: 140.h,
                                  margin: EdgeInsets.only(top: 10.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4.r),
                                    border: Border.all(
                                        width: 1,
                                        color: ResColors.borderColor),
                                  ),
                                  child: TextFormField(
                                    textCapitalization: TextCapitalization.sentences,
                                    // controller: controller,
                                    minLines: 6,

                                    // any number you need (It works as the rows for the textarea)
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,

                                    onChanged: (value){
                                      controller.updateDescription=value;
                                    },
                                    onTapOutside: (value){
                                      FocusScope.of(context).requestFocus( FocusNode());
                                    },
                                    decoration:  InputDecoration(
                                      hintText:controller.completedTask['description'],
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent),
                                      ),
                                      disabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent),
                                      ),
                                    ),

                                    style: TextStyle(
                                        color: ResColors.primaryText,
                                        fontFamily: 'Avenir',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.sp),
                                    autocorrect: false,
                                  )),
                            ],
                          ),
                        ),

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
                                Get.to(FileUpload(isUpdateAnswer: true,));
                              },
                              child: Container(
                                width: 70.w,
                                height: 70.h,
                                decoration: BoxDecoration(
                                    color: ResColors.white,
                                    border: Border.all(
                                        width: 1,
                                        color: ResColors.primaryBackground)),
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
                            if (controller.completedTask['task_files']!=null)
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
                                              controller.completedTask['task_files'].length)
                                              .toDouble(),
                                      width: double.maxFinite,
                                      child: ListView.builder(
                                          itemCount: controller.completedTask['task_files'].length,
                                          itemBuilder: (ctx, index) {
                                            return Stack(
                                              children: [

                                                TitleList(
                                                  isTask: false,
                                                  title: controller.completedTask['task_files'].keys
                                                      .elementAt(index),
                                                  fileUrl: controller.completedTask['task_files'].values
                                                      .elementAt(index),
                                                  index: index,
                                                ),
                                                Positioned(
                                                    left:10,
                                                    top:8,
                                                    child: IconButton(
                                                      icon: Container(
                                                        color:Colors.white,
                                                          width: 40,
                                                          height:40,
                                                          child: Icon(Icons.delete_outline,size: 25,)), onPressed: () {

                                                        Map<String, dynamic> files= controller.completedTask['task_files'];
                                                        files.remove(controller.completedTask['task_files'].keys.elementAt(index));
                                                      controller.update();
                                                    } ,)),
                                              ],
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
                              'Update task',
                              controller.isLoading
                                  ? () {}
                                  : () async {
                                if (controller.isLoading) {

                                } else {
                    controller.updateAnswer();
                                }
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )

                      ],
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
