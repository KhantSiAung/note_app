import 'package:flutter/material.dart';

class EditTextForm extends StatefulWidget {
  final String title;
  final String hintText;
  final Color backgroundcolor;
  final TextEditingController controller;
  const EditTextForm(
      {Key? key,
      required this.backgroundcolor,
      required this.hintText,
      required this.controller,
      required this.title})
      : super(key: key);

  @override
  State<EditTextForm> createState() => _EditTextFormState();
}

class _EditTextFormState extends State<EditTextForm> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: widget.backgroundcolor)),
                border: const OutlineInputBorder(),
                hintText: widget.hintText),
                validator: (value){
                  if(value ==null || value.isEmpty){
                    return "please enter some text";
                  }
                  return null;
                },
          ),
        ],
      ),
    );
  }
}
