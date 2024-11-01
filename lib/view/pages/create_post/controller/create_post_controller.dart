import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stu_tech/data/storage/auth/auth_holder.dart';
import 'package:stu_tech/view/pages/application/controller/application_controller.dart';
import 'package:stu_tech/view/pages/detail_page/controller/detail_page_controller.dart';
import 'package:stu_tech/view/pages/detail_page/detail_page.dart';
import '../../../../controller/base/base_controller.dart';
import '../../../../data/tools/service/connectivity_service/connection.dart';
import '../../../../data/tools/strings/string.dart';
import 'package:uuid/uuid.dart';

import '../../completed_detail/controller/completed_detail_controller.dart';

var uuid = Uuid();

class CreatePostController extends BaseController {
  bool isLoading = false;
  bool uploadFileLoading = false;
  String taskId='';
  String postTitle ='';
  String description = '';
  bool isUpdate=false;
  String createdTime='';
  Map<String, dynamic> selectedFiles={};
  Map<String, dynamic> uploadedFiles={};
  String fileTitle='No file selected';
  bool  titleIsEmpty=false;
  bool  descriptionIsEmpty=false;
  bool  filesEmpty=false;
  String teacherId='';
  Map<String, dynamic> taskUpdate={};
  @override
  Future<void> onInit() async {
    super.onInit();
    print('UPDATEEEEE:::: $isUpdate');

    if(!isUpdate){
      createdTime=DateFormat('HH:mm dd.MM.yyyy').format(DateTime.now());
      taskId=uuid.v4();
    }

  }


  Future<void>setIsUpdate(Map<String,dynamic> task)async{
    print('UPDATEEEEE:::: $isUpdate');
    print('TASKKKK:::: $taskUpdate');
    createdTime=task['created_date'];
    postTitle=task['title'];
    description=task['description'];
    teacherId=task['teacher_id'];
    taskId=task['task_id'];
    uploadedFiles=task['task_files'];
    isUpdate=true;
    taskUpdate=task;
  }
  void checkField(){
    if(postTitle.isEmpty){
      print('EMPTY');
      titleIsEmpty=true;
      update();
    }else{
      print('NOT EMPTY');
      titleIsEmpty=false;
      update();
    }
    if(description.isEmpty){
      descriptionIsEmpty=true;
      update();
    } else{
      descriptionIsEmpty=false;
      update();
    }
    if(uploadedFiles.isEmpty){
      filesEmpty=true;
      update();
    } else{
      filesEmpty=false;
      update();
    }
  }

  Future<void> createPost()async{
    // #check field completeness
    if (postTitle.isEmpty || description.isEmpty || uploadedFiles.isEmpty ) {
      Get.snackbar(Strings.appName.tr, Strings.requiredField.tr);
      return;
    }

    try{
      FirebaseFirestore.instance.collection('tasks').doc(taskId)
          .set({
        'task_id':taskId,
        'teacher_id':Get.find<AuthHolder>().userId,
        'created_date':createdTime,
        'title':postTitle,
        'description':description,
        'task_files':uploadedFiles,
      });
      await Get.find<ApplicationController>().setPageIndex(2);
         Get.offAllNamed('/');

    }on FirebaseAuthException catch(error){
      Get.snackbar(Strings.appName.tr, error.code);
    }
  }
  Future<void> uploadFile() async {
    uploadFileLoading = true;
    update();

    if (selectedFiles.isEmpty) {
      Get.snackbar(Strings.appName.tr, 'No file is selected');
      uploadFileLoading = false;
      update();
      return;
    }
    if (await CheckNet().checkInternet() == false) {
      Get.snackbar(Strings.appName.tr, Strings.noInternet.tr);
      uploadFileLoading = false;
      update();
      return;
    }
    try {
      for (var entry in selectedFiles.entries) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('files')
            .child(taskId)
            .child(entry.key);

        await storageRef.putFile(entry.value).whenComplete(() async {
          String fileUrl = await storageRef.getDownloadURL();
          print('FILE URL:::: $fileUrl');
          uploadedFiles[entry.key]=fileUrl;
        });
      }

      selectedFiles.clear();
      Get.snackbar(Strings.appName.tr, 'All files are uploaded');
      fileTitle='All files are uploaded';
     update();
      Get.back();
    } catch (e) {
      print('Error uploading files: $e');
      Get.snackbar(Strings.appName.tr, e.toString());
    } finally {
      uploadFileLoading = false;
      update();
    }
  }


  Future<void> updatePost()async{
    try{
      FirebaseFirestore.instance.collection('tasks').doc(taskId)
          .update({
        'task_id':taskId,
        'teacher_id':teacherId,
        'created_date':createdTime,
        'title':postTitle,
        'description':description,
        'task_files':uploadedFiles,
      });
      await Get.find<ApplicationController>().setPageIndex(2);
      Get.offAllNamed('/');
    }on FirebaseAuthException catch(error){
      Get.snackbar(Strings.appName.tr, error.code);
    }
  }
  Future<void> uploadAnswerFile() async {
    uploadFileLoading = true;
    update();

    if (selectedFiles.isEmpty) {
      Get.snackbar(Strings.appName.tr, 'No file is selected');
      uploadFileLoading = false;
      update();
      return;
    }
    if (await CheckNet().checkInternet() == false) {
      Get.snackbar(Strings.appName.tr, Strings.noInternet.tr);
      uploadFileLoading = false;
      update();
      return;
    }
    try {
      for (var entry in selectedFiles.entries) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('answer_files')
            .child(Get.find<DetailPageController>().task['task_id'])
            .child(Get.find<AuthHolder>().userId)
            .child(entry.key);

        await storageRef.putFile(entry.value);

        String fileUrl = await storageRef.getDownloadURL();
        print('FILE URL:::: $fileUrl');
        Get.find<DetailPageController>().uploadedFiles[entry.key]=fileUrl;
      }

      selectedFiles.clear();
      Get.snackbar(Strings.appName.tr, 'All files are uploaded');
      fileTitle='All files are uploaded';

      update();
      // Get.find<ApplicationController>().setPageIndex(1);
     Get.offNamed('/post_detail');

    } catch (e) {
      print('Error uploading files: $e');
      Get.snackbar(Strings.appName.tr, e.toString());
    } finally {
      uploadFileLoading = false;
      update();
    }
  }


  Future<void> uploadAnswerFileUpdate() async {
    uploadFileLoading = true;
    update();

    if (selectedFiles.isEmpty) {
      Get.snackbar(Strings.appName.tr, 'No file is selected');
      uploadFileLoading = false;
      update();
      return;
    }
    if (await CheckNet().checkInternet() == false) {
      Get.snackbar(Strings.appName.tr, Strings.noInternet.tr);
      uploadFileLoading = false;
      update();
      return;
    }
    try {
      for (var entry in selectedFiles.entries) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('answer_files')
            .child(Get.find<CompletedDetailController>().task['task_id'])
            .child(Get.find<AuthHolder>().userId)
            .child(entry.key);

        await storageRef.putFile(entry.value);

        String fileUrl = await storageRef.getDownloadURL();
        print('FILE URL:::: $fileUrl');
        Get.find<CompletedDetailController>().completedTask['task_files'][entry.key]=fileUrl;
      }
      Get.find<CompletedDetailController>().update();
      selectedFiles.clear();
      Get.snackbar(Strings.appName.tr, 'All files are uploaded');
      fileTitle='All files are uploaded';
      update();
      Get.back();

    } catch (e) {
      print('Error uploading files: $e');
      Get.snackbar(Strings.appName.tr, e.toString());
    } finally {
      uploadFileLoading = false;
      update();
    }
  }
}
