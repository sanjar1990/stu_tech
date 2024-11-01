import 'package:hive_flutter/hive_flutter.dart';
import 'package:stu_tech/data/storage/onboarding_storage/onboarding_holder.dart';

class OnboardingPrefs extends OnboardingHolder {
  late Box onboardingBox;

  OnboardingPrefs() {
    onboardingBox = Hive.box(onboardingBoxID);
  }



  @override
  bool get isOnboarding => onboardingBox.get(isOnboardingID, defaultValue: false);

  @override
  set isOnboarding(bool isOnboarding) => onboardingBox.put(isOnboardingID, isOnboarding);


  @override
  Future<void> clearOnboarding() async => await onboardingBox.clear();

  static const onboardingBoxID = 'onboarding_hive_box';
  static const isOnboardingID = 'isOnboarding';
}
