//...........defaultFormField..........//
import 'package:flutter/material.dart';

Widget defaultFormField(
  context, {
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  FormFieldValidator<String>? validate,
  required String label,
  IconData? prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
  int? maxLength,
  int maxLines = 1,
  int? minLines,
  Color fillColor = const Color(0xFFE8E8E8),
  Color? suffixColor,
  double? suffixSize,
  Color? prifixColor,
  double prifixSize = 20.0,
  Color textColorDark = Colors.white,
  bool enabled = true,
  String? hint,
}) =>
    TextFormField(
      enabled: enabled,
      style: const TextStyle(fontSize: 18.0, color: Colors.black),
      keyboardType: type,
      validator: validate,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffC9C9C9), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        errorStyle: const TextStyle(fontSize: 14),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff0e93a7), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        contentPadding: const EdgeInsets.all(10),
        labelText: label,
        suffixIcon: IconButton(
            onPressed: () {
              suffixPressed!();
            },
            icon: Icon(
              suffix,
              color: suffixColor,
              size: suffixSize,
            )),
        labelStyle: const TextStyle(
          fontSize: 18,
          color: Colors.green,
        ),
        hintStyle: const TextStyle(
          fontSize: 21,
        ),
        hintText: hint,
        prefixIcon: Icon(
          prefix,
          size: prifixSize,
          color: prifixColor,
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
    );
