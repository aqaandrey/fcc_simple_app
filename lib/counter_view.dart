import 'footer_view.dart';
import 'side_menu_view.dart';
import 'header_view_with_menu.dart';
import 'package:flutter/material.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  bool isMenuOpen = false;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decreaseCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String currentPage = 'Counter';

    return Stack(
      children: [
        Scaffold(
      appBar: HeaderView(
        title: currentPage,
        isMenuOpen: isMenuOpen,
        onMenuTap: () => setState(() => isMenuOpen = !isMenuOpen),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Your score:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 30),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                minimumSize: const Size(100, 25),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              ),
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/menu/', (route) => false);
              },
              child: const Text('Menu'),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: _decreaseCounter,
              heroTag: 'minus',
              child: const Icon(Icons.remove),
            ),
            FloatingActionButton(
              onPressed: _resetCounter,
              heroTag: 'reset',
              child: const Icon(Icons.restart_alt_rounded),
            ),
            FloatingActionButton(
              onPressed: _incrementCounter,
              heroTag: 'plus',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FooterView(),
    ),
    // background shadow
    if (isMenuOpen)
    GestureDetector(
    onTap: () => setState(() => isMenuOpen = false),
    child: AnimatedOpacity(
    opacity: 1,
    duration: const Duration(milliseconds: 200),
    child: Container(color: Colors.black54),
    ),
    ),

    // menu on right
    AnimatedPositioned(
    duration: const Duration(milliseconds: 250),
    right: isMenuOpen ? 0 : -MediaQuery.of(context).size.width * 0.6,
    top: 0,
    bottom: 0,
    child: SideMenu(
    currentPage: currentPage,
    onClose: () => setState(() => isMenuOpen = false),
    ),
    ),
    ],
    );
  }
}
