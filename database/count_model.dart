class Count {
  late int id;
  late int count;

  Count(this.count, this.id);

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
