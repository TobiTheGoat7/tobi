import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:outt/core/api/api_endpoints.dart';
import 'package:outt/core/network_request/network_request.dart';
import 'package:outt/core/network_retry/network_retry.dart';
import 'package:outt/core/runner/response_processor.dart';
import 'package:outt/features/create_event/models/event_details_full_dto.dart';
import 'package:outt/services/authmanager/authmanager.dart';

final createEventRemoteProvider =
    Provider<CreateEventRemoteSource>((ref) => CreateEventRemoteSourceI(
          networkRequest: ref.read(networkRequestProvider),
          networkRetry: ref.read(networkRetryProvider),
        ));

abstract class CreateEventRemoteSource {
  Future<bool> createEvent(EventFullDetailsDTO createEventFullData);
}

class CreateEventRemoteSourceI implements CreateEventRemoteSource {
  final NetworkRequest networkRequest;
  final NetworkRetry networkRetry;

  CreateEventRemoteSourceI({
    required this.networkRequest,
    required this.networkRetry,
  });

  @override
  Future<bool> createEvent(EventFullDetailsDTO createEventFullData) async {
    String url = Endpoint.createEventEndpointPOST;

    String peopleAttending = createEventFullData
                .eventPartialDetailsDTO.numberOfAttenddees
                .trim() ==
            'A lot'
        ? '1000'
        : createEventFullData.eventPartialDetailsDTO.numberOfAttenddees.trim();
    //TODO; Don't hardcode timezone offset.
    final body = {
      'name': createEventFullData.eventPartialDetailsDTO.eventName,
      'type': createEventFullData.eventPartialDetailsDTO.publicOrPrivate
          .toLowerCase(),
      'event_datetime':
          '${createEventFullData.eventPartialDetailsDTO.eventDateTime.toIso8601String()}000+01:00',
      'video_url':
          createEventFullData.eventPartialDetailsDTO.eventUploadedVideoUrl,
      'people_attending': peopleAttending,
      'location':
          createEventFullData.eventPartialDetailsDTO.eventAddress.address,
      'photos': [
        {
          "url_one": createEventFullData.imageUrls[0],
          if (createEventFullData.imageUrls.length > 1)
            "url_two": createEventFullData.imageUrls[1],
          if (createEventFullData.imageUrls.length > 2)
            "url_three": createEventFullData.imageUrls[2],
          if (createEventFullData.imageUrls.length > 3)
            "url_four": createEventFullData.imageUrls[3]
        },
      ],
      'access': {
        'access_id': createEventFullData.eventAccess.eventAccessId,
        'price': createEventFullData.eventAccess.price,
      },
      'status': 'active'
    };

    final token = (await AuthManager.instance.getAuthenticatedUser())!.token;

    final response = await networkRetry.networkRetry(
      () => networkRequest.post(
        url,
        body: json.encode(body),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      ),
    );

    log('request made');

    return processResponse(
        successCode: 201,
        response: response,
        serializer: (data) {
          return true;
        });
  }
}
