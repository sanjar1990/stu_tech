import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:stu_tech/view/pages/auth/register/controller/register_controller.dart';
import 'package:stu_tech/view/widgets/custom_widgets.dart';
import '../../../../../data/tools/file_importer.dart';

Widget passwordTextField(RegisterController controller, BuildContext context){
  return SizedBox(
    width: MediaQuery.of(context).size.width - 60,
    child: TextFormField(
      keyboardType: TextInputType.visiblePassword,
      style: const TextStyle(color: ResColors.textColor),
      controller: controller.passwordController,
      obscureText: controller.isObscured,
      validator: (value) {
        if (controller.passwordController.text.trim().length < 6) {
          return Strings.enterCharacter.tr;
        }
        return null;
      },
      onChanged: (value){
        controller.checkIsAllSelected();
      },
      decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: controller.isObscured ? const Icon(Icons.visibility, color: ResColors.primaryGrey)
                : const Icon(Icons.visibility_off, color: ResColors.primaryGrey),
            onPressed: () {
              controller.setObscure(!controller.isObscured);
            },
          ),
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(
              color: controller.passwordNotValid?Colors.red:ResColors.primaryGrey
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(
              color: controller.passwordNotValid?Colors.red:ResColors.primaryGrey
            ),
          ),
          hintText: Strings.password.tr,
          hintStyle:
          const TextStyle(color: Color(0xffABAFB6)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
          )),
    ),
  );
}

Widget confirmPasswordTextField(RegisterController controller, BuildContext context){
  return SizedBox(
    width: MediaQuery.of(context).size.width - 60,
    child: TextFormField(
      obscureText: controller.isObscured2,
      keyboardType: TextInputType.visiblePassword,
      style: const TextStyle(color: ResColors.textColor),
      controller: controller.confirmPasswordController,
      onChanged: (value){
        controller.checkIsAllSelected();
      },
      decoration: InputDecoration(
          counterText: '',
          suffixIcon: IconButton(
            icon: controller.isObscured2 ? const Icon(Icons.visibility, color: ResColors.primaryGrey)
                : const Icon(Icons.visibility_off, color: ResColors.primaryGrey),
            onPressed: () {
              // controller.setObscure(!controller.isObscured2);
              controller.isObscured2=!controller.isObscured2;
              controller.update();
            },
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(
              color: controller.confirmPasswordNotValid ? Colors.red : ResColors.primaryGrey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(
              color: controller.confirmPasswordNotValid ? Colors.red : ResColors.primaryGrey,
            ),
          ),
          hintText: Strings.confirmPassword.tr,
          hintStyle:
          const TextStyle(color: Color(0xffABAFB6)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
          )),
    ),
  );
}
Widget registerEmailTextField(RegisterController controller, BuildContext context){
  return SizedBox(
    width: MediaQuery.sizeOf(context).width - 60,
    child: TextField(

      style: const TextStyle(color: ResColors.textColor),
      controller:  controller.emailController,
      onChanged: (value){
        controller.checkIsAllSelected();
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(
              color: (controller.emptyEmail)?Colors.red:ResColors.primaryGrey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(
                color: (controller.emptyEmail)?Colors.red:ResColors.primaryGrey
            ),
          ),
          hintText: Strings.enterEmail.tr,
          hintStyle:
          const TextStyle(color: Color(0xffABAFB6)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
          )),
    ),
  );
}
Widget selectRole(RegisterController controller, double width){
  return
    SizedBox(
      width:width,
      // width: 328.w,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(

            height: 44.h,

            decoration: BoxDecoration(
                color: ResColors.primaryBackground,
                border: Border.all(width: 1,color: ResColors.borderColor),
                borderRadius: BorderRadius.circular(4.r)
            ),

            margin: EdgeInsets.only(top: 10.h),
            child: DropdownButtonFormField2<String>(
              // isExpanded: true,
              decoration:  const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                // Add Horizontal padding using menuItemStyleData.padding so it matches
                // the menu padding when button's width is not specified.
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                filled: true,
                fillColor: Colors.white,

                // Add more decoration..
              ),
              hint: customText( 'Select role', fontSize: 14.sp, textColor: ResColors.textColor),


              items: controller.roles
                  .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item?? 'n/a',
                  style:  TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              )).toList(),
              validator: (value) {
                if (value == null) {
                  return'Validator';
                }
                return null;
              },
              onChanged: (value){
                if(value !=null){
                  controller.selectedRole=value;
                }
              controller.checkIsAllSelected();
              },
              buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.only(right: 14.w),
              ),
              iconStyleData:  IconStyleData(
                icon: SizedBox(
                  // margin: EdgeInsets.only(),
                  width: 10.w,
                  height: 14.h,

                  child: Image.asset('assets/icons/arrow_down.png',color: ResColors.primaryText,),
                ),
              ),
              dropdownStyleData: DropdownStyleData(

                decoration: BoxDecoration(

                  color: ResColors.white,
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 0.h),
              ),
            ),
          )
        ],
      ),
    );
}