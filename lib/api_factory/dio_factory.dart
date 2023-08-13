import 'dart:convert';
import 'dart:developer' show log;
import 'dart:io';
import 'package:annapurna_finance/api_factory/config.dart';
import 'package:annapurna_finance/api_factory/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum ApiEnvironment { UAT, Dev, Prod }

extension APIEnvi on ApiEnvironment {
  String? get endpoint {
    switch (this) {
      case ApiEnvironment.UAT:
        return Urls.uatServerUrl;
      case ApiEnvironment.Dev:
        return Urls.devServerUrl;
      case ApiEnvironment.Prod:
        return Urls.prodServerUrl;
      default:
        return null;
    }
  }
}

typedef OnError = void Function(String error, Map<String, dynamic> data);
typedef OnResponse<BaseResponse> = void Function(BaseResponse response);

class DioFactory {
  static final _singleton = DioFactory._instance();

  static Dio? get dio => _singleton._dio;

  Dio? _dio;

  String basicAuth = 'Basic ${base64Encode(utf8.encode('Jayam:Jayam@123'))}';

  DioFactory._instance() {
    _dio = Dio(
      BaseOptions(
       // baseUrl: ApiEnvironment.UAT.endpoint!,
        baseUrl: ApiEnvironment.Prod.endpoint!,
        headers: {
          // HttpHeaders.userAgentHeader: _deviceName,
          HttpHeaders.authorizationHeader: basicAuth,
          // "device_id": Config.FCM_TOKEN,
          // "device_type": Platform.isIOS ? "I" : "A",
          // "language": Get.deviceLocale!.languageCode
        },
        connectTimeout: Config.timeout,
        receiveTimeout: Config.timeout,
        sendTimeout: Config.timeout,
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    if (!kReleaseMode) {
      _dio!.interceptors.add(
        LogInterceptor(
          request: Config.logNetworkRequest,
          requestHeader: Config.logNetworkRequestHeader,
          requestBody: Config.logNetworkRequestBody,
          responseHeader: Config.logNetworkResponseHeader,
          responseBody: Config.logNetworkResponseBody,
          error: Config.logNetworkError,
          logPrint: (Object object) {
            log(object.toString(), name: 'dio');
          },
        ),
      );
    }
    // if (Config.selfSignedCert) {
    //   final httpClientAdapter = _dio!.httpClientAdapter;
    //
    //   httpClientAdapter.onHttpClientCreate =
    //       _onHttpClientCreate as OnHttpClientCreate?;
    // }
  }
  static void initFCMToken(String token) {
    var _token = token;
    dio!.options.headers["device_id"] = _token;
  }

// dynamic _onHttpClientCreate(HttpClient client) {
//   client.badCertificateCallback = _badCertificateCallback;
// }
//
// bool _badCertificateCallback(X509Certificate cert, String host, int port) {
//   return true;
// }
}
