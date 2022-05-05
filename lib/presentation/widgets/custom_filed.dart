import 'package:flutter/material.dart';

class CustomField extends StatefulWidget {
  final bool isObscure;
  final TextEditingController? controller;
  final String labelText;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final FormFieldValidator<String>? validation;

  CustomField({
    Key? key,
    this.isObscure = false,
    this.controller,
    required this.labelText,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.validation,
  }) : super(key: key);

  @override
  _CustomFieldState createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool isObscure = false;
  Color borderColor = Colors.blue;
  String saveValue = '';

  @override
  void initState() {
    super.initState();
    isObscure = widget.isObscure;
    saveValue = widget.controller!.text;
  }

  Color _borderColor() {
    Color test = Colors.grey;
    if (borderColor == Colors.blue) {
      test = Colors.grey;
    }
    if (borderColor == Colors.orange) {
      test = borderColor;
    }
    if (widget.controller!.text == saveValue) {
      test = Colors.grey;
      borderColor = Colors.blue;
      saveValue = widget.controller!.text;
    }
    return test;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validation,
      maxLength: widget.maxLength,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      controller: widget.controller,
      onChanged: (value) {
        setState(() {
          borderColor = saveValue != value ? Colors.orange : Colors.blue;
        });
      },
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: widget.labelText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _borderColor(),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        suffixIcon: widget.isObscure
            ? InkWell(
                child:
                    Icon(isObscure ? Icons.visibility_off : Icons.visibility),
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              )
            : null,
      ),
    );
  }
}
