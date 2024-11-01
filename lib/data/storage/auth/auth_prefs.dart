import 'package:hive_flutter/hive_flutter.dart';
import 'auth_holder.dart';

class AuthPrefs extends AuthHolder {
  late Box authBox;

  AuthPrefs() {
    authBox = Hive.box(authBoxID);
  }

  @override
  String get authToken => authBox.get(authTokenId, defaultValue: '');

  @override
  set authToken(String token) => authBox.put(authTokenId, token);

  @override
  String get photoUrl => authBox.get(photoUrlId, defaultValue: '');

  @override
  set photoUrl(String name) => authBox.put(photoUrlId, name);

  @override
  String get name => authBox.get(nameId, defaultValue: '');

  @override
  set name(String name) => authBox.put(nameId, name);

  @override
  String get surname => authBox.get(surnameId, defaultValue: '');

  @override
  set surname(String surname) => authBox.put(surnameId, surname);

  @override
  String get universityName => authBox.get(universityNameId, defaultValue: '');

  @override
  set universityName(String universityName) => authBox.put(universityNameId, universityName);

  @override
  String get workExperience => authBox.get(workExperienceId, defaultValue: '');

  @override
  set workExperience(String workExperience) => authBox.put(workExperienceId, workExperience);


  @override
  String get userId => authBox.get(profileId, defaultValue: '');

  @override
  set userId(String name) => authBox.put(profileId, name);


  @override
  String get fcmToken => authBox.get(fcmTokenId, defaultValue: '');

  @override
  set fcmToken(String fcmToken) => authBox.put(fcmTokenId, fcmToken);

  @override
  bool get notificationValue => authBox.get(notificationValueId, defaultValue: true);

  @override
  set notificationValue(bool notificationValue) => authBox.put(notificationValueId, notificationValue);
  @override
  bool get isLoggedIn => authBox.get(isLoggedInId, defaultValue: false);

  @override
  set isLoggedIn(bool isLoggedIn) => authBox.put(isLoggedInId, isLoggedIn);

  @override
  bool get isOnboarding => authBox.get(isOnboardingID, defaultValue: false);

  @override
  set isOnboarding(bool isOnboarding) => authBox.put(isOnboardingID, isOnboarding);

  @override
  String get role => authBox.get(roleId, defaultValue: '');

  @override
  set role (String role) => authBox.put(roleId, role);

  @override
  String get email => authBox.get(emailId, defaultValue: '');

  @override
  set email (String email) => authBox.put(emailId, email);

  @override
  Future<void> clearAuth() async => await authBox.clear();

  static const authBoxID = 'auth_hive_box';
  static const roleId = 'role';
  static const emailId = 'email';
  static const authTokenId = 'authToken';
  static const photoUrlId = 'photoUrl';
  static const nameId = 'name';
  static const surnameId = 'surname';
  static const universityNameId = 'universityName';
  static const workExperienceId = 'workExperience';
  static const profileId = 'userId';
  static const notificationValueId = 'notificationValue';
  static const isLoggedInId = 'isLoggedIn';
  static const isOnboardingID = 'isOnboarding';
  static const fcmTokenId = 'fcmToken';
}
