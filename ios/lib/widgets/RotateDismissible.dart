import 'package:flutter/material.dart';

class RotatingDismissible extends StatefulWidget {
  final Widget child;
  final Key key;
  final Function(DismissDirection) onDismissed;

  const RotatingDismissible({
    required this.key,
    required this.child,
    required this.onDismissed,
  }) : super(key: key);

  @override
  _RotatingDismissibleState createState() => _RotatingDismissibleState();
}

class _RotatingDismissibleState extends State<RotatingDismissible> {
  double _dragExtent = 0.0;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: widget.key,
      direction: DismissDirection.horizontal,
      onDismissed: widget.onDismissed,
      onUpdate: (details) {
        setState(() {
          _dragExtent = details.progress * (details.direction == DismissDirection.endToStart ? -1 : 1);
        });
      },
      child: Transform.rotate(
        angle: _dragExtent * 0.2, // Adjust rotation intensity
        child: widget.child,
      ),
    );
  }
}
