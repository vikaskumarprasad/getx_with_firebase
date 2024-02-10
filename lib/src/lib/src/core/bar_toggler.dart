import 'package:flutter/material.dart';

import '../api/side_bar_toggler.dart';
import '../api/side_navigation_bar_theme.dart';

/// Represents the toggler widget which is used to change expanded state of [SideNavigationBar]
class SideBarTogglerWidget extends StatefulWidget {
  /// Toggler data obtained from user
  final SideBarToggler togglerData;

  /// The current expanded state of [SideNavigationBar]
  final bool expanded;

  /// What to do when the toggler is pressed
  final VoidCallback onToggle;

  /// Style customizations
  final SideNavigationBarTogglerTheme togglerTheme;

  const SideBarTogglerWidget({
    Key? key,
    required this.togglerData,
    required this.expanded,
    required this.onToggle,
    required this.togglerTheme,
  }) : super(key: key);

  @override
  _SideBarTogglerWidgetState createState() => _SideBarTogglerWidgetState();
}

class _SideBarTogglerWidgetState extends State<SideBarTogglerWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: Icon(
          size: 30,
          widget.expanded
              ? widget.togglerData.shrinkIcon
              : widget.togglerData.expandIcon,
          color: widget.expanded
              ? widget.togglerTheme.shrinkIconColor
              : widget.togglerTheme.expandIconColor,
        ),
        onPressed: widget.onToggle,
      ),
    );
  }
}
