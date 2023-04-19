import 'package:flutter/material.dart';

import 'camera_view.dart';
import 'gallery_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.camera_alt), label: 'Камера'),
    const BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Галерея'),
  ];

  final pages = const [CameraView(), GalleryView()];

  int _selectedIndex = 0;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: bottomItems.length);
    _tabController.addListener(() {
      _selectedIndex = _tabController.index;
      setState(() {});
    });
  }

  void _onItemTapped(int index) {
    _tabController.index = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(bottomItems[_tabController.index].label ?? '')),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: bottomItems),
    );
  }
}
