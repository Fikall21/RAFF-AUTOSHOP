import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const VelgMobilPastelApp());
}

class VelgMobilPastelApp extends StatelessWidget {
  const VelgMobilPastelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RAFF AUTOSHOP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAF7F2),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE8D7F1),
          primary: const Color(0xFF6C5B7B),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final String category;
  final String specs;
  final String imagePath;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.specs,
    required this.imagePath,
  });
}

class PromoBanner {
  final String title;
  final String subtitle;
  final String tag;
  final List<Color> gradientColors;
  final IconData icon;

  const PromoBanner({
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.gradientColors,
    required this.icon,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController();
  int _cartCount = 0;
  int _currentBannerIndex = 0;
  Timer? _bannerTimer;

  // Banner Promo Iklan Geser-Geser
  final List<PromoBanner> _promoList = const [
    PromoBanner(
      title: 'Katalog Velg Racing Stylish',
      subtitle: 'Diskon Hingga 25% Seri JDM & Forged Monoblock',
      tag: 'SPECIAL PROMO',
      gradientColors: [Color(0xFFD4E09B), Color(0xFFF6D4BA), Color(0xFFE8D7F1)],
      icon: Icons.directions_car_filled_outlined,
    ),
    PromoBanner(
      title: 'Gratis Fiting & Spooring',
      subtitle: 'Setiap Pembelian 1 Set Velg Ring 15 - 19 Inch',
      tag: 'BONUS SERVICE',
      gradientColors: [Color(0xFFF6D4BA), Color(0xFFE8D7F1), Color(0xFFB0C4DE)],
      icon: Icons.build_circle_outlined,
    ),
    PromoBanner(
      title: 'Cicilan 0% Seluruh Velg',
      subtitle: 'Bayar Ringan Pakai Kartu Kredit atau Paylater',
      tag: 'EASY PAYMENT',
      gradientColors: [Color(0xFFE8D7F1), Color(0xFFD8B4E2), Color(0xFFF08A8B)],
      icon: Icons.credit_card_outlined,
    ),
  ];

  // 12 Katalog Velg Mobil Lokal WebP
  final List<Product> _allProducts = const [
    Product(
      id: 101,
      title: 'Rays Volk TE37 Bronze',
      description:
          'Velg Forged Monoblock legendaris JDM, super ringan dan kokoh untuk street racing.',
      price: 1250,
      rating: 4.9,
      category: 'Forged JDM',
      specs: 'Ring 17 • PCD 4x100 • ET 35',
      imagePath: 'assets/te37.webp',
    ),
    Product(
      id: 102,
      title: 'BBS LM Diamond Silver',
      description:
          'Velg 2-piece mesh klasik khas Eropa dengan finishing polished lip premium.',
      price: 1450,
      rating: 5.0,
      category: 'Classic Mesh',
      specs: 'Ring 18 • PCD 5x114.3 • ET 40',
      imagePath: 'assets/bbs.webp',
    ),
    Product(
      id: 103,
      title: 'Enkei RPF1 Silver',
      description:
          'Teknologi MAT ringan khas balap seri Enkei, cocok untuk harian dan track day.',
      price: 980,
      rating: 4.8,
      category: 'Lightweight',
      specs: 'Ring 15 • PCD 4x100 • ET 38',
      imagePath: 'assets/rpf1.webp',
    ),
    Product(
      id: 104,
      title: 'Work Equip 05 Chrome',
      description:
          'Desain 3-piece retro VIP style dengan spoke lebar dan kilau krom mewah.',
      price: 1350,
      rating: 4.7,
      category: 'Retro VIP',
      specs: 'Ring 16 • PCD 4x114.3 • ET 25',
      imagePath: 'assets/equip.webp',
    ),
    Product(
      id: 105,
      title: 'Advan Racing GT',
      description:
          'Velg Forged JDM sporty dengan kekuatan struktur tinggi untuk performa optimal.',
      price: 1380,
      rating: 4.9,
      category: 'Forged JDM',
      specs: 'Ring 18 • PCD 5x114.3 • ET 30',
      imagePath: 'assets/advan.webp',
    ),
    Product(
      id: 106,
      title: 'HSR Wheel Custom',
      description:
          'Velg lokal kualitas ekspor dengan desain modern dan bobot terukur presisi.',
      price: 850,
      rating: 4.7,
      category: 'Sporty Rims',
      specs: 'Ring 16 • PCD 4x100 • ET 38',
      imagePath: 'assets/hsr.webp',
    ),
    Product(
      id: 107,
      title: 'Rotiform Astro Silver',
      description:
          'Tampilan stance Eropa dengan garis spoke agresif dan lip manis.',
      price: 1120,
      rating: 4.8,
      category: 'European Stance',
      specs: 'Ring 17 • PCD 5x112 • ET 42',
      imagePath: 'assets/astro.webp',
    ),
    Product(
      id: 108,
      title: 'Regamaster Evo White',
      description:
          'Velg ultra lightweight buatan Rusia/Jepang, ikon balap lintasan.',
      price: 1500,
      rating: 5.0,
      category: 'Ultra Lightweight',
      specs: 'Ring 15 • PCD 4x100 • ET 35',
      imagePath: 'assets/evo.webp',
    ),
    Product(
      id: 109,
      title: 'Samlong Performance',
      description:
          'Desain khas gaya Thailand street racing dengan palang tegas dan warna tajam.',
      price: 920,
      rating: 4.6,
      category: 'Street Racing',
      specs: 'Ring 15 • PCD 4x100 • ET 32',
      imagePath: 'assets/samlong.webp',
    ),
    Product(
      id: 110,
      title: 'HSR Tikala Series',
      description:
          'Desain concaved gagah cocok untuk city car maupun sedan harian stylish.',
      price: 880,
      rating: 4.7,
      category: 'Daily Sport',
      specs: 'Ring 16 • PCD 4x100 • ET 40',
      imagePath: 'assets/tikala.webp',
    ),
    Product(
      id: 111,
      title: 'Venom Racing Series',
      description:
          'Spoke multi-fin tipis berbahan alloy ringan untuk pengereman maksimal.',
      price: 1050,
      rating: 4.8,
      category: 'Tuner Series',
      specs: 'Ring 17 • PCD 5x114.3 • ET 38',
      imagePath: 'assets/venom.webp',
    ),
    Product(
      id: 112,
      title: 'Yuzawa Japanese Spec',
      description:
          'Velg gaya JDM klasik dengan finishing mulus dan konstruksi tahan gores.',
      price: 1150,
      rating: 4.8,
      category: 'Classic JDM',
      specs: 'Ring 17 • PCD 5x100 • ET 42',
      imagePath: 'assets/yuzawa.webp',
    ),
  ];

  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = List.from(_allProducts);
    // Auto-scroll banner tiap 4 detik
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentBannerIndex + 1) % _promoList.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = List.from(_allProducts);
      } else {
        _filteredProducts = _allProducts
            .where((p) =>
                p.title.toLowerCase().contains(query.toLowerCase()) ||
                p.category.toLowerCase().contains(query.toLowerCase()) ||
                p.specs.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RAFF AUTOSHOP',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: Color(0xFF4A3E56),
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: const Color(0xFFE8D7F1),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  const Icon(Icons.shopping_bag_outlined,
                      color: Color(0xFF4A3E56), size: 26),
                  if (_cartCount > 0)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF08A8B),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$_cartCount',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Kolom Pencarian
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: const BoxDecoration(
              color: Color(0xFFE8D7F1),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Cari TE37, BBS, Ring 17, JDM...',
                hintStyle:
                    const TextStyle(color: Color(0xFF9A82A6), fontSize: 13),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF6C5B7B)),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear,
                            color: Color(0xFF6C5B7B), size: 18),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFFF5EBF8),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Banner Iklan Geser-Geser (Carousel)
          const SizedBox(height: 12),
          SizedBox(
            height: 110,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _promoList.length,
              onPageChanged: (index) {
                setState(() => _currentBannerIndex = index);
              },
              itemBuilder: (context, index) {
                final banner = _promoList[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: banner.gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6C5B7B).withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                banner.tag,
                                style: const TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF4A3E56),
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              banner.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C2235),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              banner.subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF6C5B7B),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(banner.icon,
                          size: 38, color: const Color(0xFF4A3E56)),
                    ],
                  ),
                );
              },
            ),
          ),

          // Indicator Titik Slider Banner
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_promoList.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: _currentBannerIndex == index ? 18 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: _currentBannerIndex == index
                      ? const Color(0xFF6C5B7B)
                      : const Color(0xFFD8D0DD),
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),

          // Grid Katalog Velg
          Expanded(
            child: _filteredProducts.isEmpty
                ? const Center(
                    child: Text('Velg tidak ditemukan.',
                        style: TextStyle(color: Color(0xFF8E7C9B))),
                  )
                : GridView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return _buildProductCard(context, product);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              product: product,
              onAddToCart: () => setState(() => _cartCount++),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C5B7B).withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFFF3EAF7),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    product.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFFE8D7F1),
                      child: const Center(
                        child: Icon(Icons.directions_car_filled,
                            size: 48, color: Color(0xFF6C5B7B)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9A82A6),
                        letterSpacing: 0.8),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF2C2235)),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.specs,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 9,
                        color: Color(0xFF8E7C9B),
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${product.price.toInt()}',
                    style: const TextStyle(
                        color: Color(0xFF6C5B7B),
                        fontWeight: FontWeight.w900,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const DetailPage(
      {super.key, required this.product, required this.onAddToCart});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _selectedRingIndex = 0;
  final List<String> _ringSizes = const [
    'Ring 15',
    'Ring 16',
    'Ring 17',
    'Ring 18'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A3E56))),
        backgroundColor: const Color(0xFFE8D7F1),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF4A3E56)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    color: const Color(0xFFF3EAF7),
                    padding: const EdgeInsets.all(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        widget.product.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: const Color(0xFFE8D7F1),
                          child: const Center(
                            child: Icon(Icons.directions_car_filled,
                                size: 90, color: Color(0xFF6C5B7B)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8D7F1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                widget.product.category.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF6C5B7B)),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    size: 16, color: Color(0xFFF4A261)),
                                const SizedBox(width: 4),
                                Text('${widget.product.rating}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF8E7C9B))),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.product.title,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF2C2235)),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.product.specs,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8E7C9B)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${widget.product.price.toInt()}',
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF6C5B7B)),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Pilih Ukuran Ring Velg',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A3E56)),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: List.generate(_ringSizes.length, (index) {
                            final isSelected = _selectedRingIndex == index;
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedRingIndex = index),
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF6C5B7B)
                                      : const Color(0xFFF3EAF7),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  _ringSizes[index],
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF6C5B7B),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Deskripsi & Spesifikasi',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C2235)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.product.description,
                          style: const TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: Color(0xFF8E7C9B)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5B7B),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: const Text('Beli Velg / Tambah Keranjang',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  widget.onAddToCart();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Velg berhasil ditambahkan ke keranjang!'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Color(0xFF6C5B7B),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
