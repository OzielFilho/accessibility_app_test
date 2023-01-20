import '../enum/http_methods.dart';

class HttpParams {
  final String url;
  final HttpMethods method;
  final String? body;
  final Map<String, String>? header;

  HttpParams(this.body, this.header, {required this.url, required this.method});
}
