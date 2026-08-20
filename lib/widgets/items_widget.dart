import 'package:flutter/material.dart';

class Items extends StatelessWidget {
  const Items({super.key});

  // Daftar aset gambar produk (lokal). Dua gambar jam diulang mengisi 4 slot.
  static const List<String> _productImages = [
    'images/items/forerunner-165-aqua-cf-lg.webp',
    'images/items/fenix-7-pro-sapphire-carbongray-cf-lg.webp',
    'images/items/forerunner-165-aqua-cf-lg.webp',
    'images/items/fenix-7-pro-sapphire-carbongray-cf-lg.webp',
  ];

  static const List<String> myProductName = [
    'Outfit',
    'Makanan',
    'Skincare',
    'Electronic',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.68,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        // Perulangan untuk Menampilkan Item Produk
        for (int i = 0; i < myProductName.length; i++)
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF97316),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '-58%',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Icon(Icons.favorite_border, color: Colors.red),
                  ],
                ),


                InkWell(
                  onTap: () {

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Halaman detail produk belum tersedia'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Image.asset(
                      _productImages[i],
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox(
                        height: 100,
                        width: 100,
                        child: Icon(
                          Icons.image,
                          size: 50,
                          color: Color(0xFF0D9488),
                        ),
                      ),
                    ),
                  ),
                ),

                // Nama Produk dan Deskripsi
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    myProductName[i],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF0D9488),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Write description Product',
                    style: TextStyle(fontSize: 14, color: Color(0xFF0D9488)),
                  ),
                ),

                // Harga dan Ikon Keranjang
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$65',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D9488),
                        ),
                      ),
                      Icon(
                        Icons.shopping_cart,
                        size: 20,
                        color: Color(0xFF0D9488),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
