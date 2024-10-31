import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:stu_tech/data/tools/file_importer.dart';
import 'package:stu_tech/view/pages/start/splash/controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller)=>Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100, top: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset('assets/icons/edu_icon.png'),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 60,
                    height: 60,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballRotateChase,
                      colors: [ResColors.phoneBlue],
                      strokeWidth: 2,
                      backgroundColor: Colors.white,
                      pathBackgroundColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ) );

  }
}
