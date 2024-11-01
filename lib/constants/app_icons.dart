import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static const googleLogo = 'assets/icons/google-logo.svg';

  static const allIcons = [
    googleLogo,
  ];

  static Future<void> preloadIconsSVGs() async {
    for (final asset in allIcons) {
      final loader = SvgAssetLoader(asset);
      svg.cache
          .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
      // await precachePicture(
      //   ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, asset),
      //   null,
      // );
    }
  }
}
