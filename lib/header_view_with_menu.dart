import 'package:flutter/material.dart';

class HeaderView extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isMenuOpen;
  final VoidCallback onMenuTap;

  const HeaderView({
    super.key,
    required this.title,
    required this.onMenuTap,
    this.isMenuOpen = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(isMenuOpen ? Icons.close : Icons.menu),
          onPressed: onMenuTap,
        ),
      ],
    );
  }
}
