// ignore_for_file: public_member_api_docs, sort_constructors_first
class AlbumModel {
  int userID;
  int albumID;
  String title;
  AlbumModel({
    required this.userID,
    required this.albumID,
    required this.title,
  });

  factory AlbumModel.fromJSon(Map<String, dynamic> json) {
    return AlbumModel(
        userID: json['userId'], albumID: json['id'], title: json['title']);
  }
}
