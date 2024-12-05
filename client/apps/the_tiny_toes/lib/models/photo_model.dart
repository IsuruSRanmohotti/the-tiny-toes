class PhotoModel {
  int albumID;
  int id;
  String title;
  String url;
  String thumbnailUrl;
  PhotoModel({
    required this.albumID,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
        albumID: json['albumId'],
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl']);
  }
}
