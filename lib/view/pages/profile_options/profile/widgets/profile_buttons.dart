import 'dart:io';
import 'package:stu_tech/data/tools/file_importer.dart';

Widget customButton1(
    String title, Color color, void Function() func, BuildContext context) {
  return GestureDetector(
    onTap: func,
    child: Container(
      height: 44.h,
      width: MediaQuery.of(context).size.width - 30.w,
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: Platform.isIOS
            ? BorderRadius.circular(10.r)
            : BorderRadius.circular(4.r),
        // border: Border.all(color: Colors.transparent),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     offset: const Offset(0, 1),
        //     spreadRadius: 1,
        //     blurRadius: 2,
        //   )
        // ]
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: ResColors.backgroundColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "Gilroy"),
        ),
      ),
    ),
  );
}

Widget customButton2(
  String assetPath,
  String title,
  BuildContext context,
  BorderRadius borderRadius,
  void Function() func,
) {
  return GestureDetector(
    onTap: func,
    child: Container(
      height: 48.h,
      width: MediaQuery.of(context).size.width - 30.w,
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        // border: Border.all(color: Colors.transparent),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     // offset: const Offset(0, 1),
        //     spreadRadius: 0.1,
        //     blurRadius: 0.1,
        //   )
        // ]
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Image.asset(assetPath, height: 32.h, width: 32.w),
          ),
          SizedBox(width: 10.w),
          Text(
            title,
            style: TextStyle(
                color: ResColors.textColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: "Gilroy"),
          ),
        ],
      ),
    ),
  );
}

Widget changeAppLanguage(ProfileController controller) {
  return Padding(
    padding: EdgeInsets.only(left: 14.w),
    child: Row(
      children: [
        Text("${Strings.selectLanguage.tr}:",
            style: TextStyle(
                color: const Color(0xff263141),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto")),
        SizedBox(width: 14.w),
        GestureDetector(
          onTap: () {
            LangService.changeLocale('uz');
          },
          child: Text(
            "Uz",
            style: TextStyle(
                color: Get.locale?.languageCode == 'uz'
                    ? ResColors.textColor
                    : ResColors.primaryGrey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto"),
          ),
        ),
        SizedBox(width: 30.w),
        GestureDetector(
          onTap: () {
            LangService.changeLocale('ru');
          },
          child: Text(
            "Ru",
            style: TextStyle(
                color: Get.locale?.languageCode == 'ru'
                ? ResColors.textColor
                : ResColors.primaryGrey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto"),
          ),
        ),
        SizedBox(width: 30.w),
        GestureDetector(
          onTap: () {
            LangService.changeLocale('en');
          },
          child: Text(
            "En",
            style: TextStyle(
                color: Get.locale?.languageCode == 'en'
                    ?  ResColors.textColor
                    : ResColors.primaryGrey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto"),
          ),
        )
      ],
    ),
  );
}



// AppBar customAppBar(String title) {
//   return AppBar(
//     centerTitle: true,
//     toolbarHeight: 103.h,
//     flexibleSpace: Container(
//       width: 360.w,
//       height: 130.h,
//       decoration: BoxDecoration(
//           color: ResColors.primaryElement,
//           borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(24.r),
//               bottomRight: Radius.circular(24.r))),
//     ),
//     title: Padding(
//       padding: EdgeInsets.only(top: 34.h),
//       child: Text(title,
//           style: TextStyle(
//               color: ResColors.backgroundColor,
//               fontSize: 24.sp,
//               fontWeight: FontWeight.w700,
//               fontFamily: "Roboto")),
//     ),
//     // shape: RoundedRectangleBorder(
//     //     borderRadius: BorderRadius.only(
//     //       bottomLeft: Radius.circular(24.r),
//     //       bottomRight: Radius.circular(24.r),
//     //     )
//     // ),
//   );
// }
