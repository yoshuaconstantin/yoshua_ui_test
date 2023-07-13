import 'dart:async';

import 'package:basic_utils/basic_utils.dart';
import 'package:dio/dio.dart';

import '../../helper/constant.dart';
import '../../helper/preferences.dart';
import '../api_manager.dart';

class AuthorizationInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (Preferences.getInstance().contain(SharedPreferenceKey.SESSION_ID)) {
      String? expires = Preferences.getInstance().getString(SharedPreferenceKey.SESSION_EXPIRED_AT);

      if (StringUtils.isNotNullOrEmpty(expires)) {
        if (DateTime.now().isAfter(DateTime.fromMillisecondsSinceEpoch(int.parse(expires!)))) {
          await refreshToken();
        }
      } else {
        await refreshToken();
      }

      options.headers["Authorization"] = Preferences.getInstance().getString(SharedPreferenceKey.SESSION_ID);
    }

    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response != null && err.response!.statusCode == 401) {
      // do sign-out
    }

    return handler.next(err);
  }

  FutureOr<void> refreshToken() async {
    try {
      Response response = await ApiManager().refreshToken(
          expiredToken: Preferences.getInstance().getString(SharedPreferenceKey.SESSION_ID, "")!
      );

      if (response.statusCode == 200) {
        Preferences.getInstance().setString(SharedPreferenceKey.SESSION_ID, response.headers["Authorization"]![0]);
        Preferences.getInstance().setString(SharedPreferenceKey.SESSION_EXPIRED_AT, response.headers["Expires"]![0]);
      } else {
        // do sign-out
      }
    } catch (e, stacktrace) {
      print("Error: ${e}");
      print("Stacktrace: ${stacktrace}");

      // do sign-out
    }

  }
}