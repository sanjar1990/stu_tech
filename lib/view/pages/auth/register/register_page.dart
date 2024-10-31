import 'package:stu_tech/view/pages/auth/register/widgets/register_widgets.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../../data/tools/file_importer.dart';
import '../../../widgets/custom_app_bars.dart';
import '../../../widgets/custom_widgets.dart';
import 'controller/register_controller.dart';

class RegisterPage extends StatelessWidget {
   const RegisterPage({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetBuilder(
        init: RegisterController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      customWhiteAppBar(),
                      Padding(
                        padding: EdgeInsets.only(top: 26.h),
                        child: Image.asset("assets/icons/edu_icon.png", height: 110.h),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 24.h),
                        child: Text(
                          Strings.signUp.tr,
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                      selectRole(controller,MediaQuery.of(context).size.width - 60,),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: size.width - 60,
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.name,
                          style: const TextStyle(color: ResColors.textColor),
                          controller: controller.nameController,
                          onChanged: (value){
                            controller.checkIsAllSelected();
                          },
                          decoration: InputDecoration(
                              counterText: '',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.r),
                                borderSide: BorderSide(
                                  color: (controller.emptyName)?Colors.red:ResColors.primaryGrey
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.r),
                                borderSide: BorderSide(
                                  color: (controller.emptyName)?Colors.red:ResColors.primaryGrey,
                                ),
                              ),
                              hintText: Strings.enterName.tr,
                              hintStyle:
                              const TextStyle(color: Color(0xffABAFB6)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              )),
                        ),
                      ),

                      SizedBox(height: 12.h),
                      registerEmailTextField(controller,context),
                      SizedBox(height: 12.h),
                      passwordTextField(controller, context),
                      SizedBox(height: 12.h),
                      confirmPasswordTextField(controller, context),
                      SizedBox(height: 114.h),
                      customButton(
                        isLoading: controller.isLoading,
                          buttonColor:controller.isAllSelected?ResColors.primaryElement
                              : ResColors.primaryElementLight,
                          context,
                          Strings.continue1.tr,  controller.isLoading?(){}:() async {
                            controller.registration();
                        }
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
