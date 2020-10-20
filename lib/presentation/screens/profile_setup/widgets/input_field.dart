import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key key,
    @required TextEditingController displayNameController,
    @required this.label,
  })  : _displayNameController = displayNameController,
        super(key: key);

  final TextEditingController _displayNameController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: TextField(
        controller: _displayNameController,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ),
    );
  }
}
