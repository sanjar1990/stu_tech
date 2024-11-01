import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stu_tech/data/tools/file_importer.dart';
import 'package:stu_tech/view/widgets/custom_widgets.dart';

class SelectRoleButton extends StatelessWidget {
  const SelectRoleButton({super.key, required this.func, required this.title,  required this.isSelected,});
final VoidCallback func;
final String title;
final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        width: 130,
        height: 44.h,
        decoration: BoxDecoration(
            borderRadius: Platform.isIOS
                ? BorderRadius.circular(10.r)
                : BorderRadius.circular(4.r),
            color: isSelected? ResColors.primaryElement:ResColors.primaryElementLight),
        child: Center(
          child:  customText(title,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              textColor: ResColors.white),
        ),
      ),
    );
  }
}
