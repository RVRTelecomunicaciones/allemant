import 'package:flutter/material.dart';

class FocusNode_Event extends StatefulWidget {
  FocusNode focusName;
  final IconData prefixIcon;

  final String hintText;

  FocusNode_Event({Key key, this.prefixIcon, this.focusName, this.hintText})
      : super(key: key);

  @override
  _FocusNode_EventState createState() => _FocusNode_EventState();
}

class _FocusNode_EventState extends State<FocusNode_Event> {

  bool _focused = false;

  void dispose() {
    widget.focusName.removeListener(_handleFocusChange);
    super.dispose();
    widget.focusName.dispose();
  }

  void _handleFocusChange() {
    if (widget.focusName.hasFocus != _focused) {
      setState(() {
        _focused = widget.focusName.hasFocus;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.focusName = new FocusNode();
    widget.focusName.addListener(_handleFocusChange);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          focusNode: widget.focusName,
          style: TextStyle(color: Colors.blue),
          decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              prefixIcon:
                  Icon(widget.prefixIcon, color: getPrefixIconColor()),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.blue)
            )
          ),
        )
      ],
    );
  }

  Color getPrefixIconColor() {
    return widget.focusName.hasFocus ? Colors.blue : Colors.grey;
  }

}
