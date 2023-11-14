import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:outt/core/api/api_endpoints.dart';
import 'package:outt/services/authmanager/authmanager.dart';

final uploadFileRemoteSourceProvider = Provider<UploadFileRemoteSource>((ref) {
  return UploadFileRemoteSourceI();
});

typedef OnUploadProgressCallback = void Function(int sentBytes, int totalBytes);

abstract class UploadFileRemoteSource {
  // late StreamSubscription<double> progressStream;

  Future<String> uploadEventVideo(
    File file, {
    OnUploadProgressCallback? onUploadProgressCallback,
  });

  Future<List<String>> uploadListOfImages(
    List<File> images, {
    OnUploadProgressCallback? onUploadProgressCallback,
  });
}

class UploadFileRemoteSourceI implements UploadFileRemoteSource {
  // late StreamSubscription<double> progressStream;
  static HttpClient httpClient = HttpClient();

  @override
  Future<String> uploadEventVideo(
    File file, {
    OnUploadProgressCallback? onUploadProgressCallback,
  }) async {
    int byteCount = 0;
    final url = Uri.parse(Endpoint.uploadEventVideoEndpointPost);
    final request = await httpClient.postUrl(url);

    final token = (await AuthManager.instance.getAuthenticatedUser())!.token;

    var multiPart = await http.MultipartFile.fromPath('file', file.path);

    var requestMultipart = http.MultipartRequest('POST', url);

    requestMultipart.files.add(multiPart);
    requestMultipart.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    requestMultipart.headers[HttpHeaders.contentTypeHeader] =
        'application/json';

    var msStream = requestMultipart.finalize();

    var totalByteLength = requestMultipart.contentLength;

    request.contentLength = totalByteLength;

    request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');
    request.headers.set(HttpHeaders.contentTypeHeader,
        requestMultipart.headers[HttpHeaders.contentTypeHeader]!);

    Stream<List<int>> streamUpload = msStream.transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          sink.add(data);

          byteCount += data.length;

          if (onUploadProgressCallback != null) {
            onUploadProgressCallback(byteCount, totalByteLength);
            // CALL STATUS CALLBACK;
          }
        },
        handleError: (error, stack, sink) {
          throw error;
        },
        handleDone: (sink) {
          sink.close();
          // UPLOAD DONE;
        },
      ),
    );

    await request.addStream(streamUpload);

    final HttpClientResponse httpResponse = await request.close();

    final stringData = await httpResponse.transform(utf8.decoder).join();

    final data = json.decode(stringData);

    if (httpResponse.statusCode < 300) {
      return data['data']['url'];
    } else {
      final message = data['detail']['message'];
      throw Exception(message);
    }
  }

  @override
  Future<List<String>> uploadListOfImages(List<File> images,
      {OnUploadProgressCallback? onUploadProgressCallback}) async {
    int byteCount = 0;
    List<String> fileUrl = [];
    List<http.MultipartFile> listOfMultiParts = [];
    final url = Uri.parse(Endpoint.uploadImagesEndpointPost);

    final token = (await AuthManager.instance.getAuthenticatedUser())!.token;

    //Begin upload of one file
    for (File image in images) {
      print(image.path);
      var multiPart = await http.MultipartFile.fromPath('file', image.path);
      listOfMultiParts.add(multiPart);
    }
    var getContentSizeMultipart = http.MultipartRequest('POST', url);
    getContentSizeMultipart.files.addAll(listOfMultiParts);

    var totalByteLength = getContentSizeMultipart.contentLength;

    for (http.MultipartFile multipart in listOfMultiParts) {
      final request = await httpClient.postUrl(url);
      var requestMultipart = http.MultipartRequest('POST', url);
      requestMultipart.files.add(multipart);
      requestMultipart.headers[HttpHeaders.authorizationHeader] =
          'Bearer $token';
      requestMultipart.headers[HttpHeaders.contentTypeHeader] =
          'application/json';
      var msStream = requestMultipart.finalize();
      request.contentLength = requestMultipart.contentLength;
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');
      request.headers.set(HttpHeaders.contentTypeHeader,
          requestMultipart.headers[HttpHeaders.contentTypeHeader]!);

      Stream<List<int>> streamUpload = msStream.transform(
        StreamTransformer.fromHandlers(
          handleData: (data, sink) {
            sink.add(data);

            byteCount += data.length;

            if (onUploadProgressCallback != null) {
              onUploadProgressCallback(byteCount, totalByteLength);
              // CALL STATUS CALLBACK;
            }
          },
          handleError: (error, stack, sink) {
            throw error;
          },
          handleDone: (sink) {
            sink.close();
            // UPLOAD DONE;
          },
        ),
      );

      await request.addStream(streamUpload);
      final HttpClientResponse httpResponse = await request.close();
      final stringData = await httpResponse.transform(utf8.decoder).join();
      final data = json.decode(stringData);
      log(data.toString());
      if (httpResponse.statusCode < 300) {
        final String imageUrl = data['data']['url'];
        fileUrl.add(imageUrl);
      } else {
        final message = data['detail']['message'];
        throw Exception(message);
      }
    }

    return fileUrl;
  }
}
