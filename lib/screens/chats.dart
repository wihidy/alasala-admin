import 'package:ai_customer_service_stock_management_system/screens/chat_details.dart';
import 'package:ai_customer_service_stock_management_system/screens/notifications.dart';
import 'package:ai_customer_service_stock_management_system/screens/profile.dart';
import 'package:flutter/material.dart';

class Chats extends StatelessWidget {
  Chats({super.key});

  final List<ChatItem> chats = [
    ChatItem(
      name: "Ahmed Mohammed",
      message: "I am happy with the service...",
      time: "10:45",
      type: "POSITIVE",
      initial: "A",
    ),

    ChatItem(
      name: "Sarah Salem",
      message: "There is a problem with the order...",
      time: "Yesterday",
      type: "NEGATIVE",
      initial: "S",
    ),
    ChatItem(
      name: "Khaled Ali",
      message: "Can I modify the order information...",
      time: "Yesterday",
      type: "NEUTRAL",
      initial: "K",
    ),
    ChatItem(
      name: "Noura Yasser",
      message: "Thank you for the fast support",
      time: "02/10",
      type: "POSITIVE",
      initial: "N",
    ),
    ChatItem(
      name: "Fahad Jassim",
      message: "I want to inquire about the work...",
      time: "01/10",
      type: "NEGATIVE",
      initial: "F",
    ),
    ChatItem(
      name: "Ahmed Mohammed",
      message: "I am happy with the service...",
      time: "10:45",
      type: "POSITIVE",
      initial: "A",
    ),
    ChatItem(
      name: "Sarah Salem",
      message: "There is a problem with the order...",
      time: "Yesterday",
      type: "NEGATIVE",
      initial: "S",
    ),
    ChatItem(
      name: "Khaled Ali",
      message: "Can I modify the order information...",
      time: "Yesterday",
      type: "NEUTRAL",
      initial: "K",
    ),
    ChatItem(
      name: "Noura Yasser",
      message: "Thank you for the fast support",
      time: "02/10",
      type: "POSITIVE",
      initial: "N",
    ),
    ChatItem(
      name: "Fahad Jassim",
      message: "I want to inquire about the work...",
      time: "01/10",
      type: "NEGATIVE",
      initial: "F",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          "Chats",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.notifications_outlined, color: Colors.white),
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
            child: Icon(Icons.person, color: Colors.white, size: 30),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                _buildTab("Neutral", false),
                SizedBox(width: 8),
                _buildTab("Positive", false),
                SizedBox(width: 8),
                _buildTab("All", true),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatDetails(userName: chat.name),
                        ),
                      );
                    },
                    child: ChatCard(
                      name: chat.name,
                      message: chat.message,
                      time: chat.time,
                      type: chat.type,
                      initial: chat.initial,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isSelected) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ChatItem {
  final String name;
  final String message;
  final String time;
  final String type;
  final String initial;

  ChatItem({
    required this.name,
    required this.message,
    required this.time,
    required this.type,
    required this.initial,
  });
}

class ChatCard extends StatelessWidget {
  final String name, message, time, type, initial;

  const ChatCard({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.type,
    required this.initial,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                initial,
                style: TextStyle(
                  color: _getColor(type),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: _getColor(type),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(String type) {
    switch (type) {
      case "POSITIVE":
        return Colors.green;
      case "NEGATIVE":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
