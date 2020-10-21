import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key key,
    @required TextEditingController displayNameController,
    @required this.label,
    @required this.enabled,
    @required this.isBio,
  })  : _displayNameController = displayNameController,
        super(key: key);

  final TextEditingController _displayNameController;
  final String label;
  final bool enabled;
  final bool isBio;
  @override
  Widget build(BuildContext context) {
    if (isBio) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Color(0xFFF0F0F0),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: TextField(
          maxLength: 100,
          enabled: enabled,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: _displayNameController,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: label,
            labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Color(0xFFF0F0F0),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: TextField(
        enabled: enabled,
        keyboardType: TextInputType.text,
        controller: _displayNameController,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
      ),
    );
  }
}
