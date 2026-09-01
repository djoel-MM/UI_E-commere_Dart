import '../models/order.dart';
import '../models/product.dart';
import '../models/voucher.dart';

// URL gambar network (CDN Unsplash/Pexels) yang dicocokkan dengan
// kategori masing-masing produk.
const String imgP1 =
    'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?q=80&w=640&auto=format&fit=crop';
const String imgP2 =
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=640&auto=format&fit=crop';
const String imgP3 =
    'https://images.unsplash.com/photo-1622434641406-a158123450f9?q=80&w=640&auto=format&fit=crop';
const String imgP4 =
    'https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?q=80&w=640&auto=format&fit=crop';
const String imgP5 =
    'https://images.unsplash.com/photo-1510017803434-a899398421b3?q=80&w=640&auto=format&fit=crop';
const String imgP6 =
    'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=640&auto=format&fit=crop';
const String imgP7 =
    'https://images.unsplash.com/photo-1622597467836-f3285f2131b8?q=80&w=640&auto=format&fit=crop';
const String imgP8 =
    'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?q=80&w=640&auto=format&fit=crop';
const String imgP9 =
    'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?q=80&w=640&auto=format&fit=crop';
const String imgP10 =
    'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?q=80&w=640&auto=format&fit=crop';

// Contoh gambar network per kategori (dipakai form produk admin).
const Map<String, String> categorySampleImages = {
  'Elektronik':
      'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=640&auto=format&fit=crop',
  'Fashion':
      'https://images.unsplash.com/photo-1445205170230-053b83016050?q=80&w=640&auto=format&fit=crop',
  'Makanan':
      'https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg?auto=compress&cs=tinysrgb&w=640',
  'Skincare':
      'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?q=80&w=640&auto=format&fit=crop',
  'Olahraga':
      'https://images.unsplash.com/photo-1518611012118-696072aa579a?q=80&w=640&auto=format&fit=crop',
};

const List<String> categories = [
  'Semua',
  'Elektronik',
  'Fashion',
  'Makanan',
  'Skincare',
  'Olahraga',
];

const Map<String, String> categoryIcons = {
  'Semua': 'menu',
  'Elektronik': 'devices',
  'Fashion': 'checkroom',
  'Makanan': 'fastfood',
  'Skincare': 'spa',
  'Olahraga': 'sports',
};

final List<Product> dummyProducts = [
  Product(
    id: 'p1',
    name: 'Garmin Forerunner 165 Aqua',
    category: 'Elektronik',
    price: 2899000,
    originalPrice: 3499000,
    rating: 4.9,
    sold: 1200,
    stock: 25,
    image: imgP1,
    isFlashSale: true,
    description:
        'Smartwatch GPS khusus lari dengan layar AMOLED, pelacakan ritme latihan, dan baterai tahan hingga 11 hari.',
  ),
  Product(
    id: 'p2',
    name: 'Garmin Fenix 7 Pro Sapphire',
    category: 'Elektronik',
    price: 9999000,
    originalPrice: 11999000,
    rating: 4.8,
    sold: 340,
    stock: 12,
    image: imgP2,
    isFlashSale: true,
    description:
        'Jam multiorientasi premium dengan kaca sapphire, solar charging, dan peta topo lengkap untuk petualangan.',
  ),
  Product(
    id: 'p3',
    name: 'Forerunner 165 Strap Edition',
    category: 'Olahraga',
    price: 349000,
    originalPrice: 499000,
    rating: 4.6,
    sold: 2100,
    stock: 60,
    image: imgP3,
    description: 'Strap silikon pengganti nyaman dan tahan keringat, cocok untuk semua ukuran pergelangan.',
  ),
  Product(
    id: 'p4',
    name: 'Fenix Pro Bundle Aksesoris',
    category: 'Olahraga',
    price: 799000,
    rating: 4.5,
    sold: 870,
    stock: 40,
    image: imgP4,
    description: 'Bundel aksesoris berisi strap kulit, screen protector, dan travel pouch eksklusif.',
  ),
  Product(
    id: 'p5',
    name: 'Smart Band Aqua Tracker',
    category: 'Elektronik',
    price: 459000,
    originalPrice: 699000,
    rating: 4.4,
    sold: 5600,
    stock: 80,
    image: imgP5,
    isFlashSale: true,
    description: 'Fitness ringkas dengan detak jantung 24 jam, SpO2, dan notifikasi pintar dari smartphone.',
  ),
  Product(
    id: 'p6',
    name: 'Sportswear Dry-Fit Tees',
    category: 'Fashion',
    price: 189000,
    originalPrice: 259000,
    rating: 4.7,
    sold: 3400,
    stock: 120,
    image: imgP6,
    description: 'Kaus olahraga bahan dry-fit ringan, cepat kering, tersedia berbagai ukuran.',
  ),
  Product(
    id: 'p7',
    name: 'Recovery Protein Snack Bar',
    category: 'Makanan',
    price: 95000,
    rating: 4.3,
    sold: 8900,
    stock: 200,
    image: imgP7,
    description: 'Snack bar protein 15g rendah gula, ideal untuk pemulihan setelah latihan.',
  ),
  Product(
    id: 'p8',
    name: 'Aqua Mineral Serum 30ml',
    category: 'Skincare',
    price: 129000,
    originalPrice: 179000,
    rating: 4.8,
    sold: 4100,
    stock: 65,
    image: imgP8,
    description: 'Serum hidrasi dengan hyaluronic acid dan ekstrak air mineral untuk kulit lembap sepanjang hari.',
  ),
  Product(
    id: 'p9',
    name: 'Running Pouch Lite',
    category: 'Olahraga',
    price: 79000,
    rating: 4.2,
    sold: 1500,
    stock: 90,
    image: imgP9,
    description: 'Pouch pinggang ringan anti air untuk membawa HP dan kunci saat berlari.',
  ),
  Product(
    id: 'p10',
    name: 'Sapphire Glass Protector Kit',
    category: 'Elektronik',
    price: 149000,
    originalPrice: 219000,
    rating: 4.6,
    sold: 2300,
    stock: 8,
    image: imgP10,
    description: 'Pelindung layar tempered glass kekerasan 9H dengan alat pasang lengkap.',
  ),
];

const List<Voucher> dummyVouchers = [
  Voucher(
    code: 'TECH10',
    title: 'Diskon 10% maks Rp 50.000',
    subtitle: 'Berlaku untuk semua produk elektronik & aksesoris',
    minSpend: 300000,
    discountValue: 10,
    type: VoucherType.percent,
  ),
  Voucher(
    code: 'GRATISONGKIR',
    title: 'Gratis ongkir semua ekspedisi',
    subtitle: 'Min. belanja Rp 150.000, berlaku seluruh Indonesia',
    minSpend: 150000,
    discountValue: 0,
    type: VoucherType.shipping,
  ),
  Voucher(
    code: 'NEW25K',
    title: 'Potongan Rp 25.000',
    subtitle: 'Khusus pengguna baru, min. belanja Rp 200.000',
    minSpend: 200000,
    discountValue: 25000,
    type: VoucherType.fixed,
  ),
];

final List<Order> dummyOrders = [
  Order(
    id: 'INV-2026-0101',
    items: [
      const OrderItem(
        productId: 'p1',
        name: 'Garmin Forerunner 165 Aqua',
        image: imgP1,
        price: 2899000,
        quantity: 1,
      ),
    ],
    recipient: 'Ade Setiawan',
    phone: '0812-3456-7890',
    address: 'Jl. Merdeka No. 45, Bandung, Jawa Barat 40115',
    courier: 'Reguler',
    shippingCost: 15000,
    paymentMethod: 'Transfer Bank',
    subtotal: 2899000,
    discount: 0,
    total: 2914000,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    status: OrderStatus.shipped,
  ),
  Order(
    id: 'INV-2026-0098',
    items: [
      const OrderItem(
        productId: 'p7',
        name: 'Recovery Protein Snack Bar',
        image: imgP7,
        price: 95000,
        quantity: 3,
      ),
      const OrderItem(
        productId: 'p9',
        name: 'Running Pouch Lite',
        image: imgP9,
        price: 79000,
        quantity: 1,
      ),
    ],
    recipient: 'Ade Setiawan',
    phone: '0812-3456-7890',
    address: 'Jl. Merdeka No. 45, Bandung, Jawa Barat 40115',
    courier: 'Hemat',
    shippingCost: 9000,
    paymentMethod: 'E-Wallet',
    subtotal: 364000,
    discount: 25000,
    total: 348000,
    createdAt: DateTime.now().subtract(const Duration(days: 6)),
    status: OrderStatus.completed,
  ),
];
