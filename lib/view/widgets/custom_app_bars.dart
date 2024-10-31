import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


AppBar customWhiteAppBar({Color buttonColor=Colors.white}){
  return AppBar(
    backgroundColor: buttonColor,
    surfaceTintColor: Colors.white,
    leadingWidth: 68.w,
    leading: GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Center(
        child: SizedBox(
            width: 28.w,
            height: 28.h,
            child: Platform.isIOS ? Image.asset('assets/icons/back_white.png'):Image.asset('assets/icons/back_white_android.png')),
      ),
    ),
  );
}

