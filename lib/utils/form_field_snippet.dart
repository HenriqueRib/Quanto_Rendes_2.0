import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quanto_rendes_2/utils/constants.dart';
import 'package:flutter/material.dart';

class FormFieldSnippet extends StatelessWidget {
  final GlobalKey<FormFieldState>? fieldKey;
  final FocusNode? focus;
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final IconButton? suffixIcon;
  final bool? enabled;
  final bool? brightnessdark;
  final TextInputType? textInputType;
  final int? maxLines;
  final BoxConstraints? constraints;
  final EdgeInsets? contentPadding;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final Color? cursorColor;
  final TextStyle? style;
  final TextInputAction? textInputAction;
  const FormFieldSnippet({
    Key? key,
    this.fieldKey,
    this.focus,
    this.controller,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.obscureText,
    this.suffixIcon,
    this.enabled,
    this.brightnessdark,
    this.textInputType,
    this.maxLines,
    this.constraints,
    this.contentPadding,
    this.hintStyle,
    this.labelStyle,
    this.focusedBorder,
    this.enabledBorder,
    this.cursorColor,
    this.style,
    this.textInputAction,
    required Container child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          constraints is BoxConstraints ? constraints! : const BoxConstraints(),
      child: Theme(
        data: ThemeData(
          hintColor: Constants.color1,
          brightness:
              brightnessdark is bool ? Brightness.light : Brightness.dark,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: .0.sw, right: .0.sw),
          child: TextFormField(
            key: fieldKey,
            textInputAction: textInputAction,
            enabled: enabled is bool ? enabled! : true,
            obscureText: obscureText is bool ? obscureText! : false,
            focusNode: focus,
            controller: controller,
            keyboardType: textInputType is TextInputType
                ? textInputType
                : TextInputType.text,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle is TextStyle
                  ? hintStyle!
                  : TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey,
                    ),
              labelText: labelText,
              labelStyle: labelStyle is TextStyle
                  ? labelStyle
                  : TextStyle(
                      fontSize: 15.sp,
                      color: Constants.color1,
                    ),
              suffixIcon: suffixIcon is IconButton
                  ? Padding(
                      padding: const EdgeInsets.all(2),
                      child: suffixIcon,
                    )
                  : const SizedBox(),
              contentPadding: contentPadding,
            ),
            cursorColor: cursorColor is Color ? cursorColor : Constants.color1,
            style: style is TextStyle
                ? style
                : TextStyle(
                    fontSize: 15.sp,
                    color: Constants.color1,
                  ),
            onChanged: onChanged,
            validator: validator,
            onFieldSubmitted: onFieldSubmitted,
          ),
        ),
      ),
    );
  }
}
