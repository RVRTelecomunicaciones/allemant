import 'package:flutter/material.dart';

class FocusNodes extends StatefulWidget {
  FocusNodes({Key key}) : super(key: key);

  @override
  _FocusNodeState createState() => _FocusNodeState();
}

class _FocusNodeState extends State<FocusNodes> {
  FocusNode _focusNode1;
  FocusNode _focusNode2;
  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode1 = new FocusNode();
    _focusNode1.addListener(_onOnFocusNodeEvent);
    _focusNode2 = new FocusNode();
    _focusNode2.addListener(_onOnFocusNodeEvent);
  }

  _onOnFocusNodeEvent() {
    setState(() {
      // Re-renders
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
