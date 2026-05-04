import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  final supabase = Supabase.instance.client;

  // --- Products & Stock ---
  Future<List<Map<String, dynamic>>> getProducts() async {
    return await supabase
        .from('products')
        .select()
        .order('name', ascending: true);
  }

  Future<void> updateStock(int productId, int newQuantity) async {
    await supabase
        .from('products')
        .update({'stock_quantity': newQuantity})
        .eq('id', productId);
  }

  // --- Orders ---
  Future<List<Map<String, dynamic>>> getOrders() async {
    return await supabase
        .from('orders')
        .select('*, order_items(*)')
        .order('created_at', ascending: false);
  }

  Future<void> updateOrderStatus(int orderId, String status) async {
    await supabase.from('orders').update({'status': status}).eq('id', orderId);
  }

  // --- Customers ---
  Future<List<Map<String, dynamic>>> getCustomers() async {
    return await supabase
        .from('customers')
        .select()
        .order('created_at', ascending: false);
  }

  Future<Map<String, dynamic>> getCustomerDetails(String customerId) async {
    return await supabase
        .from('customers')
        .select()
        .eq('id', customerId)
        .single();
  }

  // --- Reports & Analytics ---
  Future<List<Map<String, dynamic>>> getDailyReports() async {
    return await supabase
        .from('daily_reports')
        .select()
        .order('report_date', ascending: false)
        .limit(7);
  }

  // --- Notifications ---
  Future<List<Map<String, dynamic>>> getNotifications() async {
    return await supabase
        .from('notifications')
        .select()
        .order('created_at', ascending: false);
  }

  Future<void> markNotificationAsRead(int id) async {
    await supabase.from('notifications').update({'is_read': true}).eq('id', id);
  }

  // --- Authentication ---
  Future<AuthResponse> signIn(String email, String password) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
