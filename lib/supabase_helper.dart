import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  final supabase = Supabase.instance.client;

  // جلب جميع المنتجات من جدول products
  Future<List<Map<String, dynamic>>> getProducts() async {
    final response = await supabase.from('products').select();
    return response;
  }

  // تحديث كمية المخزون
  Future<void> updateStock(int productId, int newQuantity) async {
    await supabase
        .from('products')
        .update({'stock_quantity': newQuantity})
        .eq('id', productId);
  }

  // جلب الطلبات الأخيرة
  Future<List<Map<String, dynamic>>> getOrders() async {
    final response = await supabase
        .from('orders')
        .select('*, order_items(*)')
        .order('created_at', ascending: false);
    return response;
  }

  // تسجيل دخول الأدمن
  Future<AuthResponse> signIn(String email, String password) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }
}
