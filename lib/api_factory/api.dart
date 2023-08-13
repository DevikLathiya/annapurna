import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:annapurna_finance/api_factory/base_response.dart';
import 'package:annapurna_finance/api_factory/prefs/pref_utils.dart';
import 'package:annapurna_finance/utils/dialogs.dart';
import 'package:annapurna_finance/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dio_factory.dart';

enum HttpMethod { delete, get, patch, post, put }

class Api {
  //General Post Request
  static Future<void> request({
    required HttpMethod method,
    required String path,
    required Map params,
    var formData = '',
    required BuildContext context,
    required OnResponse onResponse,
    bool isAuthorization = false,
    bool isUploadImage = false,
    bool isCustomResponse = false,
    String basicAuth = '',
  }) async {
    String username = 'Jayam';
    String password = 'Jayam@123';
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    try {
      showLoading(context);
      String encryptedParams = "";
      String encodedParams = "";

      log("------original params------->>>>>>>>> $params");

      Response response;
      switch (method) {
        case HttpMethod.post:
          response = await DioFactory.dio!.post(
            path,
            options: Options(
              headers: <String, dynamic>{
                'Authorization': basicAuth,
                HttpHeaders.contentTypeHeader: "application/json"
              },
              responseType: ResponseType.json,
            ),
            data: isUploadImage ? formData : params,
          );
          break;
        case HttpMethod.delete:
          response = await DioFactory.dio!.delete(
            path,
            options: Options(
              headers: <String, dynamic>{
                'Authorization': basicAuth,
                HttpHeaders.contentTypeHeader: "application/json"
              },
              responseType: ResponseType.json,
            ),
            data: isUploadImage ? formData : params,
          );
          break;
        case HttpMethod.get:
          response = await DioFactory.dio!.get(
            path,
            options: Options(
              headers: <String, dynamic>{
                'Authorization': basicAuth,
                HttpHeaders.contentTypeHeader: "application/json"
              },
              responseType: ResponseType.json,
            ),
          );
          break;
        case HttpMethod.patch:
          response = await DioFactory.dio!.patch(
            path,
            options: Options(
              headers: <String, dynamic>{
                'Authorization': basicAuth,
                HttpHeaders.contentTypeHeader: "application/json"
              },
              responseType: ResponseType.json,
            ),
            data: isUploadImage ? formData : params,
          );
          break;
        case HttpMethod.put:
          response = await DioFactory.dio!.put(
            path,
            options: Options(
              headers: <String, dynamic>{
                'Authorization': basicAuth,
                HttpHeaders.contentTypeHeader: "application/json"
              },
              responseType: ResponseType.json,
            ),
            data: isUploadImage ? formData : params,
          );
          break;

        default:
          return;
      }

      hideLoading(context);

      if (isCustomResponse) {
        onResponse(response.data);
      } else {
        onResponse(BaseResponse.fromJson(response.data));
      }
      //      onResponse(response.data);
    } catch (e) {
      hideLoading(context);
      String errorMessage = "";
      if (e is DioError) {
        if (e.type == DioErrorType.connectTimeout ||
            e.type == DioErrorType.sendTimeout ||
            e.type == DioErrorType.receiveTimeout ||
            e.type == DioErrorType.other) {
          errorMessage = 'Server unreachable';
        } else if (e.type == DioErrorType.response) {
          if (e.response!.statusCode == 401) {
            PrefUtils.clearPrefs();

           // showSessionDialog(context);
          }
          final response = e.response;
          log("------response----->>>>>>>>>>>> $response");

          if (response!.data["message"] != null &&
              response.data["message"].isNotEmpty) {
            errorMessage = response.data['message'];
          } else if (response.data["errors"]["message"] != null &&
              response.data["errors"]["message"].isNotEmpty) {
            errorMessage = response.data["errors"]["message"];
          } else {
            errorMessage = "Something went wrong";
          }
        } else {
          errorMessage = "Request cancelled";
        }
      } else {
        errorMessage = e.toString();
      }

      handleApiError(errorMessage, context);
    }
  }
}
