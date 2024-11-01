import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stu_tech/view/pages/application/controller/application_controller.dart';
import '../../../../../data/tools/file_importer.dart';

class RegisterController extends BaseController{
  bool isLoading = false;
  bool isObscured = true;
  bool isObscured2 = true;
  bool isTeacherSelected=false;
  bool isStudentSelected=false;
  final _firebase=FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isAllSelected=false;
  String signature='';
  //checking fields
  bool emptyName = false;
  bool emptyEmail = false;
  bool passwordNotValid = false;
  bool confirmPasswordNotValid = false;
  List<String>roles=['TEACHER', 'STUDENT'];
  String selectedRole='';
  @override
  dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  void setObscure(bool obscureValue){
    isObscured = obscureValue;
    update();
  }
  void checkIsAllSelected(){
    if(selectedRole.isNotEmpty && nameController.text.trim().isNotEmpty
    && emailController.text.trim().isNotEmpty && passwordController.text.trim().length>=6
    && confirmPasswordController.text.trim().length>=6){
      isAllSelected=true;
    }else{
      isAllSelected=false;
    }
  }
  Future<void> registration() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (await CheckNet().checkInternet() == false) {
      Get.snackbar(Strings.appName.tr, Strings.noInternet.tr);
      return;
    }
    if(name.isEmpty){
      emptyName = true;
      update();
      return;
    }else{
      emptyName = false;
      update();
    }
    if( email.isEmpty){
      emptyEmail = true;
      update();
      return;
    } else{
      emptyEmail = false;
      update();
    }
    if(password.length<6){
      Get.snackbar(Strings.appName.tr, Strings.enterCharacter.tr);
      passwordNotValid = true;
      update();
      return;
    }else{
      passwordNotValid = false;
      update();
    }
    if(confirmPassword.isEmpty || password != confirmPassword){
      confirmPasswordNotValid = true;
      update();
      return;
    }else{
      confirmPasswordNotValid = false;
      update();
    }
    try{
    final userCredentials=await  _firebase.createUserWithEmailAndPassword(email: email, password: password);

    FirebaseFirestore.instance.collection('users').doc(userCredentials.user!.uid)
        .set(
        selectedRole=='TEACHER'?{
      'username':name,
      'surname':'',
      'university_name':'',
      'work_experience':'',
      'email':email,
      'role':selectedRole,
    }
    :{
          'username':name,
          'surname':'',
          'university_name':'',
          'email':email,
          'role':selectedRole,
        }
    );
    Get.find<AuthHolder>().isLoggedIn=true;
    Get.find<AuthHolder>().name=name;
    Get.find<AuthHolder>().email=email;
    Get.find<AuthHolder>().role=selectedRole;
    Get.find<AuthHolder>().userId=userCredentials.user!.uid;
    Get.find<ApplicationController>().isTeacher=selectedRole=='TEACHER';

    Get.offAllNamed('/');
    }on FirebaseAuthException catch(error){
      Get.snackbar(Strings.appName.tr, error.code);
    }


  }
}
