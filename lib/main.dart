import 'package:flutter/material.dart';
import 'pages/account_page.dart';
import 'pages/cart_page.dart';
import 'pages/change_password_page.dart';
import 'pages/detailChatPage/detail_chat.dart';
import 'pages/help_page.dart';
import 'pages/home_page.dart';
import 'pages/list.chat.dart';
import 'pages/login_page.dart';
import 'pages/notifications_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ui ecommerce',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D9488)),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        // Halaman login sebagai layar pertama saat aplikasi dibuka.
        '/login': (context) => const LoginPage(),
        // Halaman utama (Home + Cart + Account lewat bottom navigation).
        '/': (context) => const HomePage(),
        // Halaman akun.
        '/account': (context) => const AccountPage(),
        // Halaman keranjang.
        '/cart': (context) => const CartPage(),
        // Halaman ubah password.
        '/change-password': (context) => const ChangePasswordPage(),
        // Halaman notifikasi.
        '/notifications': (context) => const NotificationsPage(),
        // Halaman bantuan.
        '/help': (context) => const HelpPage(),
        // Halaman daftar chat.
        '/chats': (context) => ChatListPage(),
        // Halaman detail chat. Menerima argumen {'contactName': String}.
        'ChatDetail': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final contactName =
              args is Map ? (args['contactName'] as String?) ?? 'Chat' : 'Chat';
          return ChatScreen(contactName: contactName);
        },
      },
    );
  }
}
