import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:the_tiny_toes/providers/data_provider.dart';

import '../../services/backend_service.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, dataProvider, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Text(
                dataProvider.selectedUser!.name.substring(0, 1),
                style: const TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
            Text(
              dataProvider.selectedUser!.name,
              style: TextStyle(color: Colors.grey.shade900, fontSize: 24),
            ),
            const SizedBox(
              height: 30,
            ),
            FutureBuilder(
              future: dataProvider.currentUserAlbums.isEmpty
                  ? BackendService().getAlbums(
                      dataProvider.selectedUser!.id.toString(), context)
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
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dataProvider.currentUserAlbums.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              dataProvider.setCurrentPage('gallery');
                              dataProvider.setSelectedAlbum(index);
                            },
                            child: SizedBox(
                              width: size.width - 56,
                              height: 70,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      width: size.width - 70,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade500,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 60),
                                          child: Text(
                                            dataProvider
                                                .currentUserAlbums[index].title,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: CircleAvatar(
                                          radius: 35,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor:
                                                Colors.grey.shade500,
                                            child: Text(
                                              dataProvider
                                                  .currentUserAlbums[index]
                                                  .title
                                                  .substring(0, 1)
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ))),
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }
}
