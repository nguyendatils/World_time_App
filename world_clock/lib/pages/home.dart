import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    String bgImage = data['isDayTime'] ? 'day_background.jpg' : 'night_background.jpg';
    Color _color = data['isDayTime'] ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: Colors.grey[200],

      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/$bgImage'),
                fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 100.0, 0, 0),
              child: Column(
                children: [
                  FlatButton.icon(
                      onPressed: () async {
                        dynamic result = await Navigator.pushNamed(context, '/location');
                        setState(() {
                          data = {
                            'location': result['location'],
                            'time': result['time'],
                            'flag': result['flag'],
                            'isDayTime': result['isDayTime'],
                          };
                        });
                      },
                      icon: Icon(Icons.edit_location, color: _color,),
                      label: Text(
                          'Choose location',
                        style: TextStyle(
                          color: _color
                        ),
                      )
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/${data['flag']}'),
                        radius: 70.0,
                      )
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['location'],
                        style: TextStyle(
                            fontSize: 30.0,
                            letterSpacing: 2.0,
                          color: _color
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['time'],
                        style: TextStyle(
                            fontSize: 60.0,
                            letterSpacing: 2.0,
                          color: _color
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}

