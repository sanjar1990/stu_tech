

abstract class AuthHolder {
  late String authToken;
  // late String role;
  late String username;
  late String userId;
  late String name;
  late String email;
  late String photoId;
  late String photoUrl;
  late String phone;
  late String smsCode;
  late String fcmToken;
  late bool notificationValue;
  late bool isLoggedIn;
  late String role;
  late String supportChatId;

  Future<void> clearAuth();
}
