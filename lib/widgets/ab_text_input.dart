import 'package:annapurna_finance/utils/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ABTextInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? validationMsg,
      titleText,
      hintText,
      labelText,
      helperText,
      prefixText,
      suffixText;
  final Widget? prefix, suffix;
  final int? maxLength;
  final int? minLength;
  final Color? iserror;
  final Function()? onTap;
  final bool? isPassword, countryCodeEnabled, isEnabled;
  final bool? isSimpleField;
  final BorderRadius? borderRadius;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function(String text)? onFieldSubmitted;
  final Function(String? val)? validator;
  final AutovalidateMode? autoValidator;
  final Function(String? val)? onChange;
  final bool isCustomInput;
  final bool enableInteractiveSelection;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? customInputFormatters;

  const ABTextInput(
      {Key? key,
      this.controller,
      this.validationMsg,
      this.validator,
      this.autoValidator,
      this.helperText,
      this.suffixText,
      this.iserror,
      this.prefixText,
      this.prefix,
      this.labelText,
      this.titleText,
      this.hintText,
      this.suffix,
      this.textInputType,
      this.isPassword,
      this.maxLength,
      this.onTap,
      this.countryCodeEnabled,
      this.borderRadius,
      this.isSimpleField,
      this.textInputAction,
      this.onFieldSubmitted,
      this.focusNode,
      this.isCustomInput = false,
      this.enableInteractiveSelection = true,
      this.textCapitalization,
      this.onChange,
      this.minLength,
      this.customInputFormatters,
      this.isEnabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.01,
              left: 15,
              right: MediaQuery.of(context).size.width * 0.075),
          alignment: Alignment.topLeft,
          child: Text(
            titleText!,
            style: TextStyle(
                //fontFamily: Strings.proximaNovaFont,
                letterSpacing: -0.01,
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
                color: const Color(0xff221F20)),
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 5),
          child: TextFormField(
            cursorColor: ThemeColor.primary,
            keyboardType: textInputType ?? TextInputType.text,
            inputFormatters: isCustomInput
                ? [FilteringTextInputFormatter.digitsOnly]
                : customInputFormatters,
            validator: (val) => validator != null ? validator!(val) : null,
            maxLength: maxLength,
            onChanged: onChange,
            readOnly: isEnabled ?? false,
            obscureText: isPassword ?? false,
            controller: controller,
            onTap: onTap,
            decoration: InputDecoration(
              errorStyle: const TextStyle(fontSize: 11, height: 1.0),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: iserror ?? Colors.red,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: iserror ?? Colors.red,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: iserror ?? Color(0xff9aa4b0),
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: iserror ?? ThemeColor.primary,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              suffixIconColor: ThemeColor.primary,
              contentPadding: const EdgeInsets.all(12),
              hintText: hintText,
              hintStyle: TextStyle(
                // fontFamily: Strings.proximaNovaFont,
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: const Color(0xff9aa4b0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
              suffixIcon: suffix,
            ),
            autovalidateMode: autoValidator ?? AutovalidateMode.disabled,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              // fontFamily: Strings.proximaNovaFont,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
