import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/dummy_data.dart';
import '../../models/product.dart';
import '../../providers/product_provider.dart';

class AdminProductFormPage extends StatefulWidget {
  const AdminProductFormPage({super.key, this.product});

  final Product? product;

  @override
  State<AdminProductFormPage> createState() => _AdminProductFormPageState();
}

class _AdminProductFormPageState extends State<AdminProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _originalController;
  late final TextEditingController _stockController;
  late final TextEditingController _descController;

  late String _category;
  late String _image;
  late bool _isFlashSale;

  bool get _isEdit => widget.product != null;

  @override
  void initState() {
    super.initState();
    final product = widget.product;
    _nameController = TextEditingController(text: product?.name ?? '');
    _priceController =
        TextEditingController(text: product?.price.toString() ?? '');
    _originalController = TextEditingController(
        text: product?.originalPrice?.toString() ?? '');
    _stockController =
        TextEditingController(text: product?.stock.toString() ?? '50');
    _descController =
        TextEditingController(text: product?.description ?? '');
    _category = product?.category ?? categories.skip(1).first;
    _image = product?.image ?? categorySampleImages['Elektronik']!;
    _isFlashSale = product?.isFlashSale ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _originalController.dispose();
    _stockController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final catalog = context.read<ProductCatalog>();
    final price = int.tryParse(_priceController.text) ?? 0;
    final original =
        int.tryParse(_originalController.text.isEmpty ? '0' : _originalController.text);

    final product = Product(
      id: widget.product?.id ??
          'p${DateTime.now().millisecondsSinceEpoch}',
      name: _nameController.text,
      category: _category,
      price: price,
      originalPrice:
          original != null && original > price ? original : null,
      stock: int.tryParse(_stockController.text) ?? 0,
      image: _image,
      description: _descController.text,
      isFlashSale: _isFlashSale,
      rating: widget.product?.rating ?? 4.5,
      sold: widget.product?.sold ?? 0,
    );

    if (_isEdit) {
      catalog.updateProduct(product);
    } else {
      catalog.addProduct(product);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            _isEdit ? 'Produk diperbarui' : 'Produk "${product.name}" ditambahkan'),
        backgroundColor: const Color(0xFF0F766E),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F766E),
        foregroundColor: Colors.white,
        title: Text(_isEdit ? 'Edit Produk' : 'Tambah Produk'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: _input('Nama Produk'),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Nama wajib diisi' : null,
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              value: categories.contains(_category) ? _category : categories[1],
              decoration: _input('Kategori'),
              items: categories
                  .skip(1)
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) => setState(() => _category = v!),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: _input('Harga (Rp)'),
                    validator: (v) {
                      final price = int.tryParse(v ?? '');
                      if (price == null || price <= 0) {
                        return 'Harga tidak valid';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _originalController,
                    keyboardType: TextInputType.number,
                    decoration: _input('Harga Asli (opsional)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _stockController,
              keyboardType: TextInputType.number,
              decoration: _input('Stok'),
              validator: (v) {
                final stock = int.tryParse(v ?? '');
                if (stock == null || stock < 0) return 'Stok tidak valid';
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _descController,
              maxLines: 4,
              decoration: _input('Deskripsi Produk'),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              value: _image,
              decoration: _input('Gambar (network)'),
              items: [
                if (!categorySampleImages.values.contains(_image))
                  DropdownMenuItem(
                    value: _image,
                    child: const Text('Gambar saat ini'),
                  ),
                for (final entry in categorySampleImages.entries)
                  DropdownMenuItem(
                    value: entry.value,
                    child: Text('Sampel kategori ${entry.key}'),
                  ),
              ],
              onChanged: (v) => setState(() => _image = v!),
            ),
            const SizedBox(height: 14),
            SwitchListTile(
              value: _isFlashSale,
              activeColor: const Color(0xFF0D9488),
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Tampilkan di Flash Sale',
                style: TextStyle(fontSize: 14),
              ),
              onChanged: (v) => setState(() => _isFlashSale = v),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D9488),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  _isEdit ? 'Simpan Perubahan' : 'Tambah Produk',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _input(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
