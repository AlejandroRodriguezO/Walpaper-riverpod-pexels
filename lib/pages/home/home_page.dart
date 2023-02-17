import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpapers/constants/enum/wallpaper_state_enum.dart';

import '../../constants/app_colors.dart';
import '../../provider/provider.dart';
import '../widget/image_card.dart';
import '../widget/not_found_ilustration.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wpRead = ref.read(wallpaperProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Card(
              child: TextField(
                controller: wpRead.ctrlSearch,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  border: InputBorder.none,
                  hintText: 'Buscar Wallpaper',
                  hintStyle: const TextStyle(color: AppColor.grey),
                  suffixIcon: ElevatedButton(
                    child: const Icon(Icons.search),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      wpRead.getWallpapers(query: wpRead.ctrlSearch.text);
                    },
                  ),
                ),
                onSubmitted: (value) => wpRead.getWallpapers(query: value),
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (_, ref, __) {
                  final controller = ref.watch(wallpaperProvider);
                  return () {
                    if (controller.wallpaperStatus ==
                        WallPaperStateEnum.requestInProgress) {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    }
                    if (controller.wallpaperStatus ==
                        WallPaperStateEnum.requestFailure) {
                      return const NotFoundIllustration();
                    }
                    final wallpapers = controller.wallpapers;
                    return wallpapers.isEmpty
                        ? Center(
                            child: Text(
                              'Wallpaper no encontrado',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          )
                        : MasonryGridView.count(
                            padding: const EdgeInsets.only(top: 10),
                            physics: const BouncingScrollPhysics(),
                            crossAxisCount: 2,
                            itemBuilder: (_, index) =>
                                ImageCard(wallpaper: wallpapers[index]),
                            itemCount: wallpapers.length,
                          );
                  }();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
