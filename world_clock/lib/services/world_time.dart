import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String city;
  String time;
  String flag;
  String url;
  String temperature;
  String weather;
  bool isDayTime;

  WorldTime(String location, String city, String flag, String url){
    this.location = location;
    this.city = city;
    this.flag = flag;
    this.url = url;
  }

  Future<void> getTime() async {

    try{
      //make request
      Response time_res = await get('http://worldtimeapi.org/api/timezone/$url');
      Response weather_res =await get('http://api.weatherstack.com/current?access_key=85e843ca399b25614b847acfc6bef091&query=$city');

      Map data_time = jsonDecode(time_res.body);
      Map data_weather = jsonDecode(weather_res.body);

      //get data properties
      String datetime = data_time['datetime'];
      String offset = data_time['utc_offset'].substring(0,3);

      //get time
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set time
      isDayTime = now.hour > 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);

      //set weather
      temperature = data_weather['current']['temperature'].toString();
      weather = data_weather['current']['weather_descriptions'][0];
    }
    catch (e) {
      print('catch error: $e');
      // time = '00:00';
    }

  }
}