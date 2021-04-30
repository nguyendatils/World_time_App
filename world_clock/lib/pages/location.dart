import 'package:flutter/material.dart';
import 'package:world_clock/services/world_time.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {

  List<WorldTime> locations = [
    WorldTime('London', 'London', 'england.png', 'Europe/London'),
    WorldTime('Berlin', 'Berlin', 'germany.png', 'Europe/Berlin'),
    WorldTime('Seoul', 'Seoul', 'korea.png', 'Asia/Seoul'),
    WorldTime('HaNoi', 'Ho_Chi_Minh', 'vietnam.png', 'Asia/Ho_Chi_Minh'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'isDayTime': instance.isDayTime,
      'temperature': instance.temperature,
      'weather': instance.weather,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        title: Text('Choose location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                updateTime(index);
              },
              title: Text(locations[index].location),
              leading: CircleAvatar(
                backgroundImage: AssetImage('images/${locations[index].flag}'),
              ),
            ),
          );
        },
      )
    );
  }
}
