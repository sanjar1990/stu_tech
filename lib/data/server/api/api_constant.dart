import 'package:get/get.dart';
import 'package:stu_tech/data/storage/auth/auth_holder.dart';

import '../../storage/app/locals/lang_prefs/language_prefs.dart';

class ApiConst{
  static const CONNECTION_TIME = 20000;
  static const SEND_TIME_OUT = 20000;
  static const String Base_URl = "https://api.stu_techtextil.uz";

  static  Map<String,String> HEADERS = {
    'Content-type' : 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${Get.find<AuthHolder>().authToken}',
    'Accept-Language':Get.find<LangPrefs>().lang,
  };

  static Map<String, String> QUERY = {
    "page" : "0",
    "size" : "50",
  };

  static const String NO_PHOTO =  "https://api.stu_techtextil.uz/api/v1/attach/puplic/open/c26e7e74-5753-4fbb-80a1-72d1cc354822.jpg";
  static const String LOGIN = "/api/v1/auth/login";
  static const String REGISTER = "/api/v1/auth/registration";
  static const String VERIFICATION = "/api/v1/auth/registration/verification";
  static const String RESEND_SMS = "/api/v1/auth/resend/sms";
  static const String RESET_PASSWORD = "/api/v1/auth/reset-password";
  static const String RESET_PASSWORD_CONFIRM = '/api/v1/auth/reset-password/confirm';
  static const String CATEGORY_LIST = "/api/v1/category/public/list";
  static const String UPLOAD_IMAGE = "https://api.stu_techtextil.uz/api/v1/attach/public/upload";
  static const String REGION_lIST = "/api/v1/region/public/by-lang";
  static const String DISTRICT_lIST = "/api/v1/district/";
  static const String GET_SUB_CATEGORY_LIST_BY_ID = "/api/v1/category/public/child_category/";
  static const String DELETE_ATTACH = "/api/v1/attach/";
  static const String CREATE_POST = "/api/v1/product/";
  static const String GET_POST_BY_ID_AUTHORIZED =  "/api/v1/product/";
  static const String GET_POST_BY_ID_UNAUTHORIZED =  "/api/v1/product/public/";
  static const String GET_ALL_POST_PAGINATION_PUBLIC =  "/api/v1/product/public/filter";
  static const String GET_ALL_POST_PAGINATION_AUTHORIZED =  "/api/v1/product/filter/authorised";
  static const String PRODUCT_LIKE =  "/api/v1/product_save/";
  static const String UPDATE_PROFILE_DETAIL = '/api/v1/profile/detail';
  static const String UPDATE_PHONE = '/api/v1/profile/update-phone';
  static const String UPDATE_PHONE_VERIFICATION = '/api/v1/profile/phone-verification/';
  static const String UPDATE_PROFILE_PHOTO = "/api/v1/profile/update/photo";
  static const String PRODUCT_SAVE = "/api/v1/product_save/";
  static const String MY_PRODUCTS = "/api/v1/product/my_products";
  static const String UPDATE_POST_STATUS = '/api/v1/product/delete/';

  static const String CREATE_COMMENT = "/api/v1/comment/";
  static const String COMMENT_LIST_POST_ID = "/api/v1/comment/public/pagination/";
  static const String GET_SELL_TYPE_LIST = "/api/v1/sell_type/public/";
  static const String GET_COLOR_LIST = "/api/v1/colour/colour_list";
  static const String CREATE_ORDER = "/api/v1/order/create";
  static const String GET_PRODUCT_LIST_BY_PROFILE_ID = "/api/v1/product/product_by_profile";
  static const String PUBLIC_GET_PRODUCT_LIST_BY_PROFILE_ID = "/api/v1/product/public/product_by_profile";
  static const String UPDATE_POST = "/api/v1/product/";
  static const String GET_ORDERS = "/api/v1/order/self";
  static const String GET_ORDER_MESSAGE_LIST_PAGINATION = "/api/v1/message";
  static const String CREATE_ORDER_MESSAGE = "/api/v1/message/create";
  static const String CANCEL_ORDER_STATUS = "/api/v1/order/cancel_status";
  static const String GET_ALL_ORDER_LIST = "/api/v1/order/getAll";
  static const String GET_ALL_ORDER_STATUS = "/api/v1/order/public/get_order_type";
  static const String UPDATE_ORDER_STATUS = "/api/v1/order/update_status";
  static const String GET_ORDER_BY_ID = "/api/v1/order/get";
  static const String CREATE_SUPPORT_CHAT = "/api/v1/support_chat/create";
  static const String GET_SUPPORT_CHAT_PAGINATION = "/api/v1/support_chat/";
  static const String GET_SUPPORT_USERS_LIST = "/api/v1/support_chat/list_chat";
  static const String UPDATE_NOTIFICATION = "/api/v1/profile/update_notification";
  static const String REMOVE_NOTIFICATION = "/api/v1/notification/public/remove_fcm_token";
  static const String DELETE_CURRENT_PROFILE = "/api/v1/profile/delete-current-profile";
}