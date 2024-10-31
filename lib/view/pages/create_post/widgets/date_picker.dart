import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:stu_tech/data/tools/styles/res_colors.dart';
import 'package:stu_tech/view/pages/create_post/controller/create_post_controller.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class DatePickerCustom extends StatelessWidget {
  final CreatePostController controller;

  const DatePickerCustom({super.key, required this.controller});

  void _showDatePicker(BuildContext context) {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2024, 1, 1),
      maxTime: DateTime(2030, 12, 31),
      onConfirm: (date) {
             controller.createdTime = DateFormat('HH:mm dd.MM.yyyy').format(date);
        controller.update();
      },
      currentTime: DateTime.now(),
      locale: (Get.locale?.languageCode == 'ru')
          ? LocaleType.ru
          : (Get.locale?.languageCode == 'uz')
          ? LocaleType.uz
          : LocaleType.en,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Created date'),
                InkWell(
                  child: Container(
                    width: 370.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border:
                        Border.all(color: ResColors.borderColor)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 12, left: 12, top: 15, bottom: 15),
                      child: Text(
                        controller.createdTime.isEmpty
                            ? "select create date"
                            : controller.createdTime,
                        style: TextStyle(fontSize: 16.5.sp),
                      ),
                    ),
                  ),
                  onTap: () {
                    _showDatePicker(context);
                    controller.update();
                  },
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
