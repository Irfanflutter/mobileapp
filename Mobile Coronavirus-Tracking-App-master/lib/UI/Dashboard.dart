import 'package:coronavirus_tracking_app/Model/endpoint_enum.dart';
import 'package:coronavirus_tracking_app/Repository/data_repository.dart';
import 'package:coronavirus_tracking_app/Model/endpoints_data.dart';
import 'package:coronavirus_tracking_app/Widget/LastUpdateDateFormater.dart';
import 'package:coronavirus_tracking_app/Widget/LastUpdatedStatus.dart';
import 'package:coronavirus_tracking_app/Widget/dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  EndpointsData _endpointsData;

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endpointData = await dataRepository.getAllEndpointsData();
    setState(() {
      _endpointsData = endpointData;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdateDateFormater(
      lastupdatedDate: _endpointsData!=null ? _endpointsData.values[Endpoints.cases].date : null
    ) ;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Coronavirus Tracker"),
        ),
        body: RefreshIndicator(
          onRefresh: _updateData,
          child: ListView(
            children: [
              LastUpdatedStatus(
                text: formatter.lastUpdatedStatusText(),
              ),
              for (var endpoint in Endpoints.values)
                DashboardCard(
                    endpoints: endpoint,
                    value: _endpointsData != null
                        ? _endpointsData.values[endpoint].value
                        : null),
            ],
          ),
        ));
  }
}
