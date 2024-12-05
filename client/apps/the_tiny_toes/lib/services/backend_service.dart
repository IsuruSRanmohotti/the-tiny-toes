import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:the_tiny_toes/models/user_model.dart';
import 'package:the_tiny_toes/providers/data_provider.dart';

class BackendService {
  final String usersEndpoint = 'https://jsonplaceholder.typicode.com/users';

  Future<List<UserModel>> getUsers(BuildContext context) async {
    try {
      final response = await http.get(Uri.parse(usersEndpoint));
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
}
