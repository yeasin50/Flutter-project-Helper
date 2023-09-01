import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

// this isnot google MAP, I dont have google api-key
// OpenStreet is openSource , so Im using it for practice section, there are some down-sides in it.
class OpenStreet extends StatefulWidget {
  OpenStreet({Key key}) : super(key: key);

  @override
  _OpenStreetState createState() => _OpenStreetState();
}

class _OpenStreetState extends State<OpenStreet> {

  
   var mj = LatLng(23.861650, 90.000320);
  Widget build(BuildContext context) {
    var markers = <Marker>[
      Marker(
          width: 80.0,
          height: 80.0,
          point: mj,
          builder: (ctx) => Icon(
                Icons.pin_drop,
                color: Colors.red,
              )),
      Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(23.827750, 89.977657),
          builder: (ctx) => Icon(
                Icons.pin_drop,
                color: Colors.pink,
              )),
      Marker(
          width: 80.0,
          height: 80.0,
          point:  LatLng(mj.latitude+.02, mj.longitude+.04),
          builder: (ctx) => Icon(
                Icons.pin_drop,
                color: Colors.red,
              )),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Map '),
      ),
      body: Container(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Flexible(
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(23.861650, 90.000320),
                      zoom: 10,
                    ),
                    layers: [
                      TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayerOptions(markers: markers),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
