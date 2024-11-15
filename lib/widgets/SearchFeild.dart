import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final String hintText;
  final TextStyle? textStyle;
  final IconData? icon;
  final Function(String)? onChanged;

  const SearchField({
    this.onChanged,
    this.icon = Icons.swap_horiz,
    this.hintText = 'Text',
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: textStyle ?? const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black.withOpacity(0.1),
        hintText: hintText,
        prefixIcon: Icon(icon),
        hintStyle: const TextStyle(color: Colors.black38),
        contentPadding: const EdgeInsets.all(15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
