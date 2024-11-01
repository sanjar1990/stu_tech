
import 'package:stu_tech/view/pages/profile_options/edit_profile/widgets/edit_pr_widgets.dart';
import 'package:stu_tech/view/widgets/custom_widgets.dart';

import '../../../../data/tools/file_importer.dart';
import '../../../widgets/custom_app_bars.dart';
import '../profile/widgets/image_input.dart';

class EditProfileFieldsPage extends StatelessWidget {
  const EditProfileFieldsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
    builder: (controller) =>  Scaffold(
      backgroundColor: ResColors.backgroundColor,
      appBar:customWhiteAppBar(buttonColor: Colors.white),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 10.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24.h),
              EditPrWidgets(hintText: controller.name,onChanged: (value){
                controller.name=value;
              }, icon: Icons.person_2_outlined,fieldName: 'Name:',),
              EditPrWidgets(hintText: controller.surname,onChanged: (value){
                controller.surname=value;
              }, icon: Icons.person_2_outlined,fieldName: 'Surname:',),
              EditPrWidgets(hintText: controller.universityName,onChanged: (value){
                controller.universityName=value;
              }, icon: Icons.account_balance_outlined,fieldName: 'University name:',),
              if(controller.isTeacher)
              EditPrWidgets(hintText: controller.workExperience,onChanged: (value){
                controller.workExperience=value;
              },
                icon: Icons.add_chart_outlined,fieldName: 'Work Experience:', isWorkExperience: true,),
              SizedBox(height: 20),

                customButton(context, 'Update', ()async{
           await controller.updateProfile();

                }, buttonColor: ResColors.primaryElement)
            ],
          ),
        ),
      ),
    ),
    );
  }
}



