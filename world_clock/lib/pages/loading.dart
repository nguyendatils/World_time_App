import 'package:flutter/material.dart';
import 'package:world_clock/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  void setWorldTime() async {
    WorldTime instance = WorldTime('Ho Chi Minh', 'vietnam.png', 'Asia/Ho_Chi_Minh');
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'isDayTime': instance.isDayTime
    });
  }

  @override
  void initState() {
    super.initState();
    setWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitDualRing(
              color: Colors.white,
            ),
            SizedBox(height: 20,),
            Text(
              'LOADING',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            )
          ]
        )
      ),
    );
  }
}
