import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {super.key,
        required this.title,
        required this.controller,
        this.inputFormatters,
        this.keyboardType,
        this.prefixIcon,
        this.textcapitalization,
        this.validator,
        this.focusNode,
        this.autofocus = false,
        this.readOnly = false,
        this.maxlines,
        this.minlines,
        this.onChange});

  final String title;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function(String?)? onChange;
  final TextEditingController controller;
  final int? maxlines;
  final int? minlines;
  final bool autofocus;
  final bool readOnly;
  final TextCapitalization? textcapitalization;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          TextFormField(
            readOnly: readOnly,
            autofocus: autofocus,
            focusNode: focusNode,
            maxLines: maxlines ?? 1,
            minLines: minlines ?? 1,
            validator: validator,
            textCapitalization: textcapitalization ?? TextCapitalization.none,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            controller: controller,
            onChanged: (value) {
              if (onChange != null) {
                onChange!(value);
              }
            },
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              contentPadding: const EdgeInsets.only(top: 13, bottom: 13, left: 10),
            ),
          ),
        ],
      ),
    );
  }
}
