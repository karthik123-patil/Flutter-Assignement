import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiProvider {
  Future<dynamic> userList() async {
    var responseJson;
    try {
      String url = "https://jsonplaceholder.typicode.com/users";
      final response = await http.get(Uri.parse(url),
        headers: <String, String> {
          HttpHeaders.contentTypeHeader : 'application/json',
        },
      );

      responseJson = json.decode(response.body.toString());
      //responseJson = _response(response);
    }on SocketException catch (e) {
      _errorBody(e.toString());
    } on TimeoutException catch (e) {
      _errorBody(e.toString());
    } on Exception catch (e) {
      _errorBody(e.toString());
    }

    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          var responseJson = json.decode(response.body.toString());
          return responseJson;
        }
      case 201:
        {
          var responseJson = json.decode(response.body.toString());
          return responseJson;
        }
      case 400:
        var responseJson = json.decode(response.body.toString());
        return _errorBody(responseJson);
      case 401:
        {
          return {
            'success': false,
            'message': 'Authorization failed. Login again',
            'subErrorCode': '401'
          };
        }
      case 403:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 404:
        return _errorBody(json.decode(response.body.toString()));
      case 500:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      default:
        return _errorBody('');
    }
  }

  _errorBody(String response) {
    return {
      'success': false,
      'message': 'Something went wrong.\nError Code - ' + response,
      'subErrorCode': response
    };
  }
}

