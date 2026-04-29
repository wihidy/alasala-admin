import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notificationItems = [
      {
        "title": "عميل يحتاج مساعدة",
        "subtitle": "هناك محادثة جديدة تتطلب انتباهك",
        "time": "منذ دقيقتين",
        "icon": Icons.chat_bubble_outline,
        "color": Colors.blue,
        "targetIndex": 3, // Chats screen
      },
      {
        "title": "طلب جديد",
        "subtitle": "تم استلام طلب جديد رقم #ORD-94028",
        "time": "منذ 15 دقيقة",
        "icon": Icons.shopping_bag_outlined,
        "color": Colors.green,
        "targetIndex": 1, // Orders screen
      },
      {
        "title": "تنبيه المخزون",
        "subtitle": "زعفران ملكي وصل للحد الأدنى",
        "time": "منذ ساعة",
        "icon": Icons.warning_amber_rounded,
        "color": Colors.orange,
        "targetIndex": 2, // Stock screen
      },
      {
        "title": "تقرير يومي جاهز",
        "subtitle": "تم إنشاء التقرير اليومي بنجاح",
        "time": "منذ ساعتين",
        "icon": Icons.bar_chart_outlined,
        "color": Colors.purple,
        "targetIndex": 4, // Reports screen
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A3365),
        elevation: 0,
        title: const Text(
          "التنبيهات",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notificationItems.length,
        itemBuilder: (context, index) {
          final item = notificationItems[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: item['color'].withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(item['icon'], color: item['color']),
              ),
              title: Text(
                item['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item['subtitle']),
              trailing: Text(
                item['time'],
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              onTap: () {
                // Return the target index to the main screen
                Navigator.pop(context, item['targetIndex']);
              },
            ),
          );
        },
      ),
    );
  }
}
