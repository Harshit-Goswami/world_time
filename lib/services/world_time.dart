import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for UI
  late String time; // the time in that location
  String flag; // url to an asset flag icon
  String url;
  late bool isDaytime;

  WorldTime(
      {required this.location,
      required this.flag,
      required this.url}); // location url for api endpoint

  Future<void> getTime() async {
    // make the request
    // try {
    Response response =
        await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    Map data = jsonDecode(response.body);
    // get properties from json
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);

    // create DateTime object
    DateTime now = DateTime.parse(datetime);
    isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
    now = now.add(Duration(hours: int.parse(offset)));

    // set the time property
    time = DateFormat.jm().format(now);
    // } catch (e) {
    //   print(e);
    // }
  }
}
