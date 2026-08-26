import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/account_page.dart';
import 'pages/admin/admin_shell.dart';
import 'pages/cart_page.dart';
import 'pages/change_password_page.dart';
import 'pages/checkout_page.dart';
import 'pages/detailChatPage/detail_chat.dart';
import 'pages/help_page.dart';
import 'pages/home_page.dart';
import 'pages/list.chat.dart';
import 'pages/login_page.dart';
import 'pages/notifications_page.dart';
import 'pages/order_detail_page.dart';
import 'pages/orders_page.dart';
import 'pages/payment_page.dart';
import 'pages/product_detail_page.dart';
import 'pages/register_page.dart';
import 'pages/search_page.dart';
import 'pages/wishlist_page.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'providers/product_provider.dart';
import 'providers/wishlist_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => ProductCatalog()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => Wishlist()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
      child: MaterialApp(
        title: 'TealShop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D9488)),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/': (context) => const HomePage(),
          '/admin': (context) => const AdminShell(),
          '/account': (context) => const AccountPage(),
          '/cart': (context) => const CartPage(),
          '/checkout': (context) => const CheckoutPage(),
          '/payment': (context) => const PaymentPage(),
          '/payment-success': (context) => const PaymentSuccessPage(),
          '/product-detail': (context) {
            final args = ModalRoute.of(context)?.settings.arguments;
            final productId = args is String ? args : '';
            return ProductDetailPage(productId: productId);
          },
          '/search': (context) {
            final args = ModalRoute.of(context)?.settings.arguments;
            final map = args is Map<String, String> ? args : {};
            return SearchPage(
              initialQuery: map['query'] ?? '',
              initialCategory: map['category'] ?? 'Semua',
            );
          },
          '/orders': (context) => const OrdersPage(),
          '/order-detail': (context) {
            final args = ModalRoute.of(context)?.settings.arguments;
            final orderId = args is String ? args : '';
            return OrderDetailPage(orderId: orderId);
          },
          '/wishlist': (context) => const WishlistPage(),
          '/change-password': (context) => const ChangePasswordPage(),
          '/notifications': (context) => const NotificationsPage(),
          '/help': (context) => const HelpPage(),
          '/chats': (context) => ChatListPage(),
          'ChatDetail': (context) {
            final args = ModalRoute.of(context)?.settings.arguments;
            final contactName =
                args is Map ? (args['contactName'] as String?) ?? 'Chat' : 'Chat';
            return ChatScreen(contactName: contactName);
          },
        },
      ),
    );
  }
}
