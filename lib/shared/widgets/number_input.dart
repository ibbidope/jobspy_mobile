import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumberInput extends StatelessWidget {
  const NumberInput({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
    this.hasError = false,
  });

  final String label;
  final int value;
  final void Function(int?) onChanged;
  final int min;
  final int max;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final errorBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(4.r),
    );

    return TextFormField(
      initialValue: value.toString(),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        enabledBorder: hasError ? errorBorder : const OutlineInputBorder(),
        focusedBorder: hasError ? errorBorder : const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      onChanged: (val) {
        final parsed = int.tryParse(val);
        onChanged(parsed?.clamp(min, max));
      },
    );
  }
}
