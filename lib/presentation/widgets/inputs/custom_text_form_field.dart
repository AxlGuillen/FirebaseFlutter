import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final Function(String)? onchanged;
  final String? Function(String?)? validator;
  final bool obcuredText;
  final Icon icono;

  const CustomTextFormField(
      {super.key,
      this.label,
      this.hint,
      this.errorMessage,
      this.onchanged,
      this.validator,
      this.obcuredText = false, 
      required this.icono
    });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      //borderSide: BorderSide(color: colors.primary),
    );

    return TextFormField(
      onChanged: onchanged,
      validator: validator,
      obscureText: obcuredText,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder:
            border.copyWith(borderSide: BorderSide(color: colors.primary)),
        errorBorder:
            border.copyWith(borderSide: BorderSide(color: Colors.red.shade800)),
        focusedErrorBorder:
            border.copyWith(borderSide: BorderSide(color: Colors.red.shade800)),
        isDense: true,
        label: label != null ? Text(label!) : null,
        hintText: hint,
        focusColor: colors.primary,
        prefixIcon: icono,
        prefixIconColor: colors.primary,
        errorText: errorMessage,
      ),
    );
  }
}
