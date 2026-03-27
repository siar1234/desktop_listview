import 'package:desktop_listview/src/item.dart';
import 'package:flutter/material.dart';

import 'controller.dart';

class DesktopListview extends StatefulWidget {
  final Axis scrollDirection;
  final int itemCount;
  final DesktopListviewItem Function(BuildContext context, int index) itemBuilder;
  final DesktopListviewController controller;
  final void Function(TapUpDetails details)? onSecondaryTapUp;
  final void Function(KeyEvent keyEvent)? onKeyEvent;
  final EdgeInsets padding;

  const DesktopListview(
      {super.key,
        this.scrollDirection = Axis.vertical,
        required this.itemBuilder,
        required this.itemCount, required this.controller,
        this.onSecondaryTapUp, this.onKeyEvent,
        this.padding = EdgeInsets.zero});

  @override
  State<DesktopListview> createState() => _DesktopListviewState();
}

class _DesktopListviewState extends State<DesktopListview> {

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (d) {
        widget.controller.focusNode.requestFocus();
      },
      child: ListenableBuilder(
        listenable: widget.controller,
        builder: (BuildContext context, Widget? child) {
          return GestureDetector(
            onSecondaryTapUp: widget.onSecondaryTapUp,
            onPanStart: (details) {
              //TODO: implement drag to select multiple items
            },
            onPanUpdate: (details) {

            },
            child: KeyboardListener(
                focusNode: widget.controller.focusNode,
                onKeyEvent: (keyEvent) {
                  widget.controller.handleKeyEvent(keyEvent);
                  widget.onKeyEvent?.call(keyEvent);
                },
                child: ListView.builder(
                    padding: widget.padding,
                    itemCount: widget.itemCount,
                    itemBuilder: (context, index) {
                      return widget.itemBuilder(context, index);
                    })
            ),
          );
        },
      ),
    );
  }
}