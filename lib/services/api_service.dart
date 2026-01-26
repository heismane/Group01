import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/news.dart';

class ApiService {
  static const String _url =
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=f93a1bebc120422ba5e0033df8fdfcce';

  Future<List<News>> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(_url)).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'ok') {
          final List articles = data['articles'];
          return articles
              .where((e) => e['title'] != '[Removed]')
              .map((e) => News.fromJson(e))
              .toList();
        } else {
          throw Exception(data['message'] ?? 'API Error');
        }
      } else {
        throw Exception('Server Error: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Connection timed out');
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }
}