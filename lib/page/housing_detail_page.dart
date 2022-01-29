import 'package:f_location/bo/housing.dart';
import 'package:f_location/components/map.dart';
import 'package:f_location/routes.dart';
import 'package:flutter/material.dart';

class HousingDetailPage extends StatefulWidget {
  final Housing housing;
  const HousingDetailPage(this.housing, {Key? key}) : super(key: key);

  @override
  _HousingDetailPageState createState() => _HousingDetailPageState();
}

class _HousingDetailPageState extends State<HousingDetailPage> {
  late Housing housing;
  FloatingActionButtonLocation _fabLocation =
      FloatingActionButtonLocation.endDocked;
  bool _showFab = true;
  bool _showNotch = true;

  @override
  void initState() {
    housing = widget.housing;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location - Housing detail"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Hero(
                  tag: "image" + housing.image,
                  child: ClipRRect(
                      child: Image.network(
                    "https://flutter-learning.mooo.com" + housing.image,
                    fit: BoxFit.cover,
                  ))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  housing.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20.0),
                ),
              ),
              const Text("Note: 4.3/5", style: const TextStyle(fontSize: 16.0)),
              Text("Owner: " + housing.owner,
                  style: const TextStyle(fontSize: 16.0)),
              Container(
                  height: 400,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: MapComponent(housing.latLng)),
                  ))
            ],
          )
        ],
      ),
      floatingActionButtonLocation: _fabLocation,
      bottomNavigationBar:
          _BottomAppBar(fabLocation: _fabLocation, housing: housing),
    );
  }
}

class _BottomAppBar extends StatelessWidget {
  const _BottomAppBar({
    this.fabLocation = FloatingActionButtonLocation.endDocked,
    required this.housing,
  });

  final FloatingActionButtonLocation fabLocation;
  final Housing housing;

  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(
            housing.price + "€/Nuit",
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(ROUTE_DATE, arguments: housing.listDateAvailable);
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white)),
            child: const Text(
              'Réserver',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.blue,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
