import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stu_tech/controller/base/base_controller.dart';
import 'package:stu_tech/data/storage/auth/auth_holder.dart';
import 'package:stu_tech/view/pages/auth/login/login.dart';
import 'package:stu_tech/view/pages/teacher/teacher_home/teacher_home_page.dart';

class SplashController extends BaseController{
  @override
  void onInit() {
    super.onInit();
     Timer(const Duration(seconds:3),() {

       if(Get.find<AuthHolder>().isLoggedIn){
         Get.toNamed('/home');
       }else{
         Get.toNamed('/onboarding');
       }
     });
  }
}