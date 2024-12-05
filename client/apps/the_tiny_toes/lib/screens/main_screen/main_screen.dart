import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tiny_toes/providers/data_provider.dart';

import '../album_screen/album_screen.dart';
import '../gallery_screen/gallery_page.dart';
import '../photo_view/photo_view.dart';
import '../users_screen/users_screen.dart';
import 'widgets/custom_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
                      ? const UsersScreen()
                      : dataProvider.currentPage == 'album'
                          ? AlbumScreen(size: size)
                          : dataProvider.currentPage == 'gallery'
                              ? GalleryPage(size: size)
                              : dataProvider.currentPage == 'photoView'
                                  ? PhotoView(size: size)
                                  : const SizedBox()
                ],
              ),
            ),
          ));
    });
  }
}

