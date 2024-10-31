import '../file_importer.dart';

class ScreenSize{
 static bool isTablet(BuildContext context){
    return MediaQuery.of(context).size.width > 600;
  }
}