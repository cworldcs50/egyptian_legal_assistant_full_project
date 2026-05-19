import 'dart:convert';
import '../error/exceptions.dart';
import 'package:http/http.dart' as http;


abstract class ApiClient {
  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
  });
  Future<dynamic> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  });

  Stream<String> streamPost(
    String url, {
    Map<String, String>? headers,
    Object? body,
  });
}

class AppHttpApiClient implements ApiClient {
  const AppHttpApiClient({required this.client});

  final http.Client client;

  Map<String, String> _getHeaders(Map<String, String>? extraHeaders) => {
    "Accept": "application/json",
    "Content-Type": "application/json",
    ...?extraHeaders,
  };

  dynamic _handlingResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        throw const ServerException(
          message:
              "Error in handling data come from server (json format error)",
        );
      }
    } else {
      try {
        final errorBody = jsonDecode(response.body);

        throw ServerException(
          message:
              errorBody['message'] ??
              "Error From Server: ${response.statusCode}",
        );
      } catch (e) {
        throw ServerException(
          message: "Unexpected Error from server ${response.statusCode}",
        );
      }
    }
  }

  @override
  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
  }) async {
    final Uri uri = Uri.parse(url).replace(queryParameters: parameters);

    final http.Response response = await client.get(
      uri,
      headers: _getHeaders(headers),
    );

    return _handlingResponse(response);
  }

  @override
  Future<dynamic> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final Uri uri = Uri.parse(url);

    final http.Response response = await client.post(
      uri,
      headers: _getHeaders(headers),
      body: body != null ? jsonEncode(body) : null,
    );

    return _handlingResponse(response);
  }

  @override
  Stream<String> streamPost(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async* {
    final Uri uri = Uri.parse(url);
    final request = http.Request("POST", uri);
    
    request.headers.addAll(_getHeaders(headers));
    if (body != null) {
      request.body = jsonEncode(body);
    }

    final response = await client.send(request);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      yield* response.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter());
    } else {
      throw ServerException(
        message: "Error From Server: ${response.statusCode}",
      );
    }
  }
}
