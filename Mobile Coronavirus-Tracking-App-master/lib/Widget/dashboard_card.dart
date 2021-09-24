import 'package:coronavirus_tracking_app/Model/endpoint_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EndpointCardData {
  EndpointCardData({this.title, this.assetName, this.color});

  final String title;
  final String assetName;
  final Color color;
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({Key key, this.endpoints, this.value}) : super(key: key);
  final Endpoints endpoints;
  final int value;

  static Map<Endpoints, EndpointCardData> _cardData = {
    Endpoints.cases: EndpointCardData(
        assetName: 'images/count.png',
        color: Colors.amberAccent,
        title: "Total"),
    Endpoints.casesSuspected: EndpointCardData(
        assetName: 'images/suspect.png',
        color: Color(0xffffff492),
        title: "Suspected Cases"),
    Endpoints.casesConfirmed: EndpointCardData(
        assetName: 'images/fever.png',
        color: Colors.orange,
        title: "Confirmed Cases"),
    Endpoints.deaths: EndpointCardData(
        assetName: 'images/death.png',
        color: Colors.red,
        title: "Deaths Cases"),
    Endpoints.recovered: EndpointCardData(
        assetName: 'images/patient.png',
        color: Colors.green,
        title: "Recovered Cases")
  };

  String get formatedValue {
    if (value == null) {
      return '';
    }
    return NumberFormat('#,###,###,###').format(value);
  }

  @override
  Widget build(BuildContext context) {
    final cardData = _cardData[endpoints];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardData.title,
                // ignore: deprecated_member_use
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: cardData.color, fontSize: 18),
              ),
              SizedBox(
                height: 4.0,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(cardData.assetName, color: cardData.color),
                    Text(formatedValue,  
                      // ignore: deprecated_member_use
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: cardData.color),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
