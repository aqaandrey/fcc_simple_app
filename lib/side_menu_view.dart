import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final String currentPage;
  final VoidCallback onClose;

  const SideMenu({super.key, required this.currentPage, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final pages = [
      {'title': 'Profile', 'route': '/profile/'},
      {'title': 'Contacts', 'route': '/contacts/'},
      {'title': 'Help', 'route': '/help/'},
      {'title': 'Counter', 'route': '/counter/'},
      {'title': 'Carousel', 'route': '/carousel/'},
      {'title': 'Currency rate', 'route': '/currencyRate/'},
    ];

    final width = MediaQuery.of(context).size.width * 0.6;

    return Material(
      elevation: 10,
      child: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          width: width,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose,
                ),
              ),

              // pages list
              ...pages.map((page) {
                final bool isCurrent = page['title'] == currentPage;

                return ListTile(
                  title: Text(
                    page['title']!,
                    style: TextStyle(
                      color: isCurrent
                          ? Theme.of(context).colorScheme.primary
                          : null,
                      fontWeight: isCurrent
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  enabled: !isCurrent,
                  onTap: isCurrent
                      ? null
                      : () {
                          onClose();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            page['route']!,
                            (route) => false,
                          );
                        },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
