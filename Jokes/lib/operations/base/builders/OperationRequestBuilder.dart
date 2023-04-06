import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class HTTPMethod {
  static const get = "get";
  static const post = "post";
  static const put = "put";
  static const delete = "delete";
  static const patch = "patch";
}

abstract class RequestBuilderInterface {
  String url();
  Future<Response> request();
  String httpMethod();
  Map<String, String?> queryParameters();
  Map<String, Object?> bodyParameters();
  bool requiresAuthorization();
}

class OperationRequestBuilder<T> implements RequestBuilderInterface {
  T model;

  OperationRequestBuilder(this.model);

  @override
  Future<Response> request() {
    final uri =
        Uri.parse(this.url()).replace(queryParameters: this.queryParameters());
    switch (this.httpMethod()) {
      case HTTPMethod.get:
        {
          return get(uri, headers: this.httpHeaders());
        }
      case HTTPMethod.post:
        {
          return post(uri,
              body: jsonEncode(this.bodyParameters()),
              headers: this.httpHeaders());
        }
      case HTTPMethod.put:
        {
          return put(uri,
              body: jsonEncode(this.bodyParameters()),
              headers: this.httpHeaders());
        }
      case HTTPMethod.delete:
        {
          return delete(uri,
              body: jsonEncode(this.bodyParameters()),
              headers: this.httpHeaders());
        }
      case HTTPMethod.patch:
        {
          return patch(uri,
              body: jsonEncode(this.bodyParameters()),
              headers: this.httpHeaders());
        }
      default:
        {
          throw UnsupportedError("Unsupported HTTP method");
        }
    }
  }

  @override
  Map<String, Object?> bodyParameters() {
    return {};
  }

  @override
  String httpMethod() {
    return HTTPMethod.get;
  }

  @override
  Map<String, String?> queryParameters() {
    return {"lang": "en"};
  }

  @override
  bool requiresAuthorization() {
    return false;
  }

  @override
  String url() {
    return "";
  }

  Map<String, String> httpHeaders() {
    final headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json"
    };
    if (this.requiresAuthorization()) {
      headers[HttpHeaders.authorizationHeader] = "Bearer token";
    }
    return headers;
  }
}
