import 'package:stu_tech/data/tools/file_importer.dart';

Widget loginEmailTextField(LoginController controller, BuildContext context){
  return SizedBox(
    width: MediaQuery.sizeOf(context).width - 60,
    child: TextField(
      
      style: const TextStyle(color: ResColors.textColor),
      controller:  controller.emailController,
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
Widget loginPasswordTextField(LoginController controller, BuildContext context){
  return SizedBox(
    width: MediaQuery.sizeOf(context).width - 60,
    child: TextField(
      obscureText: controller.isObscured,
      style: const TextStyle(color: ResColors.textColor),
      controller:  controller.passwordController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.password),
          suffixIcon: IconButton(
            icon: controller.isObscured ? const Icon(Icons.visibility, color: ResColors.primaryGrey)
                : const Icon(Icons.visibility_off, color: ResColors.primaryGrey),
            onPressed: () {
              controller.setObscure(!controller.isObscured);
            },
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(
              color: (controller.emptyPassword)?Colors.red:ResColors.primaryGrey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(
              color: (controller.emptyPassword)?Colors.red:ResColors.primaryGrey
            ),
          ),
          hintText: Strings.enterPassword.tr,
          hintStyle:
          const TextStyle(color: Color(0xffABAFB6)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
          )),
    ),
  );
}

// class BuildFormField extends StatelessWidget {
//   final Icon image;
//   final String hintText;
//   final bool isPassword;
//   final String labelName;
//   final TextEditingController controller;
//
//   const BuildFormField(
//       {super.key,
//       required this.controller,
//       required this.image,
//       required this.labelName,
//       required this.hintText,
//       this.isPassword = false});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           labelName,
//           style: Theme.of(context)
//               .textTheme
//               .displayLarge
//               ?.copyWith(color: ResColors.colorLoginPageText),
//         ),
//         SizedBox(height: 14.h),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 25).w,
//           alignment: Alignment.centerLeft,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30).r,
//             boxShadow: ResColors.shadowOne,
//             color: Theme.of(context).colorScheme.primary,
//           ),
//           height: 70.h,
//           child: TextFormField(
//             textInputAction: TextInputAction.next,
//             obscureText: isPassword,
//             controller: controller,
//             style: Theme.of(context).textTheme.displayMedium,
//             keyboardType: TextInputType.emailAddress,
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               // contentPadding: const EdgeInsets.only(left: 12).w,
//               prefixIcon: image,
//               hintText: hintText,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
