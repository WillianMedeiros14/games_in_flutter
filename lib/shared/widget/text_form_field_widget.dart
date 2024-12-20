import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;
  final VoidCallback onChanged;
  final int? maxLines;
  final bool? enabled;

  const TextFormFieldWidget(
      {super.key,
      required this.controller,
      this.validator,
      this.labelText,
      this.hintText,
      this.keyboardType,
      this.contentPadding =
          const EdgeInsets.only(left: 16, bottom: 10, right: 16, top: 10),
      this.maxLines,
      required this.onChanged,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: (value) => onChanged(),
      maxLines: maxLines,
      enabled: enabled,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: contentPadding,
        labelText: labelText,
        hintText: hintText,
        alignLabelWithHint: true,
        errorStyle: const TextStyle(
          fontSize: 12,
          color: Colors.red,
        ),
        errorMaxLines: 1,
      ),
    );
  }
}
