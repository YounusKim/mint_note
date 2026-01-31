import 'package:flutter/material.dart';
import 'package:mint_note/note.dart';
import 'package:mint_note/notebook.dart';
import 'package:provider/provider.dart';
import 'package:mint_note/config/routes/nav_provider.dart';
import 'package:mint_note/config/theme/app_theme.dart';
import 'package:mint_note/presentation/pages/drawer/drawer.dart';
import 'package:mint_note/presentation/provider/project_list.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int selectedPage = 0;
  String? selectedGenreId;
  String selectedGenreName = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final navigationProvider = Provider.of<NavProvider>(
        context,
        listen: false,
      );
      context.read<ProjectList>().getProjectByGenre(navigationProvider.genreId);
    });
    super.initState();
  }

  void _genreSelected(int page, String genreId, String genreName) {
    setState(() {
      selectedPage = page;
      selectedGenreId = genreId;
      selectedGenreName = genreName;
    });
    context.read<ProjectList>().getProjectByGenre(genreId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.lightTheme.colorScheme.primary,
      padding: EdgeInsets.all(25),
      child: Scaffold(
        backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,

        // appBar: AppBar(
        //   iconTheme: IconThemeData(color: Colors.white),
        //   backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        //   title: Text(
        //     'Mint Note',
        //     style: TextStyle(
        //       fontFamily: 'KumarOne',
        //       fontSize: 16,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        body: Row(
          children: [
            Expanded(
              flex: 1,
              child: DrawerPage(
                selectedPage: selectedPage,
                genreSelected: _genreSelected,
              ),
            ),
            Expanded(flex: 2, child: NotePage()),

            Expanded(flex: 2, child: NotebookWidget()),

            // Expanded(flex: 2, child: MemoPage()),
          ],
        ),
      ),
    );
  }
}
