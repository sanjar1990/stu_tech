import 'package:get/get.dart';
import 'package:stu_tech/view/pages/application/application_page.dart';
import 'package:stu_tech/view/pages/completed_detail/completed_detail_page.dart';
import 'package:stu_tech/view/pages/create_post/create_post.dart';
import 'package:stu_tech/view/pages/create_post/widgets/file_upload.dart';
import 'package:stu_tech/view/pages/start/splash/splash_page.dart';
import 'package:stu_tech/view/pages/teacher/teacher_home/completed_task_info.dart';
import 'package:stu_tech/view/pages/teacher/teacher_home/teacher_home_page.dart';
import '../../view/pages/auth/login/login.dart';
import '../../view/pages/detail_page/detail_page.dart';



class RouteHelper {
  static const String initial = '/';
  static const String splashPage = '/splash_page';
  static const String signIn = '/sign_in';
  static const String signUp = '/sign_up';
  static const String teacherHome = '/teacher_home';
  static const String fileUpload = '/file_upload';
  static const String createPost = '/create_post';
  static const String postDetail = '/post_detail';
  static const String completedDetail = '/completed_detail';
  static const String completedTaskInfo = '/completed_task_info';



  static String getInitial() => initial;
  static String getSplashPage() => splashPage;
  static String getTeacherHome() => teacherHome;
  static String getSignIn() => signIn;
  static String getSignUp() => signUp;
  static String getCreatePost() => createPost;
  static String getFileUpload() => fileUpload;
  static String getPostDetail() => postDetail;
  static String getCompletedDetail() => completedDetail;
  static String getCompletedTaskInfo() => completedTaskInfo;




  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => const SplashPage()),
    GetPage(name: initial, page: () => const ApplicationPage()),
    GetPage(name: teacherHome, page: () => const TeacherHomePage()),
    GetPage(
        name: signIn,
        page: () =>  const LoginPage(),
        transition: Transition.fadeIn),

    GetPage(
      name: createPost,
      page: () =>  CreatePostPage(),
    ),
    GetPage(
      name: fileUpload,
      page: () => const FileUpload(),
    ),
    GetPage(
      name: postDetail,
      page: () => const DetailPage(),
    ),
    GetPage(
      name: completedDetail,
      page: () => const CompletedDetailPage(),
    ),
    GetPage(
      name: completedTaskInfo,
      page: () => const CompletedTaskInfo(),
    ),
  ];
}
