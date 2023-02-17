
class WallpaperModel {
  WallpaperModel({
    required this.thumbnail,
    required this.original,
  });
  
  final String thumbnail;
  final String original;


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'thumbnail': thumbnail,
      'original': original,
    };
  }

  factory WallpaperModel.fromMap(Map<String, dynamic> map) {
    return WallpaperModel(
      thumbnail: map['medium'] as String,
      original: map['large2x'] as String,
    );
  }

  WallpaperModel copyWith({
    String? thumbnail,
    String? original,
  }) {
    return WallpaperModel(
      thumbnail: thumbnail ?? this.thumbnail,
      original: original ?? this.original,
    );
  }
}
