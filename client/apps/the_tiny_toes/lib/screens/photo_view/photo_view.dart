import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/data_provider.dart';

class PhotoView extends StatelessWidget {
  const PhotoView({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, dataProvider, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              dataProvider.selectedPhoto!.title,
              style: TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w800,
                  fontSize: 17),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: size.width * 0.8,
              height: size.width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                      image: NetworkImage(dataProvider.selectedPhoto!.url))),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Artist: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Text(
                    dataProvider.selectedUser!.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Album: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                    child: Text(
                  dataProvider.selectedAlbum!.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                  maxLines: 1,
                ))
              ],
            ),
          ],
        ),
      );
    });
  }
}
