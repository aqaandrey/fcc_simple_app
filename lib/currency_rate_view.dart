import 'footer_view.dart';
import 'side_menu_view.dart';
import 'header_view_with_menu.dart';
import 'package:flutter/material.dart';

class CurrencyRateView extends StatefulWidget {
  const CurrencyRateView({super.key});

  @override
  State<CurrencyRateView> createState() => _CurrencyRateViewState();
}

class _CurrencyRateViewState extends State<CurrencyRateView> {
  bool isMenuOpen = false;
  int _selectedYear = 2025;
  String _selectedCurrency = 'USD';
  var usdData = {2023: 87.87, 2024: 100.73, 2025: 78.96};
  var eurData = {2023: 96.25, 2024: 106.07, 2025: 90.56};

  @override
  Widget build(BuildContext context) {
    final String currentPage = 'Currency rate';

    final rate = _selectedCurrency == 'USD'
        ? usdData[_selectedYear]
        : eurData[_selectedYear];

    return Stack(
      children: [
        Scaffold(
          appBar: HeaderView(
            title: currentPage,
            isMenuOpen: isMenuOpen,
            onMenuTap: () => setState(() => isMenuOpen = !isMenuOpen),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SegmentedButton(
                  segments: const <ButtonSegment>[
                    ButtonSegment(value: 2023, label: Text('2023')),
                    ButtonSegment(value: 2024, label: Text('2024')),
                    ButtonSegment(value: 2025, label: Text('2025')),
                  ],
                  selected: {_selectedYear},
                  onSelectionChanged: (newSelection) {
                    setState(() {
                      _selectedYear = newSelection.first;
                    });
                  },
                ),
                const SizedBox(height: 10),
                SegmentedButton(
                  segments: const [
                    ButtonSegment(value: 'USD', label: Text('USD')),
                    ButtonSegment(value: 'EUR', label: Text('EUR')),
                  ],
                  selected: {_selectedCurrency},
                  onSelectionChanged: (newSelection) {
                    setState(() {
                      _selectedCurrency = newSelection.first;
                    });
                  },
                ),
                const SizedBox(height: 50),
                Text('Rate: $rate', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 150),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
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
                    ).pushNamedAndRemoveUntil('/menu/', (route) => false);
                  },
                  child: const Text('Menu'),
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
