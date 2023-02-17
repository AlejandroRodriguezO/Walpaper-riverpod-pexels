import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpapers/pages/controller/wallpaper_controller.dart';
import 'package:wallpapers/pages/controller/wallpaper_state.dart';
import 'package:wallpapers/repository/wallpaper_repository.dart';

final _repository =
    Provider<WallPaperRepository>((ref) => WallPaperRepositoryImpl());

final wallpaperProvider =
    StateNotifierProvider.autoDispose<WallPaperController, WallpaperState>(
  (ref) => WallPaperController(
    repository: ref.read(_repository),
  ),
);
