import 'package:flutter/material.dart';
import 'package:ui_e_commerce/widgets/cart_app_bar.dart';
import 'package:ui_e_commerce/widgets/cart_bottom_nav_bar.dart';
import 'package:ui_e_commerce/widgets/cart_samples_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          CartAppBar(onBack: onBack),
          Container(
            padding: const EdgeInsets.only(top: 15, bottom: 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: const Column(
              children: [
                CartSamples(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CartBottomNavBar(),
    );
  }
}
