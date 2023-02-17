import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/constants.dart';
import '../../provider/provider.dart';

class NotFoundIllustration extends ConsumerWidget {
  const NotFoundIllustration({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 200,
          height: 300,
          child: SvgPicture.asset(notFoundIllustration),
        ),
        ElevatedButton(
          onPressed: () => ref.read(wallpaperProvider.notifier).getWallpapers(),
          child: const Text('Retry'),
        )
      ],
    );
  }
}
