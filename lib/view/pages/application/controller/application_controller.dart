import 'package:stu_tech/view/pages/completed/completed_page.dart';
import 'package:stu_tech/view/pages/my_tasks/my_tasks.dart';
import 'package:stu_tech/view/pages/student/student_home/student_home_page.dart';
import 'package:stu_tech/view/pages/teacher/teacher_home/teacher_home_page.dart';
import '../../../../data/tools/file_importer.dart';
import '../../create_post/create_post.dart';
import '../../profile_options/profile/profile_page.dart';


class ApplicationController extends BaseController {
  bool isLoading = false;

  bool isTeacher=false;
  int _pageIndex=0;
  int get pageIndex =>_pageIndex;
  bool loggedIn=Get.find<AuthHolder>().isLoggedIn;

  @override
  void onInit() {
    super.onInit();
    final String role=Get.find<AuthHolder>().role;
 if(role=='TEACHER'){
   isTeacher=true;
 }else{
   isTeacher=false;
 }
    _pageIndex=0;
     buildPage();
  }



  void setFalse(){
    loggedIn=false;
    setPageIndex(0);
    update();
  }

  Widget buildPage()  {
    List<Widget> widgets=[];
    if(isTeacher){
      widgets= [
        const TeacherHomePage(),
        const CreatePostPage(),
        const MyTasks(),
        const ProfilePage(),
      ] ;
    }
    else{
      widgets=[
        const StudentHomePage(),
        const MyTasks(),
        const CompletedPage(),
        const ProfilePage(),
      ];
    }
    return widgets[_pageIndex];
  }

  Future<void> setPageIndex(int index) async{
    _pageIndex=index;
    update();
  }
}
