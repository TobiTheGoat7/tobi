import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:outt/core/api/api_endpoints.dart';
import 'package:outt/core/network_request/network_request.dart';
import 'package:outt/core/network_retry/network_retry.dart';
import 'package:outt/core/runner/response_processor.dart';
import 'package:outt/features/feed/models/event.dart';
import 'package:outt/services/authmanager/authmanager.dart';

final feedRemoteSourceProvider =
    Provider<FeedRemoteSource>((ref) => FeedRemoteSourceI(
          networkRequest: ref.read(networkRequestProvider),
          networkRetry: ref.read(networkRetryProvider),
        ));

abstract class FeedRemoteSource {
  Future<List<EventFeedData>> getEvents();
}

class FeedRemoteSourceI implements FeedRemoteSource {
  final NetworkRequest networkRequest;
  final NetworkRetry networkRetry;

  FeedRemoteSourceI({
    required this.networkRequest,
    required this.networkRetry,
  });
  @override
  Future<List<EventFeedData>> getEvents() async {
    const url = Endpoint.getEventFeedDataGET;

    final token = (await AuthManager.instance.getAuthenticatedUser())!.token;

    final response = await networkRetry.networkRetry(
      () => networkRequest.get(
        url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      ),
    );

    return processResponse<List<EventFeedData>>(
        response: response,
        serializer: (data) {
          final list = data['data'] as List<dynamic>;

          return list.map((e) => EventFeedData.fromJson(e)).toList();
        });
  }
}
