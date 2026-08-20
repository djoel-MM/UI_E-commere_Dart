import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  static const List<Map<String, String>> _notifications = [
    {
      'title': 'Pesanan Dikirim',
      'body': 'Pesanan #102930 sedang dalam perjalanan ke alamat Anda.',
      'time': '10:30',
    },
    {
      'title': 'Promo Spesial',
      'body': 'Dapatkan diskon hingga 58% untuk produk pilihan hari ini!',
      'time': '09:15',
    },
    {
      'title': 'Selamat Datang',
      'body': 'Terima kasih telah bergabung di DP Shop.',
      'time': '08:00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color(0xFF0D9488),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _notifications.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final n = _notifications[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFF0D9488),
                child: Icon(Icons.notifications, color: Colors.white),
              ),
              title: Text(
                n['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(n['body']!),
              trailing: Text(
                n['time']!,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}
