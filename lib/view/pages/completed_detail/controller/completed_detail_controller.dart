import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:stu_tech/controller/base/base_controller.dart';

import '../../../../data/storage/auth/auth_holder.dart';
import '../../../../data/tools/strings/string.dart';
import '../../application/controller/application_controller.dart';

class CompletedDetailController extends BaseController{
  bool isLoading=false;
  Map<String,dynamic>task={};
  Map<String,dynamic>completedTask={};
  Map<String,dynamic>updatedFiles={};
  bool isUpdateCompletedTask=false;
  String updateDescription='';
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

  Future<void> updateAnswer()async{
    print('UPDATE ANSWER');
    String taskId=completedTask['task_id'];
    String createdTime=DateFormat('HH:mm dd.MM.yyyy').format(DateTime.now());
    try{
      await FirebaseFirestore.instance.collection(Get.find<AuthHolder>().userId,).doc(taskId)
          .update({
        'check_status':'Unchecked',
        'task_id':taskId,
        'task_title':completedTask['task_title'],
        'student_id':Get.find<AuthHolder>().userId,
        'created_date':createdTime,
        'description':updateDescription,
        'task_files':completedTask['task_files'],
        'status':'Completed'
      });
      await FirebaseFirestore.instance.collection('completed_task',).doc(taskId)
          .update({
        'check_status':'Unchecked',
        'task_id':taskId,
        'task_title':completedTask['task_title'],
        'student_id':Get.find<AuthHolder>().userId,
        'student_name':Get.find<AuthHolder>().name,
        'created_date':createdTime,
        'description':updateDescription,
        'task_files':completedTask['task_files'],
        'status':'Completed'
      });
        isUpdateCompletedTask=false;
      await Get.find<ApplicationController>().setPageIndex(2);
      Get.toNamed('/');
      update();
      Get.snackbar(Strings.appName.tr, 'Task Completed');
    }on FirebaseAuthException catch(error){
      Get.snackbar(Strings.appName.tr, error.code);
    }
  }

}