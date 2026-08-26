import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ui_e_commerce/pages/admin/admin_dashboard_page.dart';
import 'package:ui_e_commerce/pages/admin/admin_orders_page.dart';
import 'package:ui_e_commerce/pages/admin/admin_products_page.dart';

class AdminShell extends StatefulWidget {
  const AdminShell({super.key});

  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  static const List<String> _titles = ['Dashboard Admin', 'Kelola Produk', 'Kelola Pesanan'];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F766E),
        foregroundColor: Colors.white,
        title: Text(_titles[_currentIndex]),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) => setState(() => _currentIndex = index),
        children: const [
          AdminDashboardPage(),
          AdminProductsPage(),
          AdminOrdersPage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        height: 68,
        color: const Color(0xFF0F766E),
        items: const <Widget>[
          Icon(Icons.dashboard, size: 26, color: Colors.white),
          Icon(Icons.inventory_2, size: 26, color: Colors.white),
          Icon(Icons.receipt_long, size: 26, color: Colors.white),
        ],
        index: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
