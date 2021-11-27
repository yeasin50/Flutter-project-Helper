import "dart:io";
import "dart:convert"; 

void main(){
  String data='hey amigo';
  
  for(int i =0; i<100;i++){
    data +="heyyyyyy\r\n";
  }
  print(data.length);
  
  var original = utf8.encode(data);
  var compressed = gzip.encode(original);
  
  
  var depressed = gzip.decode(compressed);
  
  
  print(original.length);
  print(compressed.length);
  print(depressed.length);
}