import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ui_e_commerce/pages/account_page.dart';
import 'package:ui_e_commerce/pages/cart_page.dart';
import 'package:ui_e_commerce/widgets/categories_widget.dart';
import 'package:ui_e_commerce/widgets/home_app_bar.dart';
import 'package:ui_e_commerce/widgets/items_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String _selectedCategory = 'Semua';
  final PageController _pageController = PageController();

  void _goToTab(int index) {
    _pageController.jumpToPage(index);
    setState(() => _currentIndex = index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          _buildHomeContent(),
          CartPage(onBack: () => _goToTab(0)),
          const AccountPage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        height: 70,
        color: const Color(0xFF0D9488),
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.shopping_cart, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }

  Widget _buildHomeContent() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        HomeAppBar(
          onCartTap: () => _goToTab(1),
          onChatTap: () => Navigator.pushNamed(context, '/chats'),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Kategori',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D9488),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              CategoriesWidget(
                selected: _selectedCategory,
                onTap: (category) =>
                    setState(() => _selectedCategory = category),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const FlashSaleRow(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedCategory == 'Semua'
                    ? 'Rekomendasi Untukmu'
                    : _selectedCategory,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F766E),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/search'),
                child: const Row(
                  children: [
                    Text(
                      'Lihat Semua',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF0D9488),
                      ),
                    ),
                    Icon(Icons.chevron_right,
                        size: 18, color: Color(0xFF0D9488)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Items(category: _selectedCategory),
      ],
    );
  }
}
