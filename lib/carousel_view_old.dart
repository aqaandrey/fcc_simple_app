import 'footer_view.dart';
import 'side_menu_view.dart';
import 'header_view_with_menu.dart';
import 'package:flutter/material.dart';

class CarouselViewOld extends StatefulWidget {
  const CarouselViewOld({super.key});

  @override
  State<CarouselViewOld> createState() => _CarouselViewOldState();
}

class _CarouselViewOldState extends State<CarouselViewOld> {
  bool isMenuOpen = false;
  late final PageController _pageController;
  int _currentIndex = 0;

  final List<String> _images = [
    'assets/images/Screenshot_20240110-103702_Instagram.jpg',
    'assets/images/Screenshot_20240110-111138_Instagram.jpg',
    'assets/images/Screenshot_20240110-111149_Instagram.jpg',
    'assets/images/Screenshot_20240110-111211_Instagram.jpg',
    'assets/images/Screenshot_20240110-111247_Instagram.jpg',
    'assets/images/Screenshot_20240110-111310_Instagram.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _images.length,
      viewportFraction: 1.0, // img on all screen wide
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String currentPage = 'Carousel';
    return Stack(
      children: [
        Scaffold(
          appBar: HeaderView(
            title: currentPage,
            isMenuOpen: isMenuOpen,
            onMenuTap: () => setState(() => isMenuOpen = !isMenuOpen),
          ),
          body: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _currentIndex = page % _images.length;
                  });
                },
                itemBuilder: (context, index) {
                  final realIndex = index % _images.length;
                  return Image.asset(_images[realIndex], fit: BoxFit.cover);
                },
              ),

              // left side
              Positioned.fill(
                left: MediaQuery.of(context).size.width * 2 / 3,
                right: 0,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                    );
                  },
                ),
              ),

              // right side
              Positioned.fill(
                left: 0,
                right: MediaQuery.of(context).size.width * 2 / 3,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                    );
                  },
                ),
              ),

              Positioned(
                bottom: 75,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_images.length, (index) {
                    final bool isActive = index == _currentIndex;

                    return GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                        );
                        setState(() => _currentIndex = index);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 10 : 8,
                        height: isActive ? 10 : 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive
                              ? Theme.of(context).colorScheme.onSecondary
                              : Colors.grey,
                        ),
                      ),
                    );
                  }),
                ),
              ),

              Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: Center(
                  child: TextButton(
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
                      ).pushNamedAndRemoveUntil('/menu/', (route) => false);
                    },
                    child: const Text('Menu'),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: FooterView(),
        ),

        // menu background shadow
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