import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/chat_message.dart';
import 'auth_service.dart';

class ChatbotService {
  static Future<String?> startConversation() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) return null;

      final response = await http.post(
        Uri.parse(ApiConfig.CHATBOT_START),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['conversationId'];
      }
    } catch (e) {
      print('🔴 Start conversation error: $e');
    }
    return null;
  }

  static Future<String?> sendMessage({
    required String conversationId,
    required String message,
  }) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) return null;

      final response = await http.post(
        Uri.parse(ApiConfig.CHATBOT_MESSAGE),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
        body: jsonEncode({
          'conversationId': conversationId,
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'];
      }
    } catch (e) {
      print('🔴 Send message error: $e');
    }
    return null;
  }

  static Future<List<ChatMessage>> getConversationHistory(String conversationId) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) return [];

      final response = await http.get(
        Uri.parse('${ApiConfig.CHATBOT}/$conversationId'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> messagesJson = data['messages'] ?? [];
        return messagesJson.map((json) => ChatMessage.fromJson(json)).toList();
      }
    } catch (e) {
      print('🔴 Get conversation history error: $e');
    }
    return [];
  }
}