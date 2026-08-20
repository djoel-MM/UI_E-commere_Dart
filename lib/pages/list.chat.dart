import 'package:flutter/material.dart';

class ChatListPage extends StatelessWidget {
  ChatListPage({super.key});

  final List<Map<String, String>> chats = [
    {
      'name': 'Nike Official',
      'message': 'Segera Memesan Sebelum Kehabisan.',
      'time': '12:30',
      'avatar': 'images/avatars/Nike-Logo.png',
    },
    {
      'name': 'Expander',
      'message': 'Hallo, Selamat Datang Di Nike Official.',
      'time': '12:05',
      'avatar': 'images/avatars/Nike-Logo.png',
    },
    // Tambahkan chat lainnya...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Chat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color(0xFF0D9488),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF0D9488)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Tombol Filter (Semua & Belum Dibaca)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 8.0),
            color: Colors.white,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Semua',
                    style: TextStyle(
                      color: Color(0xFF0D9488),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Belum Dibaca',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 114, 123, 216),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // List Chat
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(chat['avatar']!),
                    radius: 25,
                  ),
                  title: Text(
                    chat['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(chat['message']!),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        chat['time']!,
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      if (index == 0) // Indicator jika ada pesan belum dibaca
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            '1',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      "ChatDetail",
                      arguments: {
                        'contactName': chat['name']!,
                        'avatarAsset': chat['avatar']!,
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}