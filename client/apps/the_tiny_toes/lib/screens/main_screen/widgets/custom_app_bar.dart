import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/data_provider.dart';
import '../../../providers/user_provider.dart';

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
                    }else if(dataProvider.currentPage == 'photoView'){
                      dataProvider.setCurrentPage('gallery');

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
                            ? 'Gallery': dataProvider.currentPage == 'photoView'
                            ? 'Image Viewer'
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
