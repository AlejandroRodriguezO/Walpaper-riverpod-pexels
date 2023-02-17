import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers/pages/routes/routes.dart';

import '../../model/wallpaper_model.dart';

class ImageCard extends StatelessWidget {
  final WallpaperModel wallpaper;
  const ImageCard({Key? key, required this.wallpaper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.pushNamed(context, Routes.detail, arguments: wallpaper);
          },
          child: Image.network(
            wallpaper.thumbnail,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator.adaptive()),
              );
            },
          ),
        ),
      ),
    );
  }
}
