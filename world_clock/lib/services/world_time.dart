import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime(String location, String flag, String url){
    this.location = location;
    this.flag = flag;
    this.url = url;
  }

  Future<void> getTime() async {

    try{
      //make request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      //get data properties
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0,3);

      //get time
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set time
      isDayTime = now.hour > 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('catch error: $e');
      time='could not load';
    }

  }
}