import 'package:flutter/material.dart';

class MyCheckbox extends StatefulWidget {
  final bool initialValue;
  final Function(bool) onChanged;
  final String? text;

  const MyCheckbox({super.key, required this.initialValue, required this.onChanged, this.text});

  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.text ?? "MitarbeiterIn", style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        )),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            border: Border.all(
              color: _isChecked ? Colors.green : Colors.grey, // Color of the border
              width: 1.0, // Width of the border
            ),
            borderRadius: BorderRadius.circular(2.0), // Rounded corners for the border
          ),
          child: Checkbox(
            activeColor: Colors.white,
            checkColor: Colors.black,
            value: _isChecked,
            onChanged: (bool? newValue) {
              setState(() {
                _isChecked = newValue ?? false;
                widget.onChanged(_isChecked);
              });
            },
          ),
        ),
      ],
    );
  }
}

