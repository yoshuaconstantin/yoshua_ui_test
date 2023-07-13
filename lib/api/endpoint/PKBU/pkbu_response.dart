

import 'package:yoshua_ui_test/api/endpoint/PKBU/pkbu_response_data.dart';

class PkbuResponse {
  final bool isEmpty;
  final String page;
  final int countSize;
  final List<PkbuResponseData> get_company_response;

  PkbuResponse({
    required this.get_company_response,
    required this.isEmpty,
    required this.page,
    required this.countSize,

  });

  factory PkbuResponse.fromJson(Map<String, dynamic> json) {
    List<PkbuResponseData> data = [];

    if (json['get_company_response'] != null) {
      json['get_company_response'].forEach((v) {
        data.add(PkbuResponseData.fromJson(v));
      });
    }

  return PkbuResponse(
    isEmpty: json['isEmpty'],
    page: json['page'],
    countSize: json['countSize'],
    get_company_response: data,

  );
  }
}