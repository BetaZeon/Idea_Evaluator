import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  Map _Events = {
    'Event-1' : 'Dextrix 1.0', 'Event-2' : 'Dexterix 2.0', 'Event-3' : 'Dexterix 3.0'
  };
  @override
  Widget build(BuildContext context) {
    final String imgUrl = 'https://scontent-del1-1.xx.fbcdn.net/v/t1.0-9/s960x960/47076705_300676554111412_2898229581855064064_o.jpg?_nc_cat=105&_nc_ohc=27HKn-5Yso8AX8G2I3p&_nc_ht=scontent-del1-1.xx&_nc_tp=7&oh=a7a95b441fc38e1039649758b583a9d9&oe=5EFC361E';
    final String drawerImgUrl = 'https://ak9.picdn.net/shutterstock/videos/1024107419/thumb/1.jpg';
    return Scaffold(
      appBar: AppBar(
      title: const Text('Upcoming Events'),
      centerTitle: false,
      elevation: 0.0,
      backgroundColor: Colors.blue,
    ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(drawerImgUrl),
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(imgUrl),
              ),
              accountEmail: Text('ashwanitripathi144@gmail.com',
                style: TextStyle(color: Colors.black),),
              accountName: Text(
                'Ashwani Tripathi', style: TextStyle(color: Colors.black),),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.account_circle),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.of(context).pushReplacementNamed('/home');
              },
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
              onTap: () {
                //Update the state of the app.
                // ...
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.settings_power),
              onTap: () {
                //Update the state of the app.
                //...
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: eventList(),
    );
  }

  Widget eventList() {
    List keys = _Events.keys.toList();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _Events[0] == 'Empty'
              ? Expanded(child: Text(
            'There are no Events', style: TextStyle(color: Colors.red),),)
              : Expanded(
            child: ListView.builder(
              itemCount: keys.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      onTap: () {},
                      title: Row(
                        children: <Widget>[
                          Expanded(child: Text('${_Events[keys[index]]}',
                            style: TextStyle(color: Colors.cyan),)),
                          Icon(Icons.forward, color: Colors.grey[700],)
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
