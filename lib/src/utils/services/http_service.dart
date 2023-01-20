import 'dart:async';
import 'dart:convert';

import 'package:flutter_app/src/utils/extensions/enum_extension.dart';
import 'package:http/http.dart' as http;

import '../params/http_params.dart';

abstract class HttpService {
  Future<Map<String, dynamic>> execute(HttpParams params);
}

class HttpServiceClient implements HttpService {
  @override
  Future<Map<String, dynamic>> execute(HttpParams params) async {
    try {
      Uri? uri = Uri.tryParse(params.url);

      http.Request request = http.Request(params.method.inString, uri!);
      final headers = params.header;
      request.headers.addAll(headers!);

      if (params.body != null) request.body = params.body!;

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return json.decode(response.body);
    } on TimeoutException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception();
    }
  }
}
