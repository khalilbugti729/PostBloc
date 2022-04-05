import 'dart:convert';

class PostModel {
  final String name;
  final int age;
  bool isLike;
  PostModel({required this.age, required this.name, required this.isLike});
  factory PostModel.fromJson(Map<String, dynamic> jsonData) {
    return PostModel(
      
      name: jsonData['name'],
      age: jsonData['age'],
      isLike: jsonData["isLike"],
    );
  }

  static Map<String, dynamic> toMap(PostModel post) => {
        'name': post.name,
        'age': post.age,
        'isLike': post.isLike,
      
      };

  static String encode(List<PostModel> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>((music) => PostModel.toMap(music))
            .toList(),
      );

  static List<PostModel> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<PostModel>((item) => PostModel.fromJson(item))
          .toList();

}
