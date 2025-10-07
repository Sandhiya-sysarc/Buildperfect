/*
@author     :   karthick.d    30/09/2025
@desc       :   itempanel wraps left panel widgets options (draggable)
                and center panel dragged controls list          
*/
import 'dart:math';
import 'package:dashboard/types/drag_drop_types.dart';
import 'package:dashboard/widgets/my_draggable_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ItemPanel extends StatefulWidget {
  final List<PlaceholderWidgets> items;
  final int crossAxisCount;
  final double spacing;
  final Function(PanelLocation) onDragStart;
  final Panel panel;
  final PanelLocation? dragStart;
  final PanelLocation? dropPreview;
  final PlaceholderWidgets? hoveringData;
  const ItemPanel({
    super.key,
    required this.items,
    required this.crossAxisCount,
    required this.spacing,
    required this.onDragStart,
    required this.panel,
    required this.dragStart,
    required this.dropPreview,
    required this.hoveringData,
  });
  @override
  State<ItemPanel> createState() => _ItemsPanelState();
}
class _ItemsPanelState extends State<ItemPanel> {
  /// function return the corresponding formcontrol widgets
  /// which serves as visual placeholders which are dragged from
  /// left widgets panels
  Widget getWidgetPlaceholders(PlaceholderWidgets controlName) {
    return switch (controlName) {
      PlaceholderWidgets.Textfield => TextField(
        enabled: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Textbox',
        ),
      ),
      PlaceholderWidgets.Dropdown => DropdownMenu(
        dropdownMenuEntries: [],
        enabled: false,
        hintText: 'DropDownField',
        width: 300,
      ),
      PlaceholderWidgets.Checkbox => Row(
        children: [
          Checkbox(
            value: true,
            onChanged: (value) {},
            semanticLabel: 'Checkbox',
          ),
          Text('Checkbox'),
        ],
      ),
      PlaceholderWidgets.Radio => Row(
        children: [
          Radio(
            toggleable: false,
            value: '',
            groupValue: '',
            onChanged: (value) {},
          ),
          Text('Radio'),
        ],
      ),
      PlaceholderWidgets.Button => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ElevatedButton(onPressed: () {}, child: Text('Save'))],
      ),
      PlaceholderWidgets.Label => Text('Label Field'),
    };
  }

  //Icon(Icons.text_fields, color: Colors.white),
  Widget renderIconsForFormControlsCard(PlaceholderWidgets controlName) {
    return switch (controlName) {
      PlaceholderWidgets.Textfield => Icon(
        Icons.text_fields,
        color: Colors.white,
      ),
      PlaceholderWidgets.Dropdown => Icon(Icons.menu, color: Colors.white),
      PlaceholderWidgets.Checkbox => Icon(Icons.check_box, color: Colors.white),
      PlaceholderWidgets.Radio => Icon(
        Icons.radio_button_checked,
        color: Colors.white,
      ),
      PlaceholderWidgets.Button => Icon(Icons.touch_app, color: Colors.white),
      PlaceholderWidgets.Label => Icon(Icons.label, color: Colors.white),
    };
  }

  @override
  Widget build(BuildContext context) {
    /// have a copy of dragstartCopy to keep the local copy
    /// so
    final itemsCopy = List<PlaceholderWidgets>.from(widget.items);
    print('itemscopy => $itemsCopy');
    if (widget.panel == Panel.upper) {
      return ListView(
        padding: const EdgeInsets.all(4),
        children:
            itemsCopy.asMap().entries.map<Widget>((e) {
              Widget child = SizedBox(
                height: 50,
                width: 0,

                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: getWidgetPlaceholders(e.value)),
                ),
              );
              // }
              return Padding(
                padding: const EdgeInsets.only(
                  left: 100,
                  bottom: 6.0,
                  right: 100,
                ),
                child: child,
              );
            }).toList(),
      );
    } else {
      return GridView.count(
        crossAxisCount: widget.crossAxisCount,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        padding: const EdgeInsets.all(4),
        children:
            itemsCopy.asMap().entries.map<Widget>((e) {
              Color textColor = Colors.white;
              Widget child = Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.teal.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      renderIconsForFormControlsCard(e.value),
                      Text(
                        e.value.name,
                        style: TextStyle(color: textColor, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
              return Draggable(
                feedback: child,
                child: MyDraggableWidget(
                  data: e.value.name,
                  onDragStart: () => widget.onDragStart((e.key, widget.panel)),
                  child: child,
                ),
              );
            }).toList(),
      );
    }
  }
}
