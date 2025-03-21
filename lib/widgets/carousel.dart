import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final Axis direction;
  final List<Widget> items;
  const Carousel({
    super.key,
    this.direction = Axis.horizontal,
    required this.items,
  });

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final ScrollController _controller = ScrollController();
  double _dragStartX = 0.0;
  void _onHorizontalDragStart(DragStartDetails details) {
    _dragStartX = details.globalPosition.dx;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final double dragAmount = _dragStartX - details.globalPosition.dx;
    _controller.jumpTo(_controller.offset + dragAmount);
    _dragStartX = details.globalPosition.dx;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      child: SingleChildScrollView(
        controller: _controller,
        scrollDirection: widget.direction,
        child: getItems(),
      ),
    );
  }

  Widget getItems() {
    return widget.direction == Axis.horizontal
        ? Row(children: widget.items)
        : Column(children: widget.items);
  }
}
