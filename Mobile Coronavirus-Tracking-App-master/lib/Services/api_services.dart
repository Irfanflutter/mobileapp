import 'dart:convert';
import 'package:coronavirus_tracking_app/Model/endpoint_data.dart';
import 'package:coronavirus_tracking_app/Model/endpoint_enum.dart';
import 'package:coronavirus_tracking_app/Services/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APIServices {
  APIServices(this.api);
  final API api;

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri().toString(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print(
        'Request ${api.tokenUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  } 

   Future<EndpointData> getEndpointData({
    @required String accessToken,
    @required Endpoints endpoint, Endpoints endpoints,
  }) async {
    final uri = api.endpointUri(endpoint);
    final response = await http.get(
      uri.toString(),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> endpointData = data[0];
        final String responseJsonKey = _responseJsonKeys[endpoint];
        final int values = endpointData[responseJsonKey];
        final String dateString = endpointData['date'];
        final date = DateTime.tryParse(dateString);  
        if (values != null) {
          return EndpointData(value: values, date: date);
        }
      }
    }
    print(
        'Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }
 static Map<Endpoints, String> _responseJsonKeys = {
    Endpoints.cases: 'cases',
    Endpoints.casesSuspected: 'data',
    Endpoints.casesConfirmed: 'data',
    Endpoints.deaths: 'data',
    Endpoints.recovered: 'data',
  };
}
