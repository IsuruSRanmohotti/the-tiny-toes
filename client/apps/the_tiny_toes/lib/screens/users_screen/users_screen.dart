import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:the_tiny_toes/providers/data_provider.dart';
import 'package:the_tiny_toes/providers/user_provider.dart';
import 'package:the_tiny_toes/services/backend_service.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.brown,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pink,
    Colors.black,
    Colors.grey.shade900,
    Colors.blue,
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Consumer<DataProvider>(builder: (context, dataProvider, child) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomAppBar(),
                  dataProvider.currentPage == 'users'
                      ? FutureBuilder(
                          future: dataProvider.users.isEmpty
                              ? BackendService().getUsers(context)
                              : null,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        leading: CircleAvatar(
                                          backgroundColor: colors[
                                              Random().nextInt(colors.length)],
                                          child: Text(
                                            dataProvider.users[index].name
                                                .substring(0, 1),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        title: Text(
                                            dataProvider.users[index].name),
                                        subtitle: Text(
                                            dataProvider.users[index].userName),
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
                          })
                      : dataProvider.currentPage == 'album'
                          ? SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.blue,
                                    child: Text(
                                      dataProvider.selectedUser!.name
                                          .substring(0, 1),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 50),
                                    ),
                                  ),
                                  Text(
                                    dataProvider.selectedUser!.name,
                                    style: TextStyle(
                                        color: Colors.grey.shade900,
                                        fontSize: 24),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  FutureBuilder(
                                    future:
                                        dataProvider.currentUserAlbums.isEmpty
                                            ? BackendService().getAlbums(
                                                dataProvider.selectedUser!.id
                                                    .toString(),
                                                context)
                                            : null,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: 10,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey.shade400,
                                                    highlightColor:
                                                        Colors.grey.shade200,
                                                    child: Container(
                                                      width: size.width,
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: dataProvider
                                              .currentUserAlbums.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: size.width - 56,
                                                  height: 70,
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Container(
                                                          width:
                                                              size.width - 70,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade500,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 60),
                                                              child: Text(
                                                                dataProvider
                                                                    .currentUserAlbums[
                                                                        index]
                                                                    .title,
                                                                style:
                                                                    const TextStyle(fontSize: 18,
                                                                        color: Colors
                                                                            .white,overflow: TextOverflow.ellipsis),
                                                                            maxLines: 1,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: CircleAvatar(
                                                              radius: 35,
                                                              backgroundColor:
                                                                  Colors.white,
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 30,
                                                                backgroundColor:
                                                                    Colors.grey
                                                                        .shade500,
                                                                child: Text(
                                                                  dataProvider
                                                                      .currentUserAlbums[
                                                                          index]
                                                                      .title
                                                                      .substring(
                                                                          0, 1)
                                                                      .toUpperCase(),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          22,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ))),
                                                    ],
                                                  ),
                                                ));
                                          },
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            )
                          : const SizedBox()
                ],
              ),
            ),
          ));
    });
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer2<UserProvider, DataProvider>(
          builder: (context, userProvider, dataProvider, child) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(50)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilledButton(
                  onPressed: () {
                    if (dataProvider.currentPage == 'users') {
                      userProvider.signOutUser(context);
                    } else if (dataProvider.currentPage == 'album') {
                      dataProvider.setCurrentPage('users');
                    }
                  },
                  child: dataProvider.currentPage == 'users'
                      ? const Text('SignOut')
                      : const Row(
                          children: [
                            Icon(Icons.arrow_back_ios_rounded),
                            Text(' Back')
                          ],
                        )),
              Text(
                dataProvider.currentPage == 'users'
                    ? 'Users'
                    : dataProvider.currentPage == 'album'
                        ? 'Album'
                        : '',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.green,
                                  child: Text(
                                    userProvider.currentUser!.substring(0, 1),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 50),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  userProvider.currentUser!,
                                  style: TextStyle(
                                      color: Colors.grey.shade300,
                                      fontSize: 25),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade700,
                  child: Text(
                    userProvider.currentUser!.substring(0, 1),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
