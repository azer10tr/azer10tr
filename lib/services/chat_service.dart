import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/message_model.dart';

class ChatService extends ChangeNotifier{
  final SupabaseClient _supabase = Supabase.instance.client;

  Stream<List<Message>> getMessagesStream(String otherUserId) {
  final currentUserId = _supabase.auth.currentUser?.id;
  if (currentUserId == null) return const Stream.empty();

  return _supabase
      .from('messages')
      .stream(primaryKey: ['id'])
      .order('timestamp', ascending: true)
      .map((data) {
        return data
            .where((msg) =>
                (msg['sender_id'] == currentUserId &&
                msg['receiver_id'] == otherUserId) ||
                (msg['sender_id'] == otherUserId &&
                msg['receiver_id'] == currentUserId))
            .map((msg) => Message.fromMap(msg))
            .toList();
      });
}




  Future<void> sendMessage(String content, String receiverId) async {
    final currentUserId = _supabase.auth.currentUser?.id;
    if (currentUserId == null) throw Exception('Non authentifié');

  // Vérifie que l'expéditeur et le destinataire ne sont pas identiques
    if (currentUserId == receiverId) {
      throw Exception('L\'expéditeur et le destinataire ne peuvent pas être les mêmes.');
  }

    await _supabase.from('messages').insert({
      'sender_id': currentUserId,
      'receiver_id': receiverId,
      'content': content,
    });
  }

  Future<void> markAsRead(String messageId) async {
    await _supabase
        .from('messages')
        .update({'is_read': true})
        .eq('id', messageId);
  }





  
  // chat_service.dart
  Future<String> getAdminId() async {
  try {
    // Utilise select().single() avec gestion d'erreur
    final data = await _supabase
        .from('Employees')
        .select('id')
        .eq('role', 'admin')
        .single();

    return data['id'] as String;
  } on PostgrestException catch (e) {
    if (e.code == 'PGRST116') { // Code d'erreur "No rows found"
      throw Exception('Aucun administrateur trouvé dans la base');
    } else {
      throw Exception('Erreur de base de données : ${e.message}');
    }
  } catch (e) {
    throw Exception('Erreur inattendue : $e');
    
  }
  
}
}