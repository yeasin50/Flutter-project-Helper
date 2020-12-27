class Count {
  int id;
  int count;

  Count(this.count);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'id': id, 'counter': count};
    return map;
  }

  Count.fromMapObject(Map<String, dynamic> map) {
    print(map);
    id = map['id'] as int;
    count = map['counter'];
  }
}
