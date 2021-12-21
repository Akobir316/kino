import 'dart:convert';
import 'dart:io';

enum ApiClientExceptionType { Network, Auth, Other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = 'a74488f12da314d464641a7bc749f1d3';

  Uri _makeUri(String path, [Map<String, dynamic>? parametrs]) {
    final uri = Uri.parse('$_host$path');
    if (parametrs != null) {
      return uri.replace(queryParameters: parametrs);
    }
    return uri;
  }

  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final request_token = await _makeToken();
    final validatedToken = await _validateUser(
      username: username,
      password: password,
      requestToken: request_token,
    );
    final sessionId = await _makeSession(requestToken: validatedToken);
    return sessionId;
  }

  Future<String> _makeToken() async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/authentication/token/new?api_key=a74488f12da314d464641a7bc749f1d3');
    final request = await _client.getUrl(url);
    final response = await request.close();
    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    final token = json['request_token'] as String;
    return token;
  }

  Future<String> _validateUser(
      {required String username,
      required String password,
      required String requestToken}) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=a74488f12da314d464641a7bc749f1d3');
    final parametrs = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken,
    };
    final request = await _client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parametrs));
    final response = await request.close();

    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    final token = json['request_token'] as String;
    return token;
  }

//d9cc5a361bcf6a1f6d84b80f821738d8768dda11
  Future<String> _makeSession({required String requestToken}) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/authentication/session/new?api_key=a74488f12da314d464641a7bc749f1d3');
    final parametrs = <String, dynamic>{
      'request_token': requestToken,
    };
    final request = await _client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parametrs));
    final response = await request.close();

    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    final sessinId = json['session_id'] as String;
    return sessinId;
  }
}
