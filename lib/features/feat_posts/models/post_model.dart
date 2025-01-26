class PostModel {
  final String id;
  final String? thumbnailUrl;
  final String videoUrl;
  final String? description;
  final List<String> mediaUrls;

  PostModel({
    required this.id,
    this.thumbnailUrl,
    this.videoUrl = '',
    required this.description,
    required this.mediaUrls,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final mediaFiles = <String>[];
    if (json['videoUrl'] != null) {
      mediaFiles.add(json['videoUrl']);
    }

    final images = List<String>.from(json['images'] ?? json['image'] ?? []);
    if (images.isNotEmpty) {
      mediaFiles.addAll(images);
    }

    return PostModel(
      id: json['id'],
      thumbnailUrl: json['thumbnailUrl'],
      videoUrl: json['videoUrl'] ?? '',
      description: json['description'],
      mediaUrls: mediaFiles,
    );
  }
}
