import 'package:coronavirus_tracking_app/Model/endpoint_data.dart';
import 'package:coronavirus_tracking_app/Model/endpoint_enum.dart';
import 'package:flutter/cupertino.dart';

class EndpointsData {
  EndpointsData({@required this.values});
  final Map<Endpoints, EndpointData> values;

  EndpointData get cases => values[Endpoints.cases];
  EndpointData get casesSuspected => values[Endpoints.casesSuspected];
  EndpointData get casesConfirmed => values[Endpoints.casesConfirmed];
  EndpointData get deaths => values[Endpoints.deaths];
  EndpointData get recovered => values[Endpoints.recovered];

  @override
  String toString() =>
      "cases: $cases casesSuspected: $casesSuspected casesConfirmed: $casesConfirmed deaths: $deaths recovered:$recovered";
}
