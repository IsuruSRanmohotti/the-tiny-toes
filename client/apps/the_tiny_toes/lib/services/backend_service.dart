import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:the_tiny_toes/models/album_model.dart';
import 'package:the_tiny_toes/models/photo_model.dart';
import 'package:the_tiny_toes/models/user_model.dart';
import 'package:the_tiny_toes/providers/data_provider.dart';

class BackendService {
  Future<List<UserModel>> getUsers(BuildContext context) async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<UserModel> users = (data as List<dynamic>)
            .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
            .toList();
        if (context.mounted) {
          Provider.of<DataProvider>(context, listen: false).setUsers(users);
        }
        return users;
      } else {
        Logger().e(response.statusCode);
        return [];
      }
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  Future<List<AlbumModel>> getAlbums(String id, BuildContext context) async {
    try {
      final response = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/albums?userId=$id'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<AlbumModel> albums = (data as List<dynamic>)
            .map(
              (e) => AlbumModel.fromJSon(e as Map<String, dynamic>),
            )
            .toList();
        if (context.mounted) {
          Provider.of<DataProvider>(context, listen: false)
              .setCurrentUserAlbums(albums);
        }
        return albums;
      } else {
        return [];
      }
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  Future<List<PhotoModel>> getPhotos(
      String albumId, BuildContext context) async {
    try {
      final response = await http.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/photos?albumId=$albumId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<PhotoModel> photos = (data as List<dynamic>)
            .map(
              (e) => PhotoModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
        if (context.mounted) {
          Provider.of<DataProvider>(context, listen: false)
              .setSelectedAlbumPhotos(photos);
        }
        return photos;
      } else {
        return [];
      }
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }
}
