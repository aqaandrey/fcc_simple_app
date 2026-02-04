import 'package:flutter/material.dart';

class FooterView extends StatefulWidget {
  const FooterView({super.key});

  @override
  State<FooterView> createState() => _FooterViewState();
}

class _FooterViewState extends State<FooterView> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: Center(
        child: const Text(
          '© 2025 FreeCodeCampApp',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
