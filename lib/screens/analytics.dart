import 'package:flutter/material.dart';

class Analytics extends StatelessWidget {
  const Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A3365),
        elevation: 0,
        title: const Text(
          'التحليلات والبيانات / Analytics',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            _buildPeriodSelector(),
            const SizedBox(height: 24),

            // Revenue Chart Card
            _buildChartCard(
              titleAr: "نمو المبيعات",
              titleEn: "Sales Growth",
              child: _buildPlaceholderChart(),
            ),
            const SizedBox(height: 20),

            // Distribution Row
            Row(
              children: [
                Expanded(
                  child: _buildSmallStatCard(
                    "Top Product",
                    "زعفران ملكي",
                    Icons.star_outline,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSmallStatCard(
                    "Conversion",
                    "84%",
                    Icons.trending_up,
                    Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Top Selling Products
            _buildSectionHeader("الأكثر مبيعاً / Top Selling"),
            const SizedBox(height: 12),
            _buildTopProductItem("بخور الأصالة", "850 unit", "45%"),
            _buildTopProductItem("دهن عود سيوفي", "420 unit", "22%"),
            _buildTopProductItem("زعفران ملكي", "310 unit", "18%"),
            const SizedBox(height: 24),

            // Customer Loyalty
            _buildChartCard(
              titleAr: "توزيع العملاء",
              titleEn: "Customer Distribution",
              child: _buildPlaceholderPieChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildPeriodBtn("Daily", false),
          _buildPeriodBtn("Weekly", true),
          _buildPeriodBtn("Monthly", false),
          _buildPeriodBtn("Yearly", false),
        ],
      ),
    );
  }

  Widget _buildPeriodBtn(String label, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected ? [BoxShadow(color: Colors.black12, blurRadius: 4)] : [],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF1A3365) : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChartCard({required String titleAr, required String titleEn, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(titleAr, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A3365))),
          Text(titleEn, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  Widget _buildPlaceholderChart() {
    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildBar(40, Colors.grey[300]!),
          _buildBar(60, Colors.grey[300]!),
          _buildBar(80, const Color(0xFF1A3365)),
          _buildBar(50, Colors.grey[300]!),
          _buildBar(90, const Color(0xFFD4AF37)),
          _buildBar(70, Colors.grey[300]!),
          _buildBar(100, const Color(0xFF1A3365)),
        ],
      ),
    );
  }

  Widget _buildBar(double height, Color color) {
    return Container(
      width: 25,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  Widget _buildPlaceholderPieChart() {
    return SizedBox(
      height: 150,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: CircularProgressIndicator(
                value: 0.7,
                strokeWidth: 20,
                color: const Color(0xFF1A3365),
                backgroundColor: Colors.grey[200],
              ),
            ),
            const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("70%", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A3365))),
                Text("جديد", style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A3365))),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A3365)),
    );
  }

  Widget _buildTopProductItem(String name, String units, String percent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.blue[50], shape: BoxShape.circle),
            child: const Icon(Icons.inventory_2_outlined, color: Color(0xFF1A3365), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(units, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Text(
            percent,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ],
      ),
    );
  }
}
