import 'dart:async';

import 'dart:convert';

class Radio {
  final int id;
  final String radioName;
  final String radioUrl;
  final String radioDesc;
  final String radioShortDesc;
  final String radioWebsite;
  final String radioPic;

  Radio(
      {this.id,
      this.radioName,
      this.radioUrl,
      this.radioDesc,
      this.radioShortDesc,
      this.radioWebsite,
      this.radioPic});

  factory Radio.fromJson(Map<String, dynamic> map) {
    return Radio(
      id: map['Id'],
      radioName: map['RadioName'],
      radioUrl: map['RadioUrl'],
      radioDesc: map['RadioDescription'],
      radioShortDesc: map['RadioShortDesc'],
      radioWebsite: map['RadioWebsite'],
      radioPic: map['RadioImg'],
    );
  }
}

void radio1() async {
  var jsno_string =
      '{"Data":[ {"Id":1, "RadioName":"Desi world Radio", "RadioUrl":"http://stream.zenolive.com/4mbfcn4mftv", "RadioDescription": "Delhi Radio",  "RadioShortDesc":null, "RadioWebsite":"http://www.desiworldradio.com", "RadioImg":"Pic_Url" }],"Message":"72","Result":1}';

  var jsonData = jsonDecode(jsno_string)["Data"] as List;
  List<Radio> radios = jsonData.map((radio) => Radio.fromJson(radio)).toList();

  radios.forEach((element) {
    print(element.radioName);
  });
}

main(List<String> args) {
  radio1();
}
