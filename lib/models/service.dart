class Service {
  String id = '';
  String title = '';
  String content = '';
  double fees = 0;
  String ownerId = '';

  Service();
  Service.value(this.content, this.title, this.fees, this.ownerId);

  fromMap({required Map<String, dynamic> map, String? id}) {
    content = map['content'];
    title = map['title'];
    fees = map['fees'];
    ownerId = map['ownerId'];
    this.id = id!;
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'title': title,
      'fees': fees,
      'ownerId': ownerId,
    };
  }
}
