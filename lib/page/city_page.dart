import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:f_location/bo/city.dart';
import 'package:f_location/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CityPage extends StatefulWidget {
  const CityPage({Key? key}) : super(key: key);

  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  late StreamController<List<City>> _streamControllerListCitys;
  late Stream<List<City>> _streamCitys;

  @override
  void initState() {
    super.initState();
    _streamControllerListCitys = StreamController<List<City>>();
    _streamCitys = _streamControllerListCitys.stream;
    fetchCitys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Location - City"),
        ),
        body: StreamBuilder<List<City>>(
            stream: _streamCitys,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Icon(Icons.error));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.separated(
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                          thickness: 1,
                        ),
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(ROUTE_HOUSING_PAGE,
                                arguments: snapshot.data![index].id);
                          },
                          // onLongPress: () {},
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    "https://flutter-learning.mooo.com" +
                                        snapshot.data![index].image,
                                    fit: BoxFit.cover,
                                    height: 50,
                                    width: 100,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    snapshot.data![index].name,
                                    style: const TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
              }
            }));
  }

  void fetchCitys() async {
    Future<Response> resCitys =
        get(Uri.parse("https://flutter-learning.mooo.com/villes"));
    resCitys.then((value) {
      if (value.statusCode == 200) {
        String jsonBody = value.body;
        List<City> lsCitys = List.empty(growable: true);
        for (Map<String, dynamic> city in jsonDecode(jsonBody)) {
          lsCitys.add(City.fromJson(city));
        }
        _streamControllerListCitys.sink.add(lsCitys);
      }
    },
        onError: (_, err) =>
            log("Erreur lors du download des villes:" + err.toString()));
  }

  @override
  void dispose() {
    _streamControllerListCitys.close();
    super.dispose();
  }
}
