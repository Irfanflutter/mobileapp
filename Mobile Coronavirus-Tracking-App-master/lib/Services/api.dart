import 'package:coronavirus_tracking_app/Model/endpoint_enum.dart';
import 'package:coronavirus_tracking_app/Services/api_key.dart';
import 'package:flutter/foundation.dart';


class API {

  API({@required this.apiKey});
  final String apiKey;

  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);

  static final String host = 'ncov2019-admin.firebaseapp.com';

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        path: 'token',
      );

  Uri endpointUri(Endpoints endpoint) => Uri(
        scheme: 'https',
        host: host,
        path: _paths[endpoint],
      );

   static Map<Endpoints, String> _paths = {
    Endpoints.cases: 'cases',
    Endpoints.casesSuspected: 'casesSuspected',
    Endpoints.casesConfirmed: 'casesConfirmed',
    Endpoints.deaths: 'deaths',
    Endpoints.recovered: 'recovered',
  };
}
