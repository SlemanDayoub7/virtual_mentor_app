import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';

class AppTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? errorText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isPassword;
  final bool readOnly;
  final bool enabled;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int? maxLines;
  final int? maxLength;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final double? height;
  final double? width;
  final bool showBorder;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.errorText,
    this.controller,
    this.focusNode,
    this.isPassword = false,
    this.readOnly = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.onChanged,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.height,
    this.width,
    this.showBorder = true,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final iconColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final finalWidth = widget.width ?? 342.w;
    final finalHeight = widget.height ?? 56.h;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: AppTextStyles.labelM(color: textColor)),
          SizedBox(height: AppSizes.vsm),
        ],
        SizedBox(
          width: finalWidth,
          height: finalHeight,      
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            obscureText: widget.isPassword ? _obscureText : false,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            maxLines: widget.isPassword ? 1 : widget.maxLines,
            maxLength: widget.maxLength,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
            style: AppTextStyles.bodyM(color: textColor),
            decoration: InputDecoration(
              hintText: widget.hint,
              errorText: widget.errorText,
          
              filled: true,
              fillColor: AppColors.white,
          
              // Remove underline/lines -> use outline border
              enabledBorder: 
              widget.showBorder
              ?OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                // ignore: deprecated_member_use
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.35), width: 1),
              ):InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                borderSide: BorderSide(color: Colors.transparent, width: 0),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                borderSide: BorderSide(color: Colors.transparent, width: 0),
              ),
          
              // Keep a visible outline shape with “rounded boundaries”
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                borderSide: BorderSide(color: Colors.transparent, width: 0),
              ),
          
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSizes.md,
                vertical: (finalHeight - 20.h) / 2,
              ),
          
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: iconColor,
                      size: AppSizes.iconMd,
                    )
                  : null,

              // For RTL screens, put suffix icon at the end (right side)
              // and prefix icon at the beginning (left side) via TextDirection.
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                      onTap: () => setState(() => _obscureText = !_obscureText),
                      child: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: iconColor,
                        size: AppSizes.iconMd,
                      ),
                    )
                  : widget.suffixIcon != null
                      ? GestureDetector(
                          onTap: widget.onSuffixTap,
                          child: Icon(widget.suffixIcon,
                              color: iconColor, size: AppSizes.iconMd),
                        )
                      : null,
            ),
          ),
        ),
      ],
    );
  }
}
