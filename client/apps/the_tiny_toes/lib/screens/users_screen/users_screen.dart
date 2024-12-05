import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../providers/data_provider.dart';
import '../../services/backend_service.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({
    super.key,
  });

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.brown,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pink,
    Colors.black,
    Colors.teal,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Consumer<DataProvider>(
      builder: (context,dataProvider,child) {
        return FutureBuilder(
            future: dataProvider.users.isEmpty
                ? BackendService().getUsers(context)
                : null,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.grey.shade200,
                            child: Container(
                              width: size.width,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20)),
                            )),
                      );
                    },
                  ),
                );
              }
              if (dataProvider.users.isEmpty) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: dataProvider.users.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () {
                          dataProvider.setSelectedUser(index);
                        },
                        child: ListTile(
                          tileColor: Colors.grey.shade200,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          leading: CircleAvatar(
                            backgroundColor:
                                colors[Random().nextInt(colors.length)],
                            child: Text(
                              dataProvider.users[index].name.substring(0, 1),
                              style: const TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(dataProvider.users[index].name),
                          subtitle: Text(dataProvider.users[index].userName),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            });
      }
    );
  }
}
