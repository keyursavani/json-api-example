class Comments{
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comments({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  static Comments fromJson(json) =>  Comments (
    postId: json["postId"],
    id: json["id"],
    name: json['name'],
    email: json['email'],
    body: json['body'],
  );


}