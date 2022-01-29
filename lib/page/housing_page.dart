import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:f_location/bo/housing.dart';
import 'package:f_location/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HousingPage extends StatefulWidget {
  final Object? arguments;
  const HousingPage(this.arguments, {Key? key}) : super(key: key);

  @override
  _HousingPageState createState() => _HousingPageState();
}

class _HousingPageState extends State<HousingPage> {
  late StreamController<List<Housing>> _streamControllerListHousings;
  late Stream<List<Housing>> _streamHousings;

  @override
  void initState() {
    super.initState();
    _streamControllerListHousings = StreamController<List<Housing>>();
    _streamHousings = _streamControllerListHousings.stream;
    fetchHousings(widget.arguments.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Location - Housing"),
        ),
        body: StreamBuilder<List<Housing>>(
            stream: _streamHousings,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Icon(Icons.error));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              ROUTE_HOUSING_DETAIL_PAGE,
                              arguments: snapshot.data![index]);
                        },
                        // onLongPress: () {},
                        child: Card(
                          color: Colors.white,
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                          margin: const EdgeInsets.all(24),
                          child: ListTile(
                            dense: true,
                            minLeadingWidth: 0,
                            horizontalTitleGap: 0,
                            contentPadding: const EdgeInsets.all(0),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Hero(
                                    tag: "image" + snapshot.data![index].image,
                                    child: ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(16)),
                                        child: Image.network(
                                          "https://flutter-learning.mooo.com" +
                                              snapshot.data![index].image,
                                          fit: BoxFit.cover,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    snapshot.data![index].title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(snapshot.data![index].price + "€/Nuit"),
                                  const Text("Note: 4.3/5"),
                                ]),
                          ),
                        )));
              }
            }));
  }

  void fetchHousings(cityId) async {
    Future<Response> resHousings = get(Uri.parse(
        "https://flutter-learning.mooo.com/logements?place.id=" + cityId));
    resHousings.then((value) {
      if (value.statusCode == 200) {
        String jsonBody = value.body;
        List<Housing> lsHousings = List.empty(growable: true);
        for (Map<String, dynamic> housing in jsonDecode(jsonBody)) {
          lsHousings.add(Housing.fromJson(housing));
        }
        _streamControllerListHousings.sink.add(lsHousings);
      }
    },
        onError: (_, err) =>
            log("Erreur lors du download des logements:" + err.toString()));
  }

  @override
  void dispose() {
    _streamControllerListHousings.close();
    super.dispose();
  }
}
