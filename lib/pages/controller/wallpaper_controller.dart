import 'dart:io';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpapers/constants/enum/wallpaper_state_enum.dart';
import 'package:wallpapers/repository/wallpaper_repository.dart';

import '../../constants/enum/wallpaper_location_enum.dart';
import 'wallpaper_state.dart';

class WallPaperController extends StateNotifier<WallpaperState> {
  WallPaperController({required this.repository})
      : super(const WallpaperState()) {
    getWallpapers();
  }

  final WallPaperRepository repository;

  final _ctrlSearch = TextEditingController();

  TextEditingController get ctrlSearch => _ctrlSearch;

  Future<void> getWallpapers({String? query}) async {
    String lastQuery = 'naturaleza';
    query == null || query.isEmpty ? query = lastQuery : lastQuery = query;
    try {
      state =
          state.copyWith(wallpaperStatus: WallPaperStateEnum.requestInProgress);
      final response = await repository.getWallpapers(query);
      state = state.copyWith(
          wallpapers: response,
          wallpaperStatus: WallPaperStateEnum.requestSuccess);
    } catch (e) {
      state =
          state.copyWith(wallpaperStatus: WallPaperStateEnum.requestFailure);
    }
  }

  Future<File?> downloadWallpaper(String url) async {
    try {
      Directory dir = await getTemporaryDirectory();
      var response = await get(Uri.parse(url));
      var filePath = '${dir.path}/${DateTime.now().toIso8601String()}.jpg';
      File file = File(filePath);
      file.writeAsBytesSync(response.bodyBytes);
      return file;
    } catch (e) {
      return null;
    }
  }

  Future<void> setWallpaper(
      String wallpaperFile, WallpaperLocation location) async {
    try {
      if (location == WallpaperLocation.both) {
        await _setWallpaper(wallpaperFile, WallpaperLocation.home);
        await _setWallpaper(wallpaperFile, WallpaperLocation.lock);
      } else {
        await _setWallpaper(wallpaperFile, location);
      }
      state = state.copyWith(
          wallpaperStatus: WallPaperStateEnum.wallpaperAppliedSuccess);
    } catch (_) {
      state = state.copyWith(
          wallpaperStatus: WallPaperStateEnum.wallpaperAppliedFailed);
    } finally {
      _removeTemporaryFiles();
    }
  }

  void _removeTemporaryFiles() async {
    final Directory tempDir = await getTemporaryDirectory();
    tempDir.existsSync() ? tempDir.deleteSync(recursive: true) : null;
  }

  Future<void> _setWallpaper(String file, WallpaperLocation location) async {
    await AsyncWallpaper.setWallpaperFromFile(
      filePath: file,
      wallpaperLocation: location.value,
      goToHome: false,
    );
  }

  @override
  void dispose() {
    _ctrlSearch.dispose();
    super.dispose();
  }
}
