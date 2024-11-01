import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stu_tech/data/tools/file_importer.dart';
import 'package:stu_tech/view/pages/auth/register/controller/register_controller.dart';
import 'package:stu_tech/view/pages/start/onboarding/widgets/select_role_button.dart';
import 'package:stu_tech/view/widgets/custom_widgets.dart';

class SelectRolePage extends StatelessWidget {
  const SelectRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (controller){
          return Scaffold(
            body: SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 102.h),
                    child: Image.asset("assets/icons/edu_icon.png",
                        height: 220.h),
                  ),
                 Column(
                   children: [
                     SelectRoleButton(func: () {
                       controller.isTeacherSelected=true;
                       controller.isStudentSelected=false;
                       controller.selectedRole='TEACHER';
                       controller.update();
                     }, title: 'TEACHER',isSelected: controller.isTeacherSelected,),
                     SizedBox(height: 20,),
                     SelectRoleButton(func: () {
                       controller.isStudentSelected=true;
                       controller.isTeacherSelected=false;
                       controller.selectedRole='STUDENT';
                       controller.update();
                     }, title: 'STUDENT',isSelected: controller.isStudentSelected,),
                   ],
                 ),

                  customButton(context, "Go", (){
                    Get.toNamed('/sign_up');
                  }, buttonColor: ResColors.primaryElement)
                ],
              ),
            ),
          );
        }) ;

  }
}
