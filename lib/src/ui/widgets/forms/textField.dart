import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeplerTextField extends StatelessWidget {
  final String label;
  final bool numeral;
  final TextEditingController controller;
  final bool password;
  final bool multiline;
  final IconData icon;
  final int maxLength;
  final bool enabled;
  final TextAlign textAlign;
  final String initialValue;
  final Function onChanged;

  KeplerTextField(
      {this.label,
        this.initialValue,
        this.numeral = false,
        this.controller,
        this.enabled = true,
        this.password = false,
        this.multiline = false,
        @required this.textAlign,
        this.maxLength,
        this.icon,
        this.onChanged});

  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Container(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
                child: TextFormField(
                  inputFormatters: numeral
                      ? [
                    FilteringTextInputFormatter.deny(
                        RegExp('[\\,, \\-, \\.]')),
                  ]
                      : null,
                  controller: controller,
                  enabled: enabled,
                  textAlign: textAlign,
                  initialValue: initialValue,
                  maxLength: maxLength,
                  obscureText: password ? true : false,
                  keyboardType: multiline
                      ? TextInputType.multiline
                      : (numeral ? TextInputType.number : TextInputType.text),
                  maxLines: multiline ? 3 : 1,
                  decoration: InputDecoration(
                      labelText: label,
                      counterText: "",
                      prefixIcon: icon != null
                          ? Icon(
                        icon,
                        color: Colors.grey,
                      )
                          : null),
                  onChanged: onChanged,
                ))));
  }
}

