import 'package:flutter/material.dart';

class ChatDetails extends StatelessWidget {
  final String userName;
  const ChatDetails({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A3365),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              userName,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "سلبي جداً",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ],
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // User Info Card
                _buildUserInfoCard(),
                const SizedBox(height: 20),

                _buildTimestamp("اليوم 10:45 صباحاً"),

                // Customer Message
                _buildChatBubble(
                  message: "السلام عليكم، طلبي رقم 5543 لم يصل حتى الآن رغم مرور 3 أيام على الموعد المحدد. هذه المرة الثانية التي تتأخرون فيها!",
                  isMe: false,
                ),

                // AI Response
                _buildChatBubble(
                  message: "وعليكم السلام أستاذ أحمد. نعتذر جداً عن هذا التأخير غير المقصود. قمت بمراجعة النظام حالياً، وتبين أن الشحنة في مرحلة التوزيع النهائي. سأقوم بمنحك كوبون خصم 20% لطلبك القادم كتعويض. هل تود أن أتابع لك مع شركة الشحن مباشرة؟",
                  isMe: true,
                  isAI: true,
                ),

                _buildTimestamp("منذ دقيقة"),

                // Customer Message
                _buildChatBubble(
                  message: "لا أريد كوبونات، أريد طلبي الآن. خدمة العملاء لديكم أصبحت سيئة جداً ولن أتعامل معكم مرة أخرى.",
                  isMe: false,
                ),

                const SizedBox(height: 20),

                // Sentiment Analysis Card
                _buildSentimentCard(),
              ],
            ),
          ),

          // Bottom Action Buttons
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildUserInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildSentimentDots(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                userName,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A3365)),
              ),
              const Text(
                "منذ دقيقتين  •  AM-9042# @",
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSentimentDots() {
    return Row(
      children: [
        _dot(Colors.red),
        _dot(Colors.red),
        _dot(Colors.orange),
        _dot(Colors.green),
        _dot(Colors.green),
      ],
    );
  }

  Widget _dot(Color color) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildTimestamp(String text) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
        ),
      ),
    );
  }

  Widget _buildChatBubble({required String message, required bool isMe, bool isAI = false}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF1A3365) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 14,
                height: 1.5,
              ),
              textAlign: TextAlign.right,
            ),
            if (isAI) ...[
              const SizedBox(height: 8),
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.settings, color: Colors.white70, size: 12),
                  SizedBox(width: 4),
                  Text("رد تلقائي", style: TextStyle(color: Colors.white70, fontSize: 10)),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSentimentCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade100),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade100),
                  ),
                  child: const Text("88% دقة التحليل", style: TextStyle(color: Colors.red, fontSize: 10)),
                ),
                const Row(
                  children: [
                    Text("تحليل المشاعر التلقائي", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A3365))),
                    SizedBox(width: 8),
                    Icon(Icons.analytics_outlined, color: Colors.red, size: 18),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  textAlign: TextAlign.right,
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                    children: [
                      TextSpan(text: "النتيجة: "),
                      TextSpan(
                        text: "سلبي (غاضب) / Result: Negative (Angry)",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "العميل يظهر علامات فقدان الثقة التام في الخدمة بسبب تكرار المشكلات.",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 16),
                const Text("العبارات المفتاحية:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.end,
                  children: [
                    _buildTag("تكرار مشكلة التأخير"),
                    _buildTag("رفض الكوبونات"),
                    _buildTag("تهديد بالتوقف عن التعامل"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.red.shade900, fontSize: 10),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2))],
      ),
      child: Column(
        children: [
          _buildActionButton(
            text: "تواصل عبر تليجرام / Contact on Telegram",
            icon: Icons.send,
            color: const Color(0xFF1A3365),
            textColor: Colors.white,
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            text: "تصعيد لموظف بشري / Escalate to Human",
            icon: Icons.support_agent,
            color: Colors.red.shade50,
            textColor: Colors.red.shade900,
            borderColor: Colors.red.shade100,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required IconData icon,
    required Color color,
    required Color textColor,
    Color? borderColor,
  }) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(width: 8),
          Icon(icon, color: textColor, size: 20),
        ],
      ),
    );
  }
}
