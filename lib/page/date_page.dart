import 'package:flutter/material.dart';

class DatePage extends StatefulWidget {
  final List<dynamic> dates;
  const DatePage(this.dates, {Key? key}) : super(key: key);

  @override
  _DatePageState createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  late List<dynamic> dates;

  @override
  void initState() {
    dates = widget.dates;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Location - Select your date"),
        ),
        body: ListView.separated(
          itemCount: dates.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(
            thickness: 1,
          ),
          itemBuilder: (context, index) => InkWell(
            onTap: () {},
            // onLongPress: () {},
            child: ListTile(
                title: Text(
              dates[index],
              style: const TextStyle(fontSize: 20.0),
            )),
          ),
        ));
  }
}
