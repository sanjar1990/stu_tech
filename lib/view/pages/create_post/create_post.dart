import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stu_tech/view/widgets/file_upload/check_permision.dart';
import 'package:stu_tech/view/pages/create_post/controller/create_post_controller.dart';
import 'package:stu_tech/view/pages/create_post/widgets/create_post_widgets.dart';
import 'package:stu_tech/view/pages/create_post/widgets/date_picker.dart';
import 'package:stu_tech/view/widgets/custom_widgets.dart';
import 'package:stu_tech/view/widgets/file_upload/title_list.dart';
import '../../../data/tools/strings/string.dart';
import '../../../data/tools/styles/res_colors.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  bool isPermission = false;
  var checkAllPermission = CheckPermission();

  checkPermission() async {
    var permission = await checkAllPermission.isStoragePermission();
    if (permission) {
      setState(() {
        isPermission = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ResColors.backgroundColor,
        appBar: customAppBar(Strings.createPost.tr),
        body: GetBuilder<CreatePostController>(
          init: CreatePostController(),
          builder: (controller) => Container(
            margin: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 14.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  createTitle((value) {
                    controller.postTitle = value;
                  }, controller, context),
                  createPostDescription(controller, context, (value) {
                    controller.update();
                    controller.description = value;
                  }),
                  DatePickerCustom(
                    controller: controller,
                  ),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: 20.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Select file:'),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.uploadFileLoading=false;
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
                                child:
                                    Image.asset('assets/icons/plus_photo.png'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (controller.uploadedFiles.isNotEmpty)
                    Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        height: 300.h,
                        width: double.maxFinite,
                        child: isPermission
                            ? ListView.builder(
                                itemCount: controller.uploadedFiles.length,
                                itemBuilder: (ctx, index) {
                                  return TitleList(
                                    isTask: true,
                                    title: controller.uploadedFiles.keys
                                        .elementAt(index),
                                    fileUrl: controller.uploadedFiles.values
                                        .elementAt(index),
                                    index: index,
                                  );
                                })
                            : TextButton(
                                onPressed: () {
                                  checkPermission();
                                },
                                child: Text('Permission issue'))),
                  SizedBox(
                    height: 16.h,
                  ),
                  customButton(
                      buttonColor: controller.isLoading
                          ? ResColors.primaryElementLight
                          : ResColors.primaryElement,
                      context,
                      controller.isUpdate
                          ? Strings.updatePost.tr
                          : Strings.createPost.tr, () {
                    if (controller.isLoading) {
                    } else {
                      if (controller.isUpdate) {
                        controller.updatePost();
                      } else {
                        controller.checkField();
                        controller.createPost();
                      }
                      controller.update();
                    }
                  }, isLoading: controller.isLoading),
                  SizedBox(
                    height: 24.h,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
