import 'dart:async';
import 'dart:io';

import 'package:stu_tech/data/tools/file_importer.dart';
import 'package:stu_tech/data/tools/styles/text_theme.dart';


class CustomButton extends StatelessWidget {
  final String title;
  final bool isPressed;
  final VoidCallback callback;
  final bool isColorChange;

  const CustomButton(
      {super.key,
      required this.title,
      required this.callback,
      this.isColorChange = false,
      this.isPressed = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isPressed ? null : callback(),
      child: Container(
        height: 52.h,
        width: 205.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12).r,
            color: !isColorChange ? ResColors.appColorSomeLight : ResColors.colorButton,
        ),
        child: Text(
          title,
          style: theme.displayLarge?.copyWith(color: ResColors.white, fontWeight: FontWeight.w700, fontSize: 16.sp),
        ),
      ),
    );
  }
}

Future<bool> alertExitApp(){
    Get.defaultDialog(
      backgroundColor:  ResColors.backgroundColor,
    title: Strings.appName,
    titleStyle: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
    middleText: Strings.areYouSure.tr,
    middleTextStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
    actions: [
      TextButton(onPressed: (){exit(0);}, child: Text(Strings.yes.tr, style: TextStyle(fontSize: 16.sp))),
      TextButton(onPressed: (){Get.back();}, child: Text(Strings.cancel.tr, style: TextStyle(fontSize: 16.sp))),
    ]
  );
    return Future.value(true);
}

