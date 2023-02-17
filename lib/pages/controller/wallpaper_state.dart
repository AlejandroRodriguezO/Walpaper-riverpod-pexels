import 'package:equatable/equatable.dart';

import '../../constants/enum/wallpaper_state_enum.dart';
import '../../model/wallpaper_model.dart';

class WallpaperState extends Equatable {
  final List<WallpaperModel> wallpapers;
  final WallPaperStateEnum wallpaperStatus;

  const WallpaperState({
    this.wallpapers = const [],
    this.wallpaperStatus = WallPaperStateEnum.unknown,
  });

  @override
  List<Object?> get props => [
        wallpapers,
        wallpaperStatus,
      ];

  WallpaperState copyWith({
    List<WallpaperModel>? wallpapers,
    WallPaperStateEnum? wallpaperStatus,
  }) =>
      WallpaperState(
        wallpapers: wallpapers ?? this.wallpapers,
        wallpaperStatus: wallpaperStatus ?? this.wallpaperStatus,
      );
}
