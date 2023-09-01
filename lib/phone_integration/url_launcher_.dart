import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLuncher extends StatefulWidget {
  UrlLuncher({Key key}) : super(key: key);

  @override
  _UrlLuncherState createState() => _UrlLuncherState();
}

class _UrlLuncherState extends State<UrlLuncher> {
  void _showUrl() {
    _launch("http://127.1.0.1");
  }

  void _showEmail() {
    _launch("mailto:yello@gmail.com");
  }

  void _showTelephone() {
    _launch("tel:92328934");
  }

  void _showSms() {
    _launch('sms:12399299');
  }

  void _launch(String urlString) async {
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else
      throw "Couldn't launch url.";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          RaisedButton(
            onPressed: _showUrl,
            child: Text("url"),
          ),
          RaisedButton(
            onPressed: _showEmail,
            child: Text("Email"),
          ),
          RaisedButton(
            onPressed: _showSms,
            child: Text("SMS"),
          ),
          RaisedButton(
            onPressed: _showTelephone,
            child: Text("Tele/Call"),
          ),
        ],
      ),
    );
  }
}
