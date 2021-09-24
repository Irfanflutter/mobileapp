import 'package:coronavirus_tracking_app/Model/endpoint_data.dart';
import 'package:coronavirus_tracking_app/Model/endpoint_enum.dart';
import 'package:coronavirus_tracking_app/Model/endpoints_data.dart';
import 'package:coronavirus_tracking_app/Services/api_services.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

class DataRepository {
  DataRepository({@required this.apiService});
  final APIServices apiService;

  String _accessToken;

  Future<EndpointData> getEndpointData(Endpoints endpoint) async =>
      await _getDataRefreshingToken<EndpointData>(
        onGetData: () => apiService.getEndpointData(
            accessToken: _accessToken, endpoint: endpoint),
      ); 

  Future<EndpointsData> getAllEndpointsData() async =>
      await _getDataRefreshingToken<EndpointsData>(
        onGetData: _getAllEndpointsData,
      );

  Future<T> _getDataRefreshingToken<T>({Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      return await onGetData();
    } on Response catch (response) {
      // if unauthorized, get access token again
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await onGetData();
      }
      rethrow;
    }
  }

  Future<EndpointsData> _getAllEndpointsData() async {
    final vlaues = await Future.wait([
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoints.cases),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoints.casesSuspected),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoints.casesConfirmed),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoints.deaths),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoints.recovered),
    ]);
    return EndpointsData(values: {
      Endpoints.cases: vlaues[0],
      Endpoints.casesSuspected: vlaues[1],
      Endpoints.casesConfirmed: vlaues[2],
      Endpoints.deaths: vlaues[3],
      Endpoints.recovered: vlaues[4],
    });
  }
}
