import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mint_note/config/theme/app_theme.dart';
import 'package:mint_note/config/routes/nav_provider.dart';

class ListContainerWidget extends StatefulWidget {
  final int selectedPage;
  final Function(int, String, String) genreSelected;

  const ListContainerWidget({
    super.key,
    required this.selectedPage,
    required this.genreSelected,
  });

  @override
  State<ListContainerWidget> createState() => _ListContainerWidgetState();
}

class _ListContainerWidgetState extends State<ListContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Theme(
        data: Theme.of(
          context,
        ).copyWith(dividerColor: AppTheme.lightTheme.colorScheme.secondary),
        child: Column(
          children: [
            _buildCategoryTile(0, 'Fantasy', '판타지', context),
            Divider(
              thickness: 2,
              color: AppTheme.lightTheme.colorScheme.secondary,
            ),
            const SizedBox(height: 3),
            _buildCategoryTile(1, 'Wuxia', '무협', context),
            const SizedBox(height: 3),
            _buildCategoryTile(2, 'Lightnovel', '라이트노벨', context),
            const SizedBox(height: 3),
            Divider(
              thickness: 2,
              color: AppTheme.lightTheme.colorScheme.secondary,
            ),
            _buildCategoryTile(3, 'Romance', '로맨스', context),
            const SizedBox(height: 3),
            _buildCategoryTile(4, 'Rofan', '로맨스 판타지', context),
            const SizedBox(height: 3),
            Divider(
              thickness: 2,
              color: AppTheme.lightTheme.colorScheme.secondary,
            ),
            _buildCategoryTile(5, 'Detective', '추리 & 공포', context),
            const SizedBox(height: 3),
            _buildCategoryTile(6, 'SF', '사이언스 픽션', context),
            Divider(
              thickness: 2,
              color: AppTheme.lightTheme.colorScheme.secondary,
            ),
            const SizedBox(height: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTile(
    int page,
    String genreId,
    String genreName,
    BuildContext context,
  ) {
    final selected = widget.selectedPage == page;
    final provider = Provider.of<NavProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: selected
            ? AppTheme.lightTheme.colorScheme.primary
            : Colors.transparent,

        border: Border.all(
          color: selected
              ? AppTheme.lightTheme.colorScheme.secondary.withValues(alpha: 0.4)
              : Colors.transparent,
        ),
      ),
      child: ListTile(
        title: Text(
          genreName,
          style: TextStyle(
            fontFamily: 'NanumBarunGothic',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: selected ? Colors.white : Colors.black,
          ),
        ),
        onTap: () {
          provider.selectGenre(genreId, genreName);
          widget.genreSelected(page, genreId, genreName);
        },
      ),
    );
  }
}
