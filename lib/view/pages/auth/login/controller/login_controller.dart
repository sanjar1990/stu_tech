import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stu_tech/data/tools/file_importer.dart';


class LoginController extends BaseController {
  final _firebase=FirebaseAuth.instance;

  bool isLoading = false;
  bool isObscured = true;
  bool emptyEmail = false;
  bool emptyPassword = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginController();
  bool isFormFilled=false;

  @override
  dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void setObscure(bool obscureValue){
    isObscured = obscureValue;
    update();
  }
  Future<void> login() async {
    String password = passwordController.text.trim();
    String email = emailController.text.trim();
    //#check internet connectivity
    if (await CheckNet().checkInternet() == false) {
      Get.snackbar(Strings.appName.tr, Strings.noInternet.tr);
      return;
    }
    //#check field completeness
    if( email.isEmpty){
      emptyEmail = true;
      update();
      return;
    }else{
      emptyEmail = false;
      update();
    }
    if(password.isEmpty){
      emptyPassword = true;
      update();
      return;
    }else{
      emptyPassword = false;
      update();
    }
    try{
      final userCredentials=await  _firebase.signInWithEmailAndPassword(email: email, password: password);
      final userData=await FirebaseFirestore.instance.collection('users').doc(userCredentials.user!.uid)
     .get();
      Get.find<AuthHolder>().isLoggedIn=true;
      Get.find<AuthHolder>().userId=userCredentials.user!.uid;
      Get.find<AuthHolder>().role=userData.data()!['role'];
      Get.find<AuthHolder>().name=userData.data()!['username'];
      Get.find<AuthHolder>().email=userData.data()!['email'];
       Get.find<AuthHolder>().photoUrl=userData.data()?['image_url']??'';

      // Get.find<AuthHolder>().authToken=userCredentials.credential!.accessToken??'';
      Get.offAllNamed('/');

      print('USER::::$userCredentials');
    }on FirebaseAuthException catch(error){
      Get.snackbar(Strings.appName.tr, error.code);
    }

    // Get.find<AuthHolder>().name=content.data?.name??'';
    // Get.find<AuthHolder>().phone=content.data?.phone??'';
    // Get.find<AuthHolder>().photoUrl=content.data?.photo?.url??"";
    // Get.find<AuthHolder>().userId=content.data?.id??'';
    // Get.find<AuthHolder>().roleList=content.data?.roles??[];
    // Get.find<AuthHolder>().notificationValue=content.data?.notification??true;
    // Get.find<AuthHolder>().supportChatId=
    // !Get.find<AuthHolder>().roleList.contains(RoleList.ROLE_ADMIN.name)?Get.find<AuthHolder>().userId:"";
    // Get.find<HomeController>().onRefresh();
    // if(content.data!=null){
    //   bool isAdmin=content.data!.roles!.contains(RoleList.ROLE_ADMIN.name);
    //   Get.find<ApplicationController>().setIsAdmin(isAdmin);
    //   Get.find<ApplicationController>().setPageIndex(0);
    // }
    // Get.offAllNamed('/');
  }
}