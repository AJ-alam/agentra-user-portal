import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/booking.dart';
import 'auth_service.dart';

class BookingService {
  static Future<List<Booking>> getMyBookings() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) return [];

      print('🔵 Fetching my bookings');

      final response = await http.get(
        Uri.parse(ApiConfig.MY_BOOKINGS),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
      );

      print('🟢 Bookings Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> bookingsJson = data['bookings'] ?? data['data'] ?? [];
        return bookingsJson.map((json) => Booking.fromJson(json)).toList();
      }
    } catch (e) {
      print('🔴 Get bookings error: $e');
    }
    return [];
  }

  static Future<bool> createBooking({
    required String packageId,
    required int seats,
    required String travelDate,
    required String paymentMethod,
  }) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) return false;

      print('🔵 Creating booking for package: $packageId');

      final response = await http.post(
        Uri.parse(ApiConfig.BOOKINGS),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
        body: jsonEncode({
          'packageId': packageId,
          'seats': seats,
          'travelDate': travelDate,
          'paymentMethod': paymentMethod,
        }),
      );

      print('🟢 Create Booking Status: ${response.statusCode}');

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('🔴 Create booking error: $e');
      return false;
    }
  }

  static Future<bool> cancelBooking(String bookingId) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) return false;

      final response = await http.put(
        Uri.parse('${ApiConfig.BOOKINGS}/$bookingId/cancel'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      print('🔴 Cancel booking error: $e');
      return false;
    }
  }
}
