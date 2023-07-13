import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';


import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../helper/constant.dart';
import '../helper/custom_catch.dart';
import '../helper/preferences.dart';
import 'endpoint/PKBU/pkbu_request.dart';
import 'endpoint/login/login_request.dart';
import 'interceptor/authorization_interceptor.dart';


class ApiManager {
  static bool PRIMARY = true;

  static Future<Dio> getDio(
      {bool withoutAuthorizationInterceptor = false}) async {
    String baseUrl;

    if (PRIMARY) {
      baseUrl =
          Preferences.getInstance().getString(SharedPreferenceKey.MAIN_BASE) ??
              ApiUrl.MAIN_BASE;
    } else {
      baseUrl = Preferences.getInstance().getString(
          SharedPreferenceKey.SECONDARY_BASE) ?? ApiUrl.SECONDARY_BASE;
    }

    Dio dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 50000,
        receiveTimeout: 30000,
        responseDecoder: (responseBytes, options, responseBody) {
          if (responseBody.statusCode == 401) {
            options.responseType = ResponseType.plain;
          }

          return utf8.decode(responseBytes, allowMalformed: true);
        }));

    if (!withoutAuthorizationInterceptor) {
      dio.interceptors.add(AuthorizationInterceptor());
    }

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      return client;
    };

    return dio;
  }

  Future<Response> login(
      {required LoginRequest loginRequest, bool secondTry = false}) async {
    try {
      Dio dio = await getDio();

      Response response = await dio.post(ApiUrl.SIGN_IN, data: loginRequest);

      return response;
    } on DioError catch (e) {
      if (secondTry) {
        if (e.type == DioErrorType.response) {
          rethrow;
        } else {
          String message = await CustomCatch.internetCatch();
          throw Exception(message);
        }
      } else {
        PRIMARY = !PRIMARY;

        return login(loginRequest: loginRequest, secondTry: true);
      }
    }
  }

  Future<Response> getPKBUData(
      {required PkbuRequest pkbuRequest, bool secondTry = false}) async {
    try {
      Dio dio = await getDio();

      Response response = await dio.post(ApiUrl.GET_PKBU, data: pkbuRequest);

      return response;
    } on DioError catch (e) {
      if (secondTry) {
        if (e.type == DioErrorType.response) {
          rethrow;
        } else {
          String message = await CustomCatch.internetCatch();
          throw Exception(message);
        }
      } else {
        PRIMARY = !PRIMARY;

        return getPKBUData(pkbuRequest: pkbuRequest, secondTry: true);
      }
    }
  }

  Future<Response> refreshToken(
      {required String expiredToken, bool secondTry = false}) async {
    try {
      Dio dio = await getDio(withoutAuthorizationInterceptor: true);

      Response response = await dio.post(ApiUrl.REFRESH_TOKEN, data: {
        "expiredToken": expiredToken.substring("Bearer".length).trim()
      });

      return response;
    } on DioError catch (e) {
      if (secondTry) {
        if (e.type == DioErrorType.response) {
          rethrow;
        } else {
          String message = await CustomCatch.internetCatch();
          throw Exception(message);
        }
      } else {
        PRIMARY = !PRIMARY;

        return refreshToken(expiredToken: expiredToken, secondTry: true);
      }
    }
  }

}
  // Future<Response> signOut({bool secondTry = false}) async {
  //   try {
  //     Dio dio = await getDio();
  //
  //     Response response = await dio.post(ApiUrl.SIGN_OUT);
  //
  //     return response;
  //   } on DioError catch (e) {
  //     if (secondTry) {
  //       if(e.type == DioErrorType.response) {
  //         rethrow;
  //       } else {
  //         String message = await CustomCatch.internetCatch();
  //         throw Exception(message);
  //       }
  //     } else {
  //       PRIMARY = !PRIMARY;
  //
  //       return signOut(secondTry: true);
  //     }
  //   }
  // }
