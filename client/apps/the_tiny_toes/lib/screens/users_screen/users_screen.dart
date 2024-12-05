import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:the_tiny_toes/providers/data_provider.dart';
import 'package:the_tiny_toes/providers/user_provider.dart';
import 'package:the_tiny_toes/services/backend_service.dart';

import '../album_screen/album_screen.dart';

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
                          ? AlbumScreen(size: size)
                          : dataProvider.currentPage == 'gallery'
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 25),
                                      Text(
                                        dataProvider.selectedAlbum!.title,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey.shade900),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      FutureBuilder(
                                          future: dataProvider
                                                  .selectedAlbumPhotos.isEmpty
                                              ? BackendService().getPhotos(
                                                  dataProvider
                                                      .selectedAlbum!.albumID
                                                      .toString(),
                                                  context)
                                              : null,
                                          builder: (context, snapshot) {
                                            return GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: dataProvider
                                                  .selectedAlbumPhotos.length,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 8,
                                                childAspectRatio: 0.7,
                                                mainAxisSpacing: 8,
                                              ),
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    Container(
                                                      height: (size.width- 76)/3,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                            dataProvider
                                                                .selectedAlbumPhotos[
                                                                    index]
                                                                .thumbnailUrl,
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      dataProvider
                                                                .selectedAlbumPhotos[
                                                                    index].title,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,overflow: TextOverflow.ellipsis
                                                      ),
maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          })
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
                    } else if (dataProvider.currentPage == 'gallery') {
                      dataProvider.setCurrentPage('album');
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
                        : dataProvider.currentPage == 'gallery'
                            ? 'Gallery'
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
