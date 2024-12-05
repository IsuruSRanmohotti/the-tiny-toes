import 'package:flutter/material.dart';
import 'package:the_tiny_toes/models/user_model.dart';

class DataProvider extends ChangeNotifier {
  List<UserModel> _users = [];
  List<UserModel> get users => _users;
  UserModel? _selectedUser;
  UserModel? get selectedUser => _selectedUser;
  String _currentPage = 'users';
  String get currentPage => _currentPage;

  void setUsers(List<UserModel> usersList) {
    _users = usersList;
    notifyListeners();
  }

  void setSelectedUser(int index) {
    _selectedUser = _users[index];
    setCurrentPage('album');
  }

  void setCurrentPage(String page) {
    _currentPage = page;
    notifyListeners();
  }
}
