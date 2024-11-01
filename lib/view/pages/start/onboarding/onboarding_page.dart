import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stu_tech/data/tools/file_importer.dart';
import 'package:stu_tech/view/widgets/custom_widgets.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            
            customButton(context, "Start", (){
            Get.toNamed('/select_role');
            }, buttonColor: ResColors.primaryElement)
          ],
        ),
      ),
    );
  }
}
