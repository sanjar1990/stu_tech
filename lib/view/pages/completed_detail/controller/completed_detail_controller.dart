import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:stu_tech/controller/base/base_controller.dart';

import '../../../../data/tools/strings/string.dart';

class CompletedDetailController extends BaseController{
  bool isLoading=false;
  Map<String,dynamic>task={};
  Map<String,dynamic>completedTask={};
  String taskId='';
  Future<void>setTask(Map<String,dynamic> task)async{
    completedTask=task;
    taskId=task['task_id'];
  }
  Future<void>getTask()async{
    try{
      final userData=await FirebaseFirestore.instance.collection('tasks').doc(taskId)
          .get();
    if(userData.data()!=null){
      task=userData.data()!;
    }
    }on FirebaseAuthException catch(error){
      Get.snackbar(Strings.appName.tr, error.code);
    }
  }

}