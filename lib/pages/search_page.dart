import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../widgets/items_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.initialQuery = '', this.initialCategory = 'Semua'});

  final String initialQuery;
  final String initialCategory;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialQuery);
  late String _query = widget.initialQuery;
  late String _category = widget.initialCategory;
  String _sort = 'relevan';

  static const List<String> _sortOptions = [
    'relevan',
    'termurah',
    'termahal',
    'terlaris',
    'rating',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = context.watch<ProductCatalog>().search(
          query: _query,
          category: _category,
          sort: _sort,
        );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D9488),
        foregroundColor: Colors.white,
        title: TextField(
          controller: _controller,
          autofocus: widget.initialQuery.isEmpty,
          onSubmitted: (value) => setState(() => _query = value),
          style: const TextStyle(color: Colors.white, fontSize: 15),
          decoration: InputDecoration(
            hintText: 'Cari produk atau kategori...',
            hintStyle: TextStyle(color: Colors.teal.shade100, fontSize: 14),
            prefixIcon: const Icon(Icons.search, color: Colors.white),
            suffixIcon: _query.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      _controller.clear();
                      setState(() => _query = '');
                    },
                  )
                : null,
            filled: true,
            fillColor: Colors.white24,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(999),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              children: [
                SizedBox(
                  height: 36,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (final category
                          in context.watch<ProductCatalog>().categoriesWithStock)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(category),
                            selected: _category == category,
                            selectedColor: const Color(0xFF0D9488),
                            labelStyle: TextStyle(
                              color: _category == category
                                  ? Colors.white
                                  : Colors.grey.shade700,
                              fontSize: 12,
                            ),
                            onSelected: (_) =>
                                setState(() => _category = category),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 34,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (final sort in _sortOptions)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            avatar: Icon(
                              _sortIcon(sort),
                              size: 15,
                              color: _sort == sort
                                  ? Colors.white
                                  : const Color(0xFF0D9488),
                            ),
                            label: Text(sort),
                            selected: _sort == sort,
                            selectedColor: const Color(0xFF0F766E),
                            labelStyle: TextStyle(
                              color: _sort == sort
                                  ? Colors.white
                                  : Colors.grey.shade700,
                              fontSize: 12,
                            ),
                            onSelected: (_) => setState(() => _sort = sort),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off,
                            size: 60, color: Colors.grey.shade400),
                        const SizedBox(height: 8),
                        Text(
                          'Tidak ada produk ditemukan',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.only(top: 8),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '${results.length} produk ditemukan',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Items(
                        category: _category,
                        query: _query,
                        sort: _sort,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  IconData _sortIcon(String sort) {
    switch (sort) {
      case 'termurah':
        return Icons.arrow_downward;
      case 'termahal':
        return Icons.arrow_upward;
      case 'terlaris':
        return Icons.local_fire_department;
      case 'rating':
        return Icons.star;
      default:
        return Icons.sort;
    }
  }
}
