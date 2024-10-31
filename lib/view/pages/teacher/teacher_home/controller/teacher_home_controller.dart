import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:stu_tech/controller/base/base_controller.dart';
import 'package:stu_tech/data/tools/strings/string.dart';

class TeacherHomeController extends BaseController{
  bool isLoading=false;
  Map<String, dynamic>completedTask={};
  Map<String, dynamic>task={};

  Future<void>setTask(Map<String,dynamic> task)async{
    completedTask=task;
  }
  Future<void>getTaskById()async{
    try{
      final userData=await FirebaseFirestore.instance.collection('tasks').doc(completedTask['task_id'])
          .get();
      if(userData.data() != null){
        task=userData.data()!;
      }

    }on FirebaseAuthException catch(error){
      Get.snackbar(Strings.appName.tr, error.code);
    }
  }
  Future<void>checkTask(String checkStatus)async{
    try{
      await FirebaseFirestore.instance.collection(completedTask['student_id'],).doc(completedTask['task_id'],)
          .update({
        'check_status':checkStatus,
        'task_id':completedTask['task_id'],
        'task_title':completedTask['task_title'],
        'student_id':completedTask['student_id'],
        'student_name':completedTask['student_name'],
        'created_date':completedTask['created_date'],
        'description':completedTask['description'],
        'task_files':completedTask['task_files'],
        'status':completedTask['status']
      });
      await FirebaseFirestore.instance.collection('completed_task',).doc(completedTask['task_id'])
          .update({
        'check_status':checkStatus,
        'task_id':completedTask['task_id'],
        'task_title':completedTask['task_title'],
        'student_id':completedTask['student_id'],
        'student_name':completedTask['student_name'],
        'created_date':completedTask['created_date'],
        'description':completedTask['description'],
        'task_files':completedTask['task_files'],
        'status':completedTask['status']
      });
    Get.back();
    }on FirebaseAuthException catch(error){
      Get.snackbar(Strings.appName.tr, error.code);
    }
  }
}