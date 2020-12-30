import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

// this isnot google MAP, I dont have google api-key
// OpenStreet is openSource , so Im using it for practice section, there are some down-sides in it.
class OpenStreetWithCord extends StatefulWidget {
  OpenStreetWithCord({Key key}) : super(key: key);

  @override
  _OpenStreetState createState() => _OpenStreetState();
}

class _OpenStreetState extends State<OpenStreetWithCord> {
  MapController mapController;
  Map<String, LatLng> coords;
  List<Marker> markers;

  @override
  void initState() {
    super.initState();

    mapController = MapController();
    coords = Map<String, LatLng>();

    coords.putIfAbsent("Manikgonj", () => LatLng(23.861650, 90.000320));
    coords.putIfAbsent("Pitul", () => LatLng(23.811162, 90.003778));
    coords.putIfAbsent("Ghiur", () => LatLng(23.870828, 89.916917));

    markers = List<Marker>();

    for (int i = 0; i < coords.length; i++) {
      markers.add(Marker(
          width: 80,
          height: 80,
          point: coords.values.elementAt(i),
          builder: (ctx) => Icon(
                Icons.pin_drop,
                color: Colors.yellow,
              )));
    }
  }

  void _showCoord(int index) {
    mapController.move(coords.values.elementAt(index), 10.0);
  }

  List<Widget> _makeButtons() {
    List<Widget> list = new List<Widget>();

    for (int i = 0; i < coords.length; i++) {
      list.add(new RaisedButton(
        onPressed: () => _showCoord(i),
        child: new Text(
          coords.keys.elementAt(i),
        ),
      ));
    }
    return list;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map '),
      ),
      body: Container(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                //FIXME:: buttons arent showing, need to reInstall
                Row(children: _makeButtons()),
                buildFlexibleMap(),
              ],
            ),
          )),
    );
  }

  Flexible buildFlexibleMap() {
    return Flexible(
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(23.861650, 90.000320),
          zoom: 5,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(markers: markers),
        ],
      ),
    );
  }
}
