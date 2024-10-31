import 'package:firebase_auth/firebase_auth.dart';
import 'package:stu_tech/data/tools/file_importer.dart';
import 'package:stu_tech/view/pages/auth/login/login.dart';
import 'package:stu_tech/view/pages/profile_options/profile/profile_page.dart';
import 'package:stu_tech/view/pages/start/splash/splash_page.dart';
import 'package:stu_tech/view/pages/teacher/teacher_home/teacher_home_page.dart';

Future<void> main() async {
  await setup();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize:  Size(MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child){
        return GetMaterialApp(
          title: 'stu_tech',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xff769A14),
              secondary: const Color(0xff769A14),
            ),
          ),
          translations: LangService(),
          locale: LangService.defaultLanguage(),
          fallbackLocale: LangService.fallbackLocale,
          debugShowCheckedModeBanner: false,
          // home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
          //   builder:(ctx, snapshot){
          //   if(snapshot.connectionState==ConnectionState.waiting){
          //     return SplashPage();
          //   }
          //   if(snapshot.hasData){
          //     print('TEACHERRRRR');
          //      return TeacherHomeScreen();
          //   }else{
          //     print('LOGINNNNN');
          //
          //     return LoginPage();
          //   }
          //   },),
          getPages: RouteHelper.routes,
          initialRoute: RouteHelper.getSplashPage(),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: ScrollConfiguration(
                behavior: const ScrollBehavior(),
                child: child ?? const Scaffold(),
              ),
            );
          },
        );
      },
    );
  }
}