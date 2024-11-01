import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:stu_tech/data/storage/app/locals/lang_prefs/language_prefs.dart';
import 'package:stu_tech/data/storage/onboarding_storage/onboarding_prefs.dart';
import 'package:stu_tech/data/tools/cloud_messaging_service/cloud_messaging_service.dart';
import 'adapter_register.dart';
import 'data/storage/auth/auth_prefs.dart';
import 'data/tools/permissions/check_permission.dart';
import 'firebase_options.dart';
import 'injection.dart';

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'StuTech',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await DIService.init();
  await Hive.initFlutter();
  registerAdapters();
  await Hive.openBox(AuthPrefs.authBoxID);
  await Hive.openBox(OnboardingPrefs.onboardingBoxID);
  // await Hive.openBox("itemsBox");
  // await Hive.openBox(AppHolderImp.commonId);

  await Hive.openBox(LangPrefs.langBox);

  await LocalNotificationService().initialize();
  await CheckPermission().isStoragePermission();
  // Future.delayed(const Duration(seconds: 10));
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

}