import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stu_tech/data/storage/app/locals/lang_prefs/language_prefs.dart';
import 'package:stu_tech/view/pages/application/controller/application_controller.dart';
import '../../../../../data/tools/file_importer.dart';

class ProfileController extends BaseController{
  bool isLoading=false;
  String name=Get.find<AuthHolder>().name;
  String email=Get.find<AuthHolder>().email;
  String surname=Get.find<AuthHolder>().surname;
  String universityName=Get.find<AuthHolder>().universityName;
  String workExperience=Get.find<AuthHolder>().workExperience;
  String role=Get.find<AuthHolder>().role;
  bool isTeacher=Get.find<ApplicationController>().isTeacher;
  String photoUrl= Get.find<AuthHolder>().photoUrl;


  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
    await Get.find<AuthHolder>().clearAuth();
    Get.find<AuthHolder>().isLoggedIn=false;
    Get.offAllNamed('/sign_in');
  }
  Future<void> updateProfile()async{
    try{
      await FirebaseFirestore.instance.collection('users').doc(Get.find<AuthHolder>().userId)
          .update(
          role=='TEACHER'?{
            'username':name,
            'surname':surname,
            'university_name':universityName,
            'work_experience':workExperience,
            'email':email,
            'role':role,
          }
              :{
            'username':name,
            'surname':surname,
            'university_name':universityName,
            'email':email,
            'role':role,
          }
      );
      print('UPDATEDDD');
      Get.find<AuthHolder>().name=name;
      Get.find<AuthHolder>().surname=surname;
      Get.find<AuthHolder>().universityName=universityName;
      if(Get.find<ProfileController>().isTeacher){
        Get.find<AuthHolder>().workExperience=workExperience;
      }
      update();
      Get.back();
    }on FirebaseAuthException catch(error){
      Get.snackbar(Strings.appName.tr, error.code);
    }
  }
}
 bool getLang(){
  LangPrefs langPrefs = LangPrefs();
   if(langPrefs.lang == 'uz'){
     return true;
   }else{
     return false;
   }
 }

