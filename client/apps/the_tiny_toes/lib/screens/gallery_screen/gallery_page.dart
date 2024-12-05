import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../providers/data_provider.dart';
import '../../services/backend_service.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, dataProvider, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
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
                future: dataProvider.selectedAlbumPhotos.isEmpty
                    ? BackendService().getPhotos(
                        dataProvider.selectedAlbum!.albumID.toString(), context)
                    : null,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10,
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
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade600,
                              highlightColor: Colors.grey,
                              child: Container(
                                height: (size.width - 76) / 3,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade600,
                              highlightColor: Colors.grey,
                              child: Container(
                                width: 200,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dataProvider.selectedAlbumPhotos.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          dataProvider.setCurrentPage('photoView');
                          dataProvider.setSelectedPhoto(index);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: (size.width - 76) / 3,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    dataProvider.selectedAlbumPhotos[index]
                                        .thumbnailUrl,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              dataProvider.selectedAlbumPhotos[index].title,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                })
          ],
        ),
      );
    });
  }
}
