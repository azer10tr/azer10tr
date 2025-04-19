import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/message_model.dart';

class ChatService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Stream<List<Message>> getMessagesStream(String receiverId) {
    return _supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('timestamp', ascending: false)
        .map((data) => data.map((msg) => Message.fromMap(msg)).toList());
  }

  Future<void> sendMessage(String content, String receiverId) async {
    final currentUserId = _supabase.auth.currentUser?.id;
    if (currentUserId == null) throw Exception('Non authentifié');

    await _supabase.from('messages').insert({
      'sender_id': currentUserId,
      'receiver_id': receiverId,
      'content': content,
    });
  }

  Future<void> markAsRead(String messageId) async {
    await _supabase
        .from('messages')
        .update({'is_read': true}).eq('id', messageId);
  }

  // chat_service.dart
  Future<String> getAdminId() async {
    try {
      // Utilise select().single() avec gestion d'erreur
      final data = await _supabase
          .from('Employees')
          .select('id')
          .eq('is_admin', true)
          .single();

      return data['id'] as String;
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        // Code d'erreur "No rows found"
        throw Exception('Aucun administrateur trouvé dans la base');
      } else {
        throw Exception('Erreur de base de données : ${e.message}');
      }
    } catch (e) {
      throw Exception('Erreur inattendue : $e');
    }
  }
}
