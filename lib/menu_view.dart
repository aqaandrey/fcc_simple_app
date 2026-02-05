import 'header_view.dart';
import 'footer_view.dart';
import 'package:flutter/material.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MainScreen();
}

class _MainScreen extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderView(title: 'Main menu'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // left col
                Column(
                  children: [
                    // profile btn
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onSecondary,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.inversePrimary,
                        minimumSize: const Size(100, 25),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/profile/',
                          (route) => false,
                        );
                      },
                      child: const Text('Profile'),
                    ),
                    const SizedBox(height: 5),
                    // contacts btn
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onSecondary,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.inversePrimary,
                        minimumSize: const Size(100, 25),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/contacts/',
                          (route) => false,
                        );
                      },
                      child: const Text('Contacts'),
                    ),
                    const SizedBox(height: 5),
                    // help btn
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onSecondary,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.inversePrimary,
                        minimumSize: const Size(100, 25),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushNamedAndRemoveUntil('/help/', (route) => false);
                      },
                      child: const Text('Help'),
                    ),
                  ],
                ),
                // right col
                Column(
                  children: [
                    // counter btn
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onSecondary,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.inversePrimary,
                        minimumSize: const Size(100, 25),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/counter/',
                          (route) => false,
                        );
                      },
                      child: const Text('Counter'),
                    ),
                    const SizedBox(height: 5),
                    // carousel btn
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onSecondary,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.inversePrimary,
                        minimumSize: const Size(100, 25),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/carousel/',
                          (route) => false,
                        );
                      },
                      child: const Text('Carousel'),
                    ),
                    const SizedBox(height: 5),
                    // currency btn
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onSecondary,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.inversePrimary,
                        minimumSize: const Size(100, 25),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/currencyRate/',
                          (route) => false,
                        );
                      },
                      child: const Text('Currency rate'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: FooterView(),
    );
  }
}
