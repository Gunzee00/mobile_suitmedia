import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_test/model/user_model.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 1;
  final int _perPage = 6;

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchUsers({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _page = 1;
      _users.clear();
      _hasMore = true;
    }

    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(
        'https://reqres.in/api/users?page=$_page&per_page=$_perPage'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> userJson = data['data'];
      if (userJson.isNotEmpty) {
        _users.addAll(userJson.map((json) => User.fromJson(json)).toList());
        _page++;
      } else {
        _hasMore = false;
      }
    } else {
      _hasMore = false;
    }

    _isLoading = false;
    notifyListeners();
  }
}
