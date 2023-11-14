import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

///This is just a don't repeat yourself function
///to process network responses

Future<T> processResponse<T>({
  ///this is the response object
  required Response response,

  ///this is the function used to do the serialization.
  required T Function(dynamic) serializer,

  ///This is the code to check for in the response.
  int successCode = 200,

  //The map is the error serialized.
  Exception Function(dynamic)? serializeError,
}) async {
  log(response.statusCode.toString());
  log(response.body.toString());
  final data = await json.decode(response.body);
  log(data.toString());

  if (response.statusCode < (successCode + 100)) {
    try {
      return serializer(data);
    } on Exception catch (_) {
      rethrow;
    }
  } else {
    if (serializeError != null) {
      throw serializeError(data);
    } else {
      final Map errors = data;
      // log(errors.toString());
      final errorList = [];
      try {
        if (errors.keys.contains('detail')) {
          //handle password error message appearing in list
          //issue
          //remove if resolved from the backend.
          errorList.add(errors['detail']);
          throw Exception(errorList[0]);
        } else if (errors.keys.isNotEmpty) {
          for (String errorKey in errors.keys) {
            errorList.add('$errorKey:${errors[errorKey]}');
          }
        }
        //ThrowErrorList or Throw Exception
        else if (errorList.isNotEmpty) {
          throw Exception(errorList);
        } else {
          throw Exception(response.statusCode);
        }
        throw Exception(errorList);
      } on Exception catch (_) {
        rethrow;
      }
    }
  }
}
