import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:stu_tech/view/pages/profile_options/profile/widgets/image_input.dart';
import 'package:stu_tech/view/pages/profile_options/profile/widgets/profile_info.dart';
import 'package:stu_tech/view/widgets/custom_widgets.dart';
import '../../../../data/tools/file_importer.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) => Scaffold(
        appBar: customAppBar(Strings.profile.tr, isProfilePage: true),
        backgroundColor: ResColors.backgroundColor,
        body:    controller.isLoading
            ? Center(
            child: CircularProgressIndicator(
              color: ResColors.primaryElement,
            ))
            : SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                // Padding(
                //   padding: EdgeInsets.all(16.r),
                //   child: ClipRRect(
                //       borderRadius: BorderRadius.circular(20.r),
                //       child: (controller.photoUrl.isNotEmpty)
                //           ? CachedNetworkImage(
                //         imageUrl: controller.photoUrl,
                //         placeholder: (context, url) =>
                //         const CircularProgressIndicator(
                //             strokeWidth: 2),
                //         errorWidget: (context, url, error) =>
                //             Image.network(
                //                 Get.find<AuthHolder>()
                //                     .photoUrl,
                //                 height: 120.h,
                //                 width: 120.w,
                //                 fit: BoxFit.fitWidth),
                //         height: 120.h,
                //         width: 120.h,
                //         fit: BoxFit.fitWidth,
                //       )
                //           : Image.asset(
                //           "assets/images/default_p_p.png",
                //           height: 120.h,
                //           width: 120.h,
                //           fit: BoxFit.fitWidth)),
                // ),
                ImageInput(imageUrl: controller.photoUrl),

                SizedBox(height: 20.w),
                ProfileInfo(title: 'Job:', subtitle: controller.role,icon: Icons.work_outline_outlined,),
                SizedBox(height: 15.h),
                ProfileInfo(title: 'Name:', subtitle: controller.name,icon: CupertinoIcons.person,),
                SizedBox(height: 15.h),
                ProfileInfo(title: 'Surname:', subtitle: controller.surname,icon: CupertinoIcons.person,),
                SizedBox(height: 15.h),
                ProfileInfo(title: 'Email', subtitle: controller.email,icon: Icons.email_outlined,),
                SizedBox(height: 15.h),
                ProfileInfo(title: 'University name', subtitle: controller.universityName,icon: Icons.account_balance_outlined,),
                SizedBox(height: 15.h),
                if(controller.isTeacher)
                ProfileInfo(title: 'Work Experience', subtitle: controller.workExperience,icon: Icons.add_chart_outlined,),
                SizedBox(height: 20.h),
                customButton(context, 'Edit profile', (){
                  Get.toNamed('/edit_profile');
                }, buttonColor: ResColors.primaryElement),
                SizedBox(height: 20.h),
                changeAppLanguage(controller),
                SizedBox(height: 16.h),

              ],
            ),
          ),
        ),
        // SafeArea(
        //   child: RefreshIndicator(
        //     onRefresh: () => controller.onRefresh(),
        //     child: controller.isLoading
        //         ?  Center(
        //             child: CircularProgressIndicator(
        //             color: ResColors.primaryElement,
        //           ))
        //         : SingleChildScrollView(
        //             child: Container(
        //               padding: EdgeInsets.symmetric(horizontal: 16),
        //               color: ResColors.primaryBackground,
        //               margin: EdgeInsets.all(16),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //
        //                 children: [
        //                   SizedBox(height: 10,),
        //                 Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     customText('Name:',),
        //                     customText(controller.name),
        //                   ],
        //                 ),
        //                   Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       customText('Email:',),
        //                       customText(controller.email),
        //                     ],
        //                   ),
        //
        //
        //                   SizedBox(height: 12.h),
        //                   changeAppLanguage(controller),
        //                   SizedBox(height: 16.h),
        //                 ],
        //               ),
        //             ),
        //           ),
        //   ),
        // ),
      ),
    );
  }
}

Future<bool> alertDeleteAccount() {
  Get.defaultDialog(
      backgroundColor: ResColors.backgroundColor,
      title: Strings.appName,
      titleStyle: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
      middleText: Strings.areYouSureToDelete.tr,
      middleTextStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
      actions: [
        TextButton(
            onPressed: () {
            },
            child: Text(Strings.yes.tr, style: TextStyle(fontSize: 16.sp))),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(Strings.cancel.tr, style: TextStyle(fontSize: 16.sp))),
      ]);
  return Future.value(true);
}
