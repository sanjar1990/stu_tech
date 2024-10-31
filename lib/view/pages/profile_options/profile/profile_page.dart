import 'package:stu_tech/view/widgets/custom_widgets.dart';
import '../../../../data/tools/file_importer.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) => Scaffold(
        appBar: customAppBar(Strings.profile.tr, isProfilePage: true),
        backgroundColor: ResColors.backgroundColor,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => controller.onRefresh(),
            child: controller.isLoading
                ?  Center(
                    child: CircularProgressIndicator(
                    color: ResColors.primaryElement,
                  ))
                : SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      color: ResColors.primaryBackground,
                      margin: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      
                        children: [
                          SizedBox(height: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText('Name:',),
                            customText(controller.name),
                          ],
                        ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText('Email:',),
                              customText(controller.email),
                            ],
                          ),
                      
                      
                          SizedBox(height: 12.h),
                          changeAppLanguage(controller),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

Future<bool> alertDeleteAccount() {
  Get.defaultDialog(
      backgroundColor: ResColors.backgroundColor,
      title: Strings.appName,
      titleStyle: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
      middleText: Strings.areYouSureToDelete.tr,
      middleTextStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
      actions: [
        TextButton(
            onPressed: () {
            },
            child: Text(Strings.yes.tr, style: TextStyle(fontSize: 16.sp))),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(Strings.cancel.tr, style: TextStyle(fontSize: 16.sp))),
      ]);
  return Future.value(true);
}
