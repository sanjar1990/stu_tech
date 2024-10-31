import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:stu_tech/data/server/error_strings.dart';
import 'package:stu_tech/data/tools/file_importer.dart';
import 'package:stu_tech/data/tools/service/exception/exp.dart';

class ErrorParser {
  static String parse(error) {
    if (kDebugMode) {
      Get.log(error.toString());
    }
    if (error is Exception) {
      try {

        if (error is DioException) {

          switch (error.type) {
            case DioExceptionType.badResponse:
              var errorBody = error.response?.data['result'.tr];
              if(error.response?.statusCode==401){
             errorBody=401.toString();
              }
              if (errorBody != null) {
                return errorBody;
              }
              return "${ErrorStrings.badRequest.tr}${error.response?.statusCode}";
            default:
              return ErrorStrings.noInternet.tr;
          }
        }
        if (error is NotValidException) {
          return error.message.tr;
        }
        return error.toString();
      } on FormatException catch (e) {
        Get.log("Error parser $e");
        return ErrorStrings.formatError.tr;
      } catch (e) {
        Get.log("Error parser catch $e");
        return ErrorStrings.unKnownError.tr;
      }
    }
    return error.toString().contains("is not a subtype of") ? ErrorStrings.unableToProcess.tr : ErrorStrings.unexpectedError.tr;
  }
}
