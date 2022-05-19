import 'dart:ffi';

import 'package:flutter/material.dart';

class EditPersonalDataUser extends StatefulWidget {
  EditPersonalDataUser({
    Key? key,
    required this.onSave,
    this.controller,
    required this.content,
    this.isChange = false,
    this.isLoad = false,
    this.validation,
    this.save = '',
    this.maxLength = 0,
  }) : super(key: key);
  final Function()? onSave;
  TextEditingController? controller;
  final FormFieldValidator<String>? validation;
  String content;
  String save;
  bool isChange;
  bool isLoad;
  final maxLength;

  @override
  State<EditPersonalDataUser> createState() => _EditPersonalDataUserState();
}

class _EditPersonalDataUserState extends State<EditPersonalDataUser> {
  @override
  Widget build(BuildContext context) {
    return widget.isChange
        ? Row(
            children: [
              Expanded(
                child: TextFormField(
                  maxLength: widget.maxLength,
                  validator: widget.validation,
                  controller: widget.controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    suffixIcon: widget.isLoad
                        ? null
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                widget.isChange = false;
                                widget.controller!.text = widget.save;
                                widget.content = widget.save;
                              });
                            },
                            icon: const Icon(Icons.close)),
                  ),
                ),
              ),
              Container(
                height: 70,
                alignment: Alignment.topLeft,
                child: widget.isLoad
                    ? const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: CircularProgressIndicator(),
                      )
                    : IconButton(
                        onPressed: widget.onSave, icon: const Icon(Icons.save)),
              ),
            ],
          )
        : Row(
            children: [
              Text(widget.content),
              Expanded(child: Container()),
              IconButton(
                  onPressed: () {
                    setState(() {
                      widget.isChange = true;
                    });
                  },
                  icon: const Icon(Icons.edit))
            ],
          );
  }
}
