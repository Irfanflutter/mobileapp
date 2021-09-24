import 'package:coronavirus_tracking_app/Repository/data_repository.dart';
import 'package:coronavirus_tracking_app/Services/api.dart';
import 'package:coronavirus_tracking_app/Services/api_services.dart';
import 'package:coronavirus_tracking_app/UI/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIServices(API.sandbox()),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Coronavirus Outbreak",
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xff101010),
          cardColor: Color(0xff222222),
        ),
        home: DashBoard(),
      ),
    );
  }
}
