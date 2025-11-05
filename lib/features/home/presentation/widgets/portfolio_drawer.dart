import 'package:flutter/material.dart';

class PortfolioDrawer extends StatefulWidget {
  const PortfolioDrawer({
    Key? key,
    required this.tabController,
    required this.tabs,
  }) : super(key: key);
  final TabController tabController;
  final List<String> tabs;
  @override
  State<PortfolioDrawer> createState() => _PortfolioDrawerState();
}

class _PortfolioDrawerState extends State<PortfolioDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.deepPurpleAccent],
              ),
            ),
            child: const Center(
              child: Icon(Icons.code, color: Colors.white, size: 60),
            ),
          ),
          ...widget.tabs.map(
            (t) => ListTile(
              title: Text(t),
              onTap: () {
                final index = widget.tabs.indexOf(t);
                widget.tabController.animateTo(index);
                Navigator.pop(context);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
