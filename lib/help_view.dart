import 'footer_view.dart';
import 'side_menu_view.dart';
import 'header_view_with_menu.dart';
import 'package:flutter/material.dart';

class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  bool isMenuOpen = false;
  final TextEditingController _controller = TextEditingController();
  final List<String> _keywords = [
    'Profile',
    'Profile/logout',
    'Counter',
    'Counter/plus',
    'Counter/minus',
    'Counter/reset',
    'Carousel',
    'Carousel/images',
    'Carousel/swipe',
    'Currency rate',
    'Currency rate/US Dollar',
    'Currency rate/Euro',
    'Contacts',
    'Contacts/phone',
    'Contacts/address',
    'Contacts/mail',
  ];
  String _result = '';
  bool _searchPressed = false;
  String? _searchError;

  void _onSearch(String query) {
    setState(() {
      _searchPressed = true;

      if (query.isEmpty) {
        return;
      }

      final matchedWord = _keywords.firstWhere(
        (word) => word.toLowerCase().contains(query.toLowerCase()),
        orElse: () => '',
      );

      if (query.isEmpty) {
        return;
      } else if (query.length <= 3) {
        return;
      }

      if (matchedWord.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('We found a matching page: "$matchedWord"')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No results. Try searching something else.'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String currentPage = 'Help';

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
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            labelText: 'Type to search…',
                            hintText: 'Enter your question here',
                            helperText: ' ',
                            errorText: _searchError,
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (_controller.text.isNotEmpty)
                                  IconButton(
                                    icon: const Icon(Icons.clear),
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      setState(() {
                                        _controller.clear();
                                        _result = '';
                                        _searchPressed = false;
                                      });
                                    },
                                  ),

                                IconButton(
                                  icon: const Icon(Icons.search),
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    _onSearch(_controller.text);
                                    color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.inversePrimary;
                                    _searchError = null;

                                    if (_controller.text.isEmpty) {
                                      setState(() {
                                        _searchError =
                                            'Please fill in the search field';
                                      });
                                    } else if (_controller.text.length <= 3) {
                                      setState(() {
                                        _searchError =
                                            'Must contains more then 3 characters';
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          onTap: () => setState(() => _searchError = null),
                          onChanged: (text) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),

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
