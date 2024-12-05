import 'package:flutter/material.dart';
import 'package:the_tiny_toes/models/album_model.dart';
import 'package:the_tiny_toes/models/photo_model.dart';
import 'package:the_tiny_toes/models/user_model.dart';

class DataProvider extends ChangeNotifier {
  List<UserModel> _users = [];
  List<UserModel> get users => _users;
  UserModel? _selectedUser;
  UserModel? get selectedUser => _selectedUser;
  List<AlbumModel> _currentUserAlbums = [];
  List<AlbumModel> get currentUserAlbums => _currentUserAlbums;
  AlbumModel? _selectedAlbum;
  AlbumModel? get selectedAlbum => _selectedAlbum;
  List<PhotoModel> _selectedAlbumPhotos = [];
  List<PhotoModel> get selectedAlbumPhotos => _selectedAlbumPhotos;

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
    if (page == 'users') {
      _currentUserAlbums = [];
    } else if (page == 'album') {
      _selectedAlbumPhotos = [];
    }
    notifyListeners();
  }

  void setCurrentUserAlbums(List<AlbumModel> albums) {
    _currentUserAlbums = albums;
    notifyListeners();
  }

  void setSelectedAlbum(int index) {
    _selectedAlbum = _currentUserAlbums[index];
    notifyListeners();
  }

  void setSelectedAlbumPhotos(List<PhotoModel> photos) {
    _selectedAlbumPhotos = photos;
    notifyListeners();
  }
}
