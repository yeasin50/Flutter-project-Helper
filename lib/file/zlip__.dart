import 'dart:io';
import 'dart:convert';

main() {
  int  z= testCompress(zlib);
  int g = testCompress(gzip);

  print("zlib $z\n gzip $g ");
}

String generateData() {
  String data = '';
  for (int i = 0; i < 10000; i++) {
    data += "Hello world\r\n";
  }
  return data;
}

int testCompress(var codec) {
  String data = generateData();
  List original = utf8.encode(data);
  List compressed = codec.encode(original);
  List decompressed = codec.decode(compressed);

  print("Testing ${codec.toString()}");
  print("original ${original.length}");
  print("compressed ${compressed.length}");
  print("decompressed ${decompressed.length}");
  print("");
  String decoded = utf8.decode(compressed);
  print("match " + decoded == data);

  return compressed.length;
}
