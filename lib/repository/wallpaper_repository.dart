import 'dart:convert';

import 'package:http/http.dart';

import '../constants/constants.dart';
import '../model/wallpaper_model.dart';

abstract class WallPaperRepository {
  Future<List<WallpaperModel>> getWallpapers(String query);
}

class WallPaperRepositoryImpl implements WallPaperRepository {
  @override
  Future<List<WallpaperModel>> getWallpapers(String query) async {
    query = query.replaceAll(' ', '+');
    final Response response = await get(
      Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=60?locale=es_ES'),
      headers: {'Authorization': key},
    );
    if (response.statusCode == 200) {
      final List<WallpaperModel> wallpapers = [];
      final Map<String, dynamic> data = jsonDecode(response.body);
      data['photos'].forEach((element) {
        wallpapers.add(WallpaperModel.fromMap(element['src']));
      });
      return wallpapers;
    } else {
      throw Exception();
    }
  }
}
