import 'package:desktop_listview/desktop_listview.dart';
import 'package:flutter/material.dart';

class DesktopListviewItem extends StatefulWidget {

  final DesktopListviewController controller;
  final String id;
  final void Function()? onPressed;
  final Widget child;
  final Widget dragFeedback;
  final Offset dragFeedbackOffset;
  final void Function(TapUpDetails details)? onSecondaryTapUp;
  const DesktopListviewItem({super.key, required this.child, required this.id, required this.controller, this.onPressed, required this.dragFeedback, this.dragFeedbackOffset = Offset.zero, this.onSecondaryTapUp});

  @override
  State<DesktopListviewItem> createState() => _DesktopListviewItemState();
}

class _DesktopListviewItemState extends State<DesktopListviewItem> {
  
  bool hovering = false;
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (d) {
        setState(() {
          hovering = true;
        });
      },
      onExit: (d) {
        setState(() {
          hovering = false;
        });
      },
      child: GestureDetector(
        onSecondaryTapUp: widget.onSecondaryTapUp,
        onTap: () {
          if(widget.controller.ctrlPressed) {
            if(widget.controller.selectedItems.contains(widget.id)) {
              widget.controller.removeItem(widget.id);
            }
            else {
              widget.controller.addItem(widget.id);
            }

            return;
          }
          if(widget.controller.shiftPressed) {
            return;
          }
          if(widget.controller.selectedItems.isNotEmpty) {
            widget.controller.endSelection();
            return;
          }
          widget.onPressed?.call();
        },
        child: Draggable(
          data: widget.controller.selectedItems.isEmpty ? {widget.id} : widget.controller.selectedItems,
          feedback: widget.dragFeedback,
          dragAnchorStrategy: pointerDragAnchorStrategy,
          feedbackOffset: widget.dragFeedbackOffset,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: hovering || widget.controller.selectedItems.contains(widget.id) ? Theme.of(context).highlightColor.withAlpha(80) : Colors.transparent
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
