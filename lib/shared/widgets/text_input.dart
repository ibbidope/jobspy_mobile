import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.placeholder,
    required this.label,
    required this.icon,
    required this.onChanged,
    this.hasError = false,
  });

  final String placeholder;
  final String label;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final errorBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(4.r),
    );

    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: placeholder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: const OutlineInputBorder(),
        enabledBorder: hasError ? errorBorder : const OutlineInputBorder(),
        focusedBorder: hasError ? errorBorder : const OutlineInputBorder(),
        prefixIcon: Icon(icon, color: ColorConstants.primary),
      ),
      onChanged: onChanged,
    );
  }
}
