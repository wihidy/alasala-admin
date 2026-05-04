import 'package:ai_customer_service_stock_management_system/screens/notifications.dart';
import 'package:ai_customer_service_stock_management_system/screens/profile.dart';
import 'package:ai_customer_service_stock_management_system/supabase_helper.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SupabaseHelper _supabaseHelper = SupabaseHelper();
  bool _isLoading = true;
  Map<String, dynamic>? _todayReport;
  List<Map<String, dynamic>> _recentOrders = [];

  @override
  void initState() {
    super.initState();
    _fetchHomeData();
  }

  Future<void> _fetchHomeData() async {
    try {
      final reports = await _supabaseHelper.getDailyReports();
      final orders = await _supabaseHelper.getOrders();

      setState(() {
        if (reports.isNotEmpty) {
          _todayReport = reports.first;
        }
        _recentOrders = orders.take(3).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint('Error fetching home data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF1A3365)),
        ),
      );
    }

    final confirmedOrders = _todayReport?['orders_confirmed'] ?? 0;
    final pendingOrders = _todayReport?['orders_pending'] ?? 0;
    final cancelledOrders = _todayReport?['orders_cancelled'] ?? 0;
    final totalOrders = confirmedOrders + pendingOrders;

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
              "الأصالة",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "ALASALA",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 10,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              const Text(
                "مرحباً، فارس",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                "2024 مارس 24 | الثلاثاء",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),

              // Stats Cards
              Row(
                children: [
                  _buildStatCard(
                    "إجمالي الطلبات",
                    "$totalOrders",
                    "",
                    const Color(0xFF1A3365),
                    Icons.shopping_basket,
                  ),
                  const SizedBox(width: 12),
                  _buildStatCard(
                    "طلبات مؤكدة",
                    "$confirmedOrders",
                    "",
                    Colors.green,
                    Icons.check_circle,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildStatCard(
                    "طلبات معلقة",
                    "$pendingOrders",
                    "",
                    Colors.orange,
                    Icons.pending_actions,
                  ),
                  const SizedBox(width: 12),
                  _buildStatCard(
                    "طلبات ملغاة",
                    "$cancelledOrders",
                    "",
                    Colors.red,
                    Icons.cancel,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Quick Actions Section
              const Text(
                "إجراءات سريعة / Quick Actions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildQuickActionItem(
                      context,
                      "المخزن",
                      Icons.store_outlined,
                      const Color(0xFF1A3365),
                      () {},
                    ),
                    _buildQuickActionItem(
                      context,
                      "الكوبونات",
                      Icons.confirmation_number_outlined,
                      const Color(0xFFD4AF37),
                      () {},
                    ),
                    _buildQuickActionItem(
                      context,
                      "التقارير",
                      Icons.bar_chart_outlined,
                      Colors.purple,
                      () {},
                    ),
                    _buildQuickActionItem(
                      context,
                      "الموظفين",
                      Icons.badge_outlined,
                      Colors.teal,
                      () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Weekly Chart
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "تحليل الانتاجات الأسبوعي",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "آخر 7 أيام ▼",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 180,
                      child: CustomPaint(
                        painter: LineChartPainter(),
                        child: Center(),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("جمعة", style: TextStyle(fontSize: 12)),
                        Text("خميس", style: TextStyle(fontSize: 12)),
                        Text("أربعاء", style: TextStyle(fontSize: 12)),
                        Text("ثلاثاء", style: TextStyle(fontSize: 12)),
                        Text("اثنين", style: TextStyle(fontSize: 12)),
                        Text("أحد", style: TextStyle(fontSize: 12)),
                        Text("سبت", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Recent Orders Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to orders screen
                    },
                    child: const Text(
                      "عرض الكل",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Text(
                    "آخر الطلبات",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              if (_recentOrders.isEmpty)
                const Center(child: Text("لا توجد طلبات مؤخراً"))
              else
                ..._recentOrders.map(
                  (order) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildRecentOrder(
                      order['customer_name'] ?? 'بدون اسم',
                      order['custom_id'] ?? 'ORD-${order['id']}',
                      '${order['total_amount']} ج',
                      order['status'] ?? 'PENDING',
                      _getStatusColor(order['status']),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'CONFIRMED':
      case 'COMPLETED':
        return Colors.green;
      case 'PENDING':
        return Colors.orange;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildQuickActionItem(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String change,
    Color color,
    IconData icon,
  ) {
    return Expanded(
      child: Container(
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
              children: [
                Icon(icon, color: color),

                if (change.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      change,
                      style: TextStyle(color: color, fontSize: 12),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOrder(
    String name,
    String orderId,
    String amount,
    String status,
    Color statusColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(
                orderId,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF1E3A8A)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(
        size.width * 0.3,
        size.height * 0.2,
        size.width * 0.5,

        size.height * 0.65,
      )
      ..quadraticBezierTo(
        size.width * 0.7,
        size.height * 0.9,
        size.width,
        size.height * 0.4,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
