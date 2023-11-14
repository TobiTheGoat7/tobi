import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final networkRequestProvider =
    Provider<NetworkRequest>((ref) => NetworkRequestImpl());

abstract class NetworkRequest {
  Future<Response> get(
    String url, {
    Map<String, String>? headers,
  });
  Future<Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });

  Future<Response> patch(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });

  Future<Response> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });

  Future<Response> delete(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });
}

class NetworkRequestImpl implements NetworkRequest {
  factory NetworkRequestImpl() => _instance;
  NetworkRequestImpl._();
  static final NetworkRequestImpl _instance = NetworkRequestImpl._();

  @override
  Future<Response> get(
    String url, {
    Map<String, String>? headers,
  }) {
    return Client()
        .get(Uri.parse(url), headers: headers)
        .timeout(const Duration(seconds: 17), onTimeout: () {
      throw TimeoutException('Time Out Error');
    });
  }

  @override
  Future<Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return Client().post(
      Uri.parse(url),
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }

  @override
  Future<Response> patch(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return Client().patch(Uri.parse(url),
        headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<Response> put(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return Client()
        .put(Uri.parse(url), headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<Response> delete(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return Client().delete(Uri.parse(url),
        headers: headers, body: body, encoding: encoding);
  }
}
