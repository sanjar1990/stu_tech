import '../../data/tools/file_importer.dart';
import '../../data/tools/styles/text_theme.dart';

void showSnackBar({required String text, Color? backgroundColor, Duration? duration  }){
  ScaffoldMessenger.of(Get.context!)
    ..hideCurrentSnackBar()
    ..showSnackBar(
        SnackBar(
            duration: duration?? const Duration(seconds: 2),
            backgroundColor: backgroundColor?? ResColors.primaryElement,
            content: Text(
              text,
              style: theme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontSize: 16.sp
              ),
            ),
        )
    );
}