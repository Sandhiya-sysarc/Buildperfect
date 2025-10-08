import 'package:dashboard/widgets/api_left_panel.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: SplitPanel());
  }
}

class SplitPanel extends StatefulWidget {
  final int columns;
  final double itemSpacing;
  const SplitPanel({super.key, this.columns = 2, this.itemSpacing = 2.0});

  @override
  State<SplitPanel> createState() => _SplitPanelState();
}

class _SplitPanelState extends State<SplitPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API'),
        elevation: 2,
        actions: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            child: Text("Create api", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final leftPanelWidth = constraints.maxWidth / 2;
          final centerPanelWidth = constraints.maxWidth / 2;
          return Padding(
            padding: const EdgeInsets.only(top: 8, left: 4, right: 8),
            child: Stack(
              children: [
                Positioned(
                  width: leftPanelWidth - 150,
                  height: constraints.maxHeight,
                  left: 0,
                  child:ApiLeftPanel()
                ),
                Positioned(
                  // centerpanel for dragtarget
                  width: centerPanelWidth + 150,
                  height: constraints.maxHeight,
                  left: leftPanelWidth - 150,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.pink.shade100),
                    child: MaterialButton(onPressed: () {}),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
