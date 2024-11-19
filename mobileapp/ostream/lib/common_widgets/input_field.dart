import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/resources/app_colors.dart';
import '../utils/resources/app_fonts.dart';

class MyInputFiled extends StatelessWidget {
  const MyInputFiled({
    super.key,
    required this.hint,
    required this.label,
    required this.controller,
    required this.inputIcon,
    this.suffixIcon,
    this.borderRadious = 40.0,
    this.keyboard = TextInputType.text,
    this.iconColor = AppColors.mainColor,
    this.isPass = false,
    this.enable = true,
    this.format,
    this.onSuffixPressed,
    this.maxLine = 1,
    this.minLine = 1,
    required this.validate,
    this.action = TextInputAction.next,
    this.onSubmit, this.onChange, this.textCapitalization,
  });

  final TextInputAction action;

  final TextEditingController controller;
  final double borderRadious;
  final String hint;
  final String label;
  final TextInputType keyboard;
  final IconData? inputIcon;
  final IconData? suffixIcon;
  final Color iconColor;
  final bool isPass;
  final bool enable;
  final int maxLine;
  final int minLine;
  final List<TextInputFormatter>? format;
  final Function()? onSuffixPressed;
  final String? Function(String?)? validate;
  final Function(String)? onSubmit;
  final Function(String)? onChange;
  final TextCapitalization? textCapitalization;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         label == '' ? const SizedBox() : Text(label, style: AppFonts.h1),
          const SizedBox(
            height: 7,
          ),
          TextFormField(
            controller: controller,
            textCapitalization: textCapitalization?? TextCapitalization.none,
            minLines: minLine,
            maxLines: maxLine,
            obscureText: isPass,
            textInputAction: action,
            validator: validate,
            keyboardType: keyboard,
            onFieldSubmitted: onSubmit,
            onChanged: onChange,
            decoration: InputDecoration(
              prefixIcon: inputIcon == null? null : Icon(inputIcon),
              // Use prefixIcon instead of prefix
              suffixIcon: IconButton(
                  onPressed: onSuffixPressed, icon: Icon(suffixIcon)),
              hintText: hint,
              hintStyle: AppFonts.body1,
              label: Text(label, maxLines: 1,),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Theme.of(context).canvasColor,
              enabled: enable,
              labelStyle: AppFonts.body1,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Theme.of(context).cardColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.mainColor),
                borderRadius: BorderRadius.circular(10.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).cardColor,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).cardColor,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
