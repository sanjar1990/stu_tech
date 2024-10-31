import 'package:google_fonts/google_fonts.dart';
import 'package:stu_tech/data/tools/file_importer.dart';
import 'package:stu_tech/view/pages/application/controller/application_controller.dart';
import 'package:stu_tech/view/pages/application/widgets/application_widgets.dart';


class ApplicationPage extends StatelessWidget {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ApplicationController>(
      init: ApplicationController(),
      builder: (controller){
        return Scaffold(
          backgroundColor: ResColors.backgroundColor,
          body: WillPopScope(
              onWillPop: alertExitApp,
          child: controller.buildPage()),
          bottomNavigationBar: Container(
            width:double.maxFinite,
            height: 85.h,
            decoration: BoxDecoration(
                color: ResColors.searchColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 1,
                    spreadRadius: 1,
                  )
                ]
            ),
            child: BottomNavigationBar(
              backgroundColor: ResColors.primaryBackground,
              elevation: 0,
              onTap: (value){
                controller.setPageIndex(value);
              },
              currentIndex: controller.pageIndex,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: ResColors.primaryElement,
              unselectedItemColor: ResColors.primaryFourthElementText,
              unselectedLabelStyle: GoogleFonts.roboto(
              fontSize: 10.sp,
                color: ResColors.bottomNavUnselectColor
              ),
              selectedLabelStyle: GoogleFonts.roboto(
                  fontSize: 10.sp,
                  color: ResColors.primaryElement
              ),
              items: controller.isTeacher ?[
                item(Strings.home.tr, 'home'),
                item(Strings.add.tr, 'add'),
                item('AllTasks', 'task'),
                item(Strings.profile.tr, 'profile'),
              ]:[
                item(Strings.home.tr, 'home'),
                item('Tasks', 'task'),
                item('Completed', 'completed-task'),
                item(Strings.profile.tr, 'profile'),
              ]
            ),
          ),
        );
      },
    );

  }
}
