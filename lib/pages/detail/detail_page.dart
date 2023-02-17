import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpapers/constants/app_colors.dart';
import 'package:wallpapers/pages/widget/custom_listtile.dart';
import 'package:wallpapers/provider/provider.dart';

import '../../constants/enum/wallpaper_location_enum.dart';
import '../../model/wallpaper_model.dart';

class DetailPage extends ConsumerStatefulWidget {
  const DetailPage({super.key, required this.wallpaper});
  final WallpaperModel wallpaper;

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  File? wallpaperFile;

  @override
  void initState() {
    ref
        .read(wallpaperProvider.notifier)
        .downloadWallpaper(widget.wallpaper.original)
        .then(
          (value) => setState(() => wallpaperFile = value),
        );
    super.initState();
  }

  Future<void> _showModal() async {
    final controller = ref.read(wallpaperProvider.notifier);
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomListTile(
            onClick: () {
              Navigator.of(context).pop();
              controller.setWallpaper(
                  wallpaperFile!.path, WallpaperLocation.lock);
            },
            title: 'Establecer como pantalla de bloqueo',
          ),
          CustomListTile(
            onClick: () {
              Navigator.of(context).pop();
              controller.setWallpaper(
                  wallpaperFile!.path, WallpaperLocation.home);
            },
            title: 'Establecer como pantalla de inicio',
          ),
          CustomListTile(
            onClick: () {
              Navigator.of(context).pop();
              controller.setWallpaper(
                  wallpaperFile!.path, WallpaperLocation.both);
            },
            title: 'Establecer cambos',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          wallpaperFile == null
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Image.file(wallpaperFile!, fit: BoxFit.cover),
          if (wallpaperFile != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: _showModal,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.black87.withOpacity(.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Aplicar',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          Positioned(
            top: 50,
            right: 0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.white,
                shape: const CircleBorder(),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.clear,
                color: AppColor.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
