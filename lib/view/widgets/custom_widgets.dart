import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stu_tech/data/tools/file_importer.dart';

Widget customText(String text,
    {double fontSize = 14,
    Color textColor = ResColors.primaryText,
    FontWeight fontWeight = FontWeight.w400}) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      fontSize: fontSize.sp,
      color: textColor,
      fontWeight: fontWeight,
    ),
  );
}

Widget customButton(BuildContext context, String title, void Function() func,
    { required Color buttonColor, bool isLoading=false}) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: MediaQuery.of(context).size.width - 30.w,
      height: 44.h,
      decoration: BoxDecoration(
          borderRadius: Platform.isIOS
              ? BorderRadius.circular(10.r)
              : BorderRadius.circular(4.r),
          color: buttonColor),
      child: Center(
        child: isLoading? SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
strokeWidth: 3,
              color: Colors.white,)): customText(title,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            textColor: ResColors.white),
      ),
    ),
  );
}

AppBar customAppBar(String title, {bool isProfilePage = false}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: ResColors.backgroundColor,
    foregroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    actions: [
      Visibility(
        visible: isProfilePage,
        child: Padding(
          padding: EdgeInsets.only(top: 7.h, right: 15.w, bottom: 15.h),
          child: IconButton(
              onPressed: () {
                Get.find<ProfileController>().logout();
              },
              icon: Icon(
                Icons.logout,
                color: ResColors.primaryBackground,
                size: 24.sp,
              )),
        ),
      )
    ],
    flexibleSpace: Container(
        width: 360.w,
        decoration: Platform.isIOS
            ? BoxDecoration(
                color: ResColors.primaryElement,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24.r),
                    bottomRight: Radius.circular(24.r)))
            :  BoxDecoration(color: ResColors.primaryElement),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 40.h),
            child: customText(title,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                textColor: ResColors.white),
          ),
        )),
  );
}

Widget dropDown(String title, List<String> list, void Function(String?) func) {
  return Container(
    margin: EdgeInsets.only(top: 16.h),
    width: 328.w,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText(title, fontSize: 14.sp),
        Container(
          height: 44.h,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: ResColors.borderColor),
              borderRadius: BorderRadius.circular(4.r)),
          margin: EdgeInsets.only(top: 10.h),
          child: DropdownButtonFormField2<String>(
            // isExpanded: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              // Add Horizontal padding using menuItemStyleData.padding so it matches
              // the menu padding when button's width is not specified.
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              filled: true,
              fillColor: Colors.white,

              // Add more decoration..
            ),
            hint: customText(Strings.select.tr,
                fontSize: 12.sp, textColor: ResColors.secondaryText),

            items: list
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Validator';
              }
              return null;
            },
            onChanged: func,
            buttonStyleData: ButtonStyleData(
              padding: EdgeInsets.only(right: 14.w),
            ),
            iconStyleData: IconStyleData(
              icon: SizedBox(
                // margin: EdgeInsets.only(),
                width: 10.w,
                height: 14.h,

                child: Image.asset(
                  'assets/icons/arrow_down.png',
                  color: ResColors.primaryText,
                ),
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

Widget customPriceTextField(void Function(String) func) {
  return Container(
    height: 44.h,
    margin: EdgeInsets.only(top: 10.h),
    decoration: BoxDecoration(
        color: ResColors.white,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(width: 1, color: ResColors.borderColor)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(left: 14.w),
          width: 270.w,
          child: TextField(
              onChanged: func,
              maxLines: 1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: GoogleFonts.roboto(
                      fontSize: 14.sp, color: ResColors.secondaryText)),
              style: GoogleFonts.roboto(
                  fontSize: 14.sp, color: ResColors.primaryText)),
        ),
        Container(
          padding: EdgeInsets.only(right: 14.w),
          child: customText(Strings.sum.tr, textColor: ResColors.secondaryText),
        ),
      ],
    ),
  );
}









AppBar customAppBar2(bool heartExists) {
  return AppBar(
    foregroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    leading: Container(),
    flexibleSpace: Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: ResColors.white,
      ),
      child: Container(
        margin: EdgeInsets.only(
          left: 16.w,
          right: 16.h,
          top: 40.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Center(
                child: SizedBox(
                    width: 28.w,
                    height: 28.h,
                    child: Platform.isIOS
                        ? Image.asset('assets/icons/back_white.png')
                        : Image.asset('assets/icons/back_white_android.png')),
              ),
            ),
            if (heartExists)
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border:
                        Border.all(width: 1.w, color: const Color(0xffE4E4E4)),
                  ),
                  child: Center(
                    child: SizedBox(
                        width: 88.w,
                        height: 16.h,
                        child: Image.asset('assets/icons/heart_appbar.png')),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

Widget customPremiumWidget(List<String> tariffNames) {
  List<AnimatedText> animatedTexts = tariffNames
      .map((text) {
        if(text.length>10){
          text=text.substring(0,9);
        }
        return RotateAnimatedText(

        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,

        ),
        text);
  })
      .toList();
  return Container(
    width: 72.w,
    height: 24.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.r),
      color: ResColors.primaryBackground,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Container(
        //   margin: EdgeInsets.only(left: 4.w, right: 4.w),
        //   width: 10.w,
        //   height: 10.h,
        //   child: Icon(Icons.star, color: Colors.white, size: 11.sp,)
        //   // Image.asset(
        //   //   'assets/icons/little_star.png',
        //   //   color: ResColors.white,
        //   // ),
        // ),
        if (animatedTexts.isNotEmpty)
          Container(
            margin: EdgeInsets.only(left: 5.w, right: 5.w),
            child: DefaultTextStyle(
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
              child: AnimatedTextKit(
                  repeatForever: true,
                  isRepeatingAnimation: true,
                  pause: const Duration(milliseconds: 500),
                  animatedTexts: animatedTexts),
            ),
          ),
      ],
    ),
  );
}



Widget textLink(String text, void Function() func) {
  return InkWell(
    onTap: func,
    child: Text(
      text,
      style: TextStyle(
          color: ResColors.primaryElement,
          decoration: TextDecoration.underline,
          decorationColor: ResColors.primaryElement,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
          fontFamily: 'Roboto'),
    ),
  );
}

Widget pageTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, top: 30.h),
    child: Text(
      title,
      style: TextStyle(
          fontFamily: 'Roboto', fontWeight: FontWeight.w700, fontSize: 24.sp),
    ),
  );
}

