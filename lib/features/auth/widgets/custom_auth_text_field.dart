import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/widgets/adaptive_layout.dart';

/// A themed text field used on auth screens (login / register).
class CustomAuthTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onFieldSubmitted;

  const CustomAuthTextField({
    super.key,
    this.validator,
    required this.label,
    this.onFieldSubmitted,
    required this.hintText,
    this.isPassword = false,
    required this.prefixIcon,
    required this.controller,
  });

  @override
  State<CustomAuthTextField> createState() => _CustomAuthTextFieldState();
}

class _CustomAuthTextFieldState extends State<CustomAuthTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w600,
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 16,
            ),
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : const Color(0XFF222222),
          ),
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
        ),
        TextFormField(
          obscureText: _obscureText,
          validator: widget.validator,
          controller: widget.controller,
          onSaved: widget.onFieldSubmitted,
          onFieldSubmitted: widget.onFieldSubmitted,
          style: GoogleFonts.cairo(
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 14,
            ),
            color: AppColors.foreground(context),
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: GoogleFonts.cairo(
              color: AppColors.mutedForeground(context),
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
            ),
            filled: true,
            fillColor: AppColors.card(context),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16,
              ),
              vertical: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
              ),
              borderSide: BorderSide(color: AppColors.border(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
              ),
              borderSide: BorderSide(color: AppColors.border(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
              ),
              borderSide: BorderSide(color: AppColors.ring(context)),
            ),
            suffixIcon: Icon(
              widget.prefixIcon,
              color: AppColors.primary(context),
            ),
            prefixIcon:
                widget.isPassword
                    ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.mutedForeground(context),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                    : null,
          ),
        ),
      ],
    );
  }
}
