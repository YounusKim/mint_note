import 'package:flutter/material.dart';
import 'package:mint_note/presentation/pages/drawer/drawer_header.dart';
import 'package:mint_note/presentation/pages/drawer/list_container.dart';

class DrawerPage extends StatefulWidget {
  final int selectedPage;
  final Function(int, String, String) genreSelected;

  const DrawerPage({
    super.key,
    required this.selectedPage,
    required this.genreSelected,
  });

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  late int selectedPage;

  @override
  void initState() {
    super.initState();
    selectedPage = widget.selectedPage; // 초기값 설정
  }

  void onGenreSelected(int page, String genreId, String genreName) {
    setState(() {
      selectedPage = page;
    });
    widget.genreSelected(page, genreId, genreName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const DrawerHeaderWidget(),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              const SizedBox(height: 5),

              ListContainerWidget(
                selectedPage: selectedPage,
                genreSelected: onGenreSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
