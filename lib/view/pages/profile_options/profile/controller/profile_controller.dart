import 'package:firebase_auth/firebase_auth.dart';
import 'package:stu_tech/data/storage/app/locals/lang_prefs/language_prefs.dart';
import '../../../../../data/tools/file_importer.dart';

class ProfileController extends BaseController{
  bool isLoading=false;
  String name=Get.find<AuthHolder>().name;
  String email=Get.find<AuthHolder>().email;
  String photoUrl= Get.find<AuthHolder>().photoUrl;

  Future<void> onRefresh() async {
    Future.delayed(const Duration(seconds: 1));
    name=Get.find<AuthHolder>().name;
    photoUrl= Get.find<AuthHolder>().photoUrl;
    update();
  }



  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
    await Get.find<AuthHolder>().clearAuth();
    Get.find<AuthHolder>().isLoggedIn=false;
    Get.offAllNamed('/sign_in');
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

