import 'package:f_location/bo/housing.dart';
import 'package:f_location/page/city_page.dart';
import 'package:f_location/page/date_page.dart';
import 'package:f_location/page/home_page.dart';
import 'package:f_location/page/housing_detail_page.dart';
import 'package:f_location/page/housing_page.dart';
import 'package:f_location/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case ROUTE_HOUSING_PAGE:
            return MaterialPageRoute(
                builder: (_) => HousingPage(settings.arguments));
          case ROUTE_HOUSING_DETAIL_PAGE:
            return MaterialPageRoute(
                builder: (_) =>
                    HousingDetailPage(settings.arguments as Housing));
          case ROUTE_DATE:
            return MaterialPageRoute(
                builder: (_) => DatePage(settings.arguments as List<dynamic>));
          default:
            return MaterialPageRoute(builder: (_) => const HomePage());
        }
      },
      initialRoute: ROUTE_HOME_PAGE,
      routes: <String, WidgetBuilder>{
        ROUTE_HOME_PAGE: (_) => const HomePage(),
        ROUTE_CITY_PAGE: (_) => const CityPage(),
      },
    );
  }
}
