import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';

enum AppImageType { network, asset, file }

class AppImage extends StatelessWidget {
  final String? url;
  final String? assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double? borderRadius;
  final Color? backgroundColor;
  final Widget? errorWidget;
  final Widget? placeholder;
  final bool isCircle;

  const AppImage.network({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.backgroundColor,
    this.errorWidget,
    this.placeholder,
    this.isCircle = false,
  }) : assetPath = null;

  const AppImage.asset({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.backgroundColor,
    this.errorWidget,
    this.placeholder,
    this.isCircle = false,
  }) : url = null;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (url != null) {
      imageWidget = CachedNetworkImage(
        imageUrl: url!,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) =>
            placeholder ?? _buildPlaceholder(),
        errorWidget: (context, url, error) =>
            errorWidget ?? _buildError(),
      );
    } else if (assetPath != null) {
      imageWidget = Image.asset(
        assetPath!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => errorWidget ?? _buildError(),
      );
    } else {
      imageWidget = _buildError();
    }

    return ClipRRect(
      borderRadius: isCircle
          ? BorderRadius.circular(1000)
          : BorderRadius.circular(borderRadius ?? 0),
      child: Container(
        width: width,
        height: height,
        color: backgroundColor,
        child: imageWidget,
      ),
    );
  }

  Widget _buildPlaceholder() => Container(
        color: AppColors.grey100,
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primary,
          ),
        ),
      );

  Widget _buildError() => Container(
        color: AppColors.grey100,
        child: Icon(
          Icons.broken_image_outlined,
          color: AppColors.grey400,
          size: AppSizes.iconXl,
        ),
      );
}

// ─── Avatar ───────────────────────────────────────────────────────────────────
class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double size;
  final Color? backgroundColor;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = 48,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return AppImage.network(
        url: imageUrl,
        width: size,
        height: size,
        isCircle: true,
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? AppColors.primary.withOpacity(0.15),
      ),
      child: Center(
        child: Text(
          _initials,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: size * 0.35,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  String get _initials {
    if (name == null || name!.isEmpty) return '?';
    final parts = name!.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }
}
