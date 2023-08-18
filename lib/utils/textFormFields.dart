import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/responsiveUi.dart';

class AppWidget {
  static Widget getTextField({
    String? fieldTitleText,
    String? hintText,
    bool isDense = false,
    bool isPassword = false,
    required TextEditingController textEditingController,
    OutlineInputBorder? outlineInputBorder,
    UnderlineInputBorder? underlineInputBorder,
    OutlineInputBorder? activeOutlineInputBorder,
    UnderlineInputBorder? activeUnderLineInputBorder,
    Function? validationFunction,
    Function? onSavedFunction,
    Function? onFieldSubmit,
    TextInputType? keyboardType,
    Function? onEditingComplete,
    Function? onTapFunction,
    Function? onChangedFunction,
    TextAlign align = TextAlign.start,
    TextInputAction? inputAction,
    List<TextInputFormatter>? inputFormatter,
    bool? isEnabled,
    int? errorMaxLines,
    // String? initialText = "",
    int? maxLine,
    FocusNode? textFocusNode,
    GlobalKey<FormFieldState>? key,
    bool isReadOnly = false,
    Widget? suffixIcon,
    Widget? preFixIcon,
    Color? filledColor,
    EdgeInsetsGeometry? contentPadding,
    ScrollController? scrollController,
    TextStyle? hintStyle,
    TextStyle? inputTextStyle,
    TextStyle? labelStyle,
    String? label,
    bool? autofocus,
    String? obscringStyle,
    BuildContext? context,
    InputBorder? border,
    int? maxLength,
    Color? cursorColor,
    FontWeight? labelFontWeight,
    double? labelFontSize,
    Color? labelTextColor,
    TextAlign? labelTextAlign,
    FontWeight? hintFontWeight,
    double? hintFontSize,
    Color hintTextColor=Colors.white,
    TextAlign? hintTextAlign,
    double? fontSize,
    FontWeight? inputFontWeight,
    Color? inputFontColor,
    bool isMobileNumber = false,
  }) {
    bool passwordVisible = isPassword;

    return StatefulBuilder(builder: (context, newSetState) {
      return TextFormField(
        maxLength: maxLength ?? 50,
        enabled: isEnabled != null && !isEnabled ? false : true,
        textAlign: align,
        maxLines: maxLine ?? 1,

        controller: textEditingController,
        keyboardType: keyboardType,
        cursorColor: cursorColor ?? Colors.white,
        cursorHeight: Resp.size(hintFontSize ?? 15),
        obscureText: passwordVisible,
        textInputAction: inputAction,
        // obscuringCharacter: isPassword ? '●' : '',
        inputFormatters: inputFormatter,
        autofocus: false,
        style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: Resp.size(fontSize ?? 16)),
        decoration: InputDecoration(
          hintText: hintText,
          counterText: '',
          prefixIcon: preFixIcon,
          hintStyle: GoogleFonts.inter(
            fontSize: Resp.size(hintFontSize ?? 14),
            fontWeight: FontWeight.w400,
            color: hintTextColor,
          ),
          contentPadding: EdgeInsets.only(
              right: Resp.size(20),
              left: Resp.size(20),
              bottom: Resp.size(20),
              top: Resp.size(20)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              Resp.size(10),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Resp.size(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Resp.size(10)),
          ),
          // fillColor: filledColor ?? AppColors.lightBlack,
          fillColor: filledColor ?? AppColors.lightBlack,
          filled: true,
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: () {
                    newSetState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  child: !passwordVisible
                      ? Image.asset(
                          'assets/authFlow/eye-slash.png',
                          scale: 2.5,
                        )
                      : Image.asset('assets/authFlow/eye.png', scale: 2.5))
              : suffixIcon ?? const SizedBox(),
        ),
        onChanged: (value) {
          if (onChangedFunction != null) {
            onChangedFunction(value);
          }
        },
        onEditingComplete: () {
          if (onEditingComplete != null) {
            onEditingComplete();
          }
        },
        validator: (value) {
          return validationFunction != null ? validationFunction(value) : null;
        },
        onSaved: (value) {
          return onSavedFunction != null
              ? onSavedFunction(value)
              : FocusScope.of(context).unfocus();
        },
        onFieldSubmitted: (value) {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          return onFieldSubmit != null
              ? onFieldSubmit(value)
              : FocusScope.of(context).unfocus();
        },
        onTap: () {
          if (onTapFunction != null) {
            onTapFunction();
          }
        },
        key: key,
        focusNode: textFocusNode,
        scrollController: scrollController,
        showCursor: !isReadOnly,
        readOnly: isReadOnly,
      );
    });
  }
}
