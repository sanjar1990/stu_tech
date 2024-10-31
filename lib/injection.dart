import 'package:stu_tech/data/storage/app/locals/lang_prefs/language_prefs.dart';
import 'package:stu_tech/data/tools/file_importer.dart';
import 'package:stu_tech/view/pages/application/controller/application_controller.dart';
import 'package:stu_tech/view/pages/auth/register/controller/register_controller.dart';
import 'package:stu_tech/view/pages/completed/controller/completed_controller.dart';
import 'package:stu_tech/view/pages/completed_detail/controller/completed_detail_controller.dart';
import 'package:stu_tech/view/pages/create_post/controller/create_post_controller.dart';
import 'package:stu_tech/view/pages/detail_page/controller/detail_page_controller.dart';
import 'package:stu_tech/view/pages/my_tasks/controller/my_tasks_controller.dart';
import 'package:stu_tech/view/pages/teacher/teacher_home/controller/teacher_home_controller.dart';
import 'data/server/api/api_service.dart';
import 'data/server/auth_interceptor.dart';
import 'data/storage/auth/auth_prefs.dart';

class DIService {
  static Future<void> init() async {

    //Controller

     Get.lazyPut<ApplicationController>(() => ApplicationController(), fenix: true);
     Get.lazyPut<CreatePostController>(() => CreatePostController(), fenix: true);
     Get.lazyPut<DetailPageController>(() => DetailPageController(), fenix: true);
     Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
     Get.lazyPut<RegisterController>(() => RegisterController(), fenix: true);
     Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
     Get.lazyPut<MyTaskController>(() => MyTaskController(), fenix: true);
     Get.lazyPut<CompletedController>(() => CompletedController(), fenix: true);
     Get.lazyPut<CompletedDetailController>(() => CompletedDetailController(), fenix: true);
     Get.lazyPut<TeacherHomeController>(() => TeacherHomeController(), fenix: true);

     Get.lazyPut<ApiService>(() => ApiService(Get.find<AuthInterceptor>()), fenix: true);
     Get.lazyPut<AuthInterceptor>(() => AuthInterceptor(Get.find<AuthHolder>()), fenix: true);
     Get.lazyPut<LangPrefs>(() => LangPrefs(), fenix: true);
     Get.lazyPut<AuthHolder>(() => AuthPrefs(), fenix: true);

  }
}



