import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:stu_tech/view/pages/application/controller/application_controller.dart';
import '../../../../data/tools/file_importer.dart';

class DetailPageController extends BaseController{
  bool uploadFileLoading = false;
  bool isLoading=false;
Map<String,dynamic> task={};
  Map<String, dynamic> uploadedFiles={};
  bool  filesEmpty=false;
  String description='';
  bool isCompleted=false;
  String completedTaskId='';

  @override
  Future<void> onInit() async {
    super.onInit();

  }
  void checkField(){
    if(uploadedFiles.isEmpty){
      filesEmpty=true;
      update();
    } else{
      filesEmpty=false;
      update();
    }
  }
  Future<void>setTask(Map<String,dynamic> task)async{
    this.task=task;
  }
  @override
  dispose() async {
    isCompleted=false;
    Get.forceAppUpdate();
    super.dispose();
  }
  Future<void>getStudentTask()async{
    try{
      final userData=await FirebaseFirestore.instance.collection(Get.find<AuthHolder>().userId).doc(task['task_id'])
          .get();
      if(userData.data() != null){
        completedTaskId=userData.data()!['task_id'];
      }
      if(task['task_id']==completedTaskId){
        isCompleted=true;
      }else{
        isCompleted=false;
      }
    }on FirebaseAuthException catch(error){
      Get.snackbar(Strings.appName.tr, error.code);
    }
  }
  Future<void> completeTask()async{
    String taskId=task['task_id'];
    // #check field completeness
    if ( uploadedFiles.isEmpty ) {
      Get.snackbar(Strings.appName.tr, 'Upload your answers');
      return;
    }
    String createdTime=DateFormat('HH:mm dd.MM.yyyy').format(DateTime.now());
    try{
      await FirebaseFirestore.instance.collection(Get.find<AuthHolder>().userId,).doc(taskId)
          .set({
        'check_status':'Unchecked',
        'task_id':taskId,
        'task_title':task['title'],
        'student_id':Get.find<AuthHolder>().userId,
        'created_date':createdTime,
        'description':description,
        'task_files':uploadedFiles,
        'status':'Completed'
      });
      await FirebaseFirestore.instance.collection('completed_task',).doc(taskId)
          .set({
        'check_status':'Unchecked',
        'task_id':taskId,
        'task_title':task['title'],
        'student_id':Get.find<AuthHolder>().userId,
        'student_name':Get.find<AuthHolder>().name,
        'created_date':createdTime,
        'description':description,
        'task_files':uploadedFiles,
        'status':'Completed'
      });
      uploadedFiles.clear();
     await Get.find<ApplicationController>().setPageIndex(2);
      Get.toNamed('/');
update();
      Get.snackbar(Strings.appName.tr, 'Task Completed');
    }on FirebaseAuthException catch(error){
      Get.snackbar(Strings.appName.tr, error.code);
    }
  }



}