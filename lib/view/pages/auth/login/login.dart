import 'package:stu_tech/data/tools/file_importer.dart';
import 'package:stu_tech/view/pages/auth/register/register_page.dart';
import 'package:stu_tech/view/widgets/custom_widgets.dart';
class LoginPage extends StatelessWidget {
   const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: LoginController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child:
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 102.h),
                        child: Image.asset("assets/icons/edu_icon.png",
                            height: 120.h),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 24.h),
                        child: Text(
                          Strings.signIn.tr,
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      loginEmailTextField(controller, context),
                      SizedBox(height: 12.h),
                      loginPasswordTextField(controller, context),
                      SizedBox(height: 10.h),

                      SizedBox(height: MediaQuery.of(context).size.height/4.2),
                      textLink(Strings.signUp.tr, (){
                        Get.to( const RegisterPage(), transition: Transition.rightToLeftWithFade);
                      },
                      ),
                      SizedBox(height: 12.h),
                      customButton(
                        isLoading:controller.isLoading,
                        buttonColor: (

                            controller.emailController.text.isNotEmpty)
                            && (controller.passwordController.text.length >= 6)? ResColors.primaryElement
                            : ResColors.primaryElementLight,
                          context,
                          Strings.signIn.tr, () async {
                          if(!controller.isLoading &&
                              (controller.emailController.text.isNotEmpty) && (controller.passwordController.text.length >= 6)){
                            await controller.login();
                          }else{

                          }

                       },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
