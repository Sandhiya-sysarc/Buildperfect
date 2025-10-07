import 'package:dashboard/types/ui_controls_types.dart';
import 'package:flutter/material.dart';

class PagePropsButtonSegment extends StatefulWidget {
  final void Function(Set<PagePropsSegmentButton>) onSegmentChanged;
  const PagePropsButtonSegment({super.key, required this.onSegmentChanged});
  @override
  State<PagePropsButtonSegment> createState() => _PagePropsButtonSegmentState();
}

class _PagePropsButtonSegmentState extends State<PagePropsButtonSegment> {
  Set<PagePropsSegmentButton> selectedSegmentButton = {
    PagePropsSegmentButton.property,
  };

  @override
  Widget build(BuildContext context) {
    TextStyle txtStyle = TextStyle(fontSize: 10);
    return SegmentedButton(
      segments: <ButtonSegment<PagePropsSegmentButton>>[
        ButtonSegment<PagePropsSegmentButton>(
          value: PagePropsSegmentButton.property,
          label: Text('Props', style: txtStyle),
          icon: Icon(Icons.info),
        ),
        ButtonSegment<PagePropsSegmentButton>(
          value: PagePropsSegmentButton.action,
          label: Text('Action', style: txtStyle),
          icon: Icon(Icons.account_tree_sharp),
        ),
        ButtonSegment<PagePropsSegmentButton>(
          value: PagePropsSegmentButton.datasource,
          label: Text('Data', style: txtStyle),
          icon: Icon(Icons.storage),
        ),
      ],
      selected: selectedSegmentButton,
      showSelectedIcon: false,
      style: SegmentedButton.styleFrom(
        textStyle: txtStyle,
        backgroundColor: Colors.white,
        selectedBackgroundColor: Colors.blueAccent,
        foregroundColor: Colors.black,
        selectedForegroundColor: Colors.white,
      ),
      onSelectionChanged: (p0) {
        selectedSegmentButton = p0;
        widget.onSegmentChanged(p0);
        setState(() {});
      },
      emptySelectionAllowed: true,
    );
  }
}
