class Connection {
  String fromPhone;
  String toPhone;
  int dist;

  Connection(
      {required this.fromPhone, required this.toPhone, required this.dist});

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
      fromPhone: json['fromPhone'] as String,
      toPhone: json['toPhone'] as String,
      dist: json['dist'] as int,
    );
  }
}
