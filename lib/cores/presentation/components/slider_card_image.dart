import 'package:flutter/material.dart';
import '../../../cores/presentation/components/image_with_shimmer.dart';
import '../../config/app_colors.dart';

class SliderCardImage extends StatelessWidget {
  const SliderCardImage({
    super.key,
    required this.imageUrl,
    this.height,
  });

  final String imageUrl;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.black,
            AppColors.black,
            AppColors.transparent,
          ],
          stops: [0.3, 0.5, 1],
        ).createShader(
          Rect.fromLTRB(0, 0, rect.width, rect.height),
        );
      },
      child: ImageWithShimmer(
        height: height ?? (size.height * 0.6),
        width: double.infinity,
        imageUrl: imageUrl,
      ),
    );
  }
}
