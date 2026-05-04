import 'package:ai_customer_service_stock_management_system/screens/notifications.dart';
import 'package:ai_customer_service_stock_management_system/screens/profile.dart';
import 'package:ai_customer_service_stock_management_system/screens/stock_manegment.dart';
import 'package:ai_customer_service_stock_management_system/supabase_helper.dart';
import 'package:flutter/material.dart';

class Stock extends StatefulWidget {
  const Stock({super.key});

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  final SupabaseHelper _supabaseHelper = SupabaseHelper();
  bool _isLoading = true;
  List<Map<String, dynamic>> _allProducts = [];
  List<Map<String, dynamic>> _filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await _supabaseHelper.getProducts();
      setState(() {
        _allProducts = products;
        _filteredProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint('Error fetching products: $e');
    }
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = _allProducts
          .where((p) =>
              p['name'].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Color(0xFF1A3365))),
      );
    }

    final outOfStock = _allProducts.where((p) => (p['stock_quantity'] ?? 0) == 0).length;
    final lowStock = _allProducts.where((p) => (p['stock_quantity'] ?? 0) > 0 && (p['stock_quantity'] ?? 0) < 10).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A3365),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Notifications()),
            );
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
            child: const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color(0xFF1A3365)),
            ),
          ),
          const SizedBox(width: 16),
        ],
        centerTitle: true,
        title: Column(
          children: const [
            Text(
              "المخزن",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "STOCK",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 10,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Summary Cards
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem("$outOfStock", "Out of stock", "نفدت الكمية"),
                _buildSummaryItem("$lowStock", "Low", "منخفض"),
                _buildSummaryItem("${_allProducts.length}", "Products", "المنتجات"),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: _filterProducts,
              decoration: InputDecoration(
                hintText: "Search product / البحث عن منتج ...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Filters
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildFilterChip("All", true),
                const SizedBox(width: 10),
                _buildFilterChip("Stock", false),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Products List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                final qty = product['stock_quantity'] ?? 0;
                final status = qty == 0 ? "نفدت" : (qty < 10 ? "منخفض" : "متوفر");
                final color = qty == 0 ? Colors.red : (qty < 10 ? Colors.orange : Colors.green);
                final percent = (qty / 100).clamp(0.0, 1.0) * 100;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StockManagement(
                            productId: product['id'],
                            productName: product['name'] ?? 'بدون اسم',
                            currentStock: product['stock_quantity'] ?? 0,
                          ),
                        ),
                      );
                      if (result == true) {
                        _fetchProducts(); // Refresh the list if update was successful
                      }
                    },
                    child: StockProductCard(
                      name: product['name'] ?? 'بدون اسم',
                      stockStatus: status,
                      quantity: "$qty وحدة",
                      percentage: "${percent.toInt()}%",
                      color: color,
                    ),
                  ),
                );
              },
            ),
          ),

          // Update Stock Button (Optional if needed)
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String number, String titleEn, String titleAr) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 26,

            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(titleEn, style: TextStyle(fontSize: 12, color: Colors.black)),
        Text(titleAr, style: TextStyle(fontSize: 11, color: Colors.black)),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class StockProductCard extends StatelessWidget {
  final String name;
  final String stockStatus;
  final String quantity;
  final String percentage;
  final Color color;

  const StockProductCard({
    super.key,
    required this.name,
    required this.stockStatus,
    required this.quantity,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  stockStatus,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "الحد الأدنى",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    quantity,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "$percentage ممتلئ",
                    style: TextStyle(color: color, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 100,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor:
                          double.parse(percentage.replaceAll('%', '')) / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.remove_circle_outline, color: Colors.grey),
              ),
              SizedBox(width: 20),
              Icon(
                Icons.add_circle_outline,
                color: Color(0xFF1E3A8A),
                size: 32,
              ),
              SizedBox(width: 20),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.remove_circle_outline,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}