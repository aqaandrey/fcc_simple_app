import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'footer_view.dart';
import 'side_menu_view.dart';
import 'header_view_with_menu.dart';

final List<String> imgList = [
  'assets/images/Screenshot_20240110-103702_Instagram.jpg',
  'assets/images/Screenshot_20240110-111138_Instagram.jpg',
  'assets/images/Screenshot_20240110-111149_Instagram.jpg',
  'assets/images/Screenshot_20240110-111211_Instagram.jpg',
  'assets/images/Screenshot_20240110-111247_Instagram.jpg',
  'assets/images/Screenshot_20240110-111310_Instagram.jpg',
  'assets/images/Screenshot_20240110-111326_Instagram.jpg',
  'assets/images/Screenshot_20240110-111620_Instagram.jpg',
  'assets/images/Screenshot_20240110-111629_Instagram.jpg',
  'assets/images/Screenshot_20240110-111659_Instagram.jpg',
  'assets/images/Screenshot_20240110-111711_Instagram.jpg',
  'assets/images/Screenshot_20240110-111743_Instagram.jpg',
  'assets/images/Screenshot_20240110-111817_Instagram.jpg',
  'assets/images/Screenshot_20240110-111832_Instagram.jpg',
  'assets/images/Screenshot_20240119-124033_Instagram.jpg',
  'assets/images/Screenshot_20240119-124045_Instagram.jpg',
  'assets/images/Screenshot_20240119-124103_Instagram.jpg',
  'assets/images/Screenshot_20240119-124111_Instagram.jpg',
  'assets/images/Screenshot_20240122-021410_Instagram.jpg',
  'assets/images/Screenshot_20240122-021414_Instagram.jpg',
  'assets/images/Screenshot_20240125-011356_Instagram.jpg',
  'assets/images/Screenshot_20240125-011411_Instagram.jpg',
  'assets/images/Screenshot_20240125-011424_Instagram.jpg',
  'assets/images/Screenshot_20240125-011433_Instagram.jpg',
  'assets/images/Screenshot_20240125-011756_Instagram.jpg',
  'assets/images/Screenshot_20240126-101718_Instagram.jpg',
  'assets/images/Screenshot_20240126-101732_Instagram.jpg',
  'assets/images/Screenshot_20240129-012030_Instagram.jpg',
  'assets/images/Screenshot_20240131-001858_Instagram.jpg',
  'assets/images/Screenshot_20240201-001640_Instagram.jpg',
  'assets/images/Screenshot_20240202-003539_Instagram.jpg',
  'assets/images/Screenshot_20240202-003556_Instagram.jpg',
  'assets/images/Screenshot_20240213-101102_Instagram.jpg',
  'assets/images/Screenshot_20240220-010628_Instagram.jpg',
  'assets/images/Screenshot_20240220-010641_Instagram.jpg',
  'assets/images/Screenshot_20240220-010648_Instagram.jpg',
  'assets/images/Screenshot_20240221-012508_Instagram.jpg',
  'assets/images/Screenshot_20240221-012515_Instagram.jpg',
  'assets/images/Screenshot_20240221-012525_Instagram.jpg',
  'assets/images/Screenshot_20240221-012539_Instagram.jpg',
  'assets/images/Screenshot_20240222-103049_Instagram.jpg',
  'assets/images/Screenshot_20240222-103058_Instagram.jpg',
  'assets/images/Screenshot_20240223-013948_Instagram.jpg',
  'assets/images/Screenshot_20240224-000315_Instagram.jpg',
  'assets/images/Screenshot_20240226-094622_Instagram.jpg',
  'assets/images/Screenshot_20240226-094629_Instagram.jpg',
  'assets/images/Screenshot_20240226-094636_Instagram.jpg',
  'assets/images/Screenshot_20240226-094650_Instagram.jpg',
  'assets/images/Screenshot_20240227-092722_Instagram.jpg',
  'assets/images/Screenshot_20240227-092728_Instagram.jpg',
  'assets/images/Screenshot_20240228-092534_Instagram.jpg',
  'assets/images/Screenshot_20240229-021604_Instagram.jpg',
  'assets/images/Screenshot_20240302-113304_Instagram.jpg',
  'assets/images/Screenshot_20240307-014348_Instagram.jpg',
  'assets/images/Screenshot_20240307-014355_Instagram.jpg',
  'assets/images/Screenshot_20240307-215708_Instagram.jpg',
  'assets/images/Screenshot_20240313-022522_Instagram.jpg',
  'assets/images/Screenshot_20240318-100418_Instagram.jpg',
  'assets/images/Screenshot_20240318-100550_Instagram.jpg',
  'assets/images/Screenshot_20240319-100518_Instagram.jpg',
  'assets/images/Screenshot_20240401-092623_Instagram.jpg',
  'assets/images/Screenshot_20240401-092635_Instagram.jpg',
  'assets/images/Screenshot_20240401-092641_Instagram.jpg',
  'assets/images/Screenshot_20240411-021043_Instagram.jpg',
  'assets/images/Screenshot_20240411-021049_Instagram.jpg',
  'assets/images/Screenshot_20240424-200851_Instagram.jpg',
  'assets/images/Screenshot_20240507-090459_Instagram.jpg'
];

class CarouselView extends StatefulWidget {
  const CarouselView({super.key});

  @override
  State<CarouselView> createState() => _CarouselViewState();
}

class _CarouselViewState extends State<CarouselView> {
  bool isMenuOpen = false;
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  List<Widget> buildImageSliders(BuildContext context) {
    return imgList.map((item) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,

        onTapUp: (details) {
          final dx = details.globalPosition.dx; // tap position on screen
          final screenWidth = MediaQuery.of(context).size.width;

          // 1/3 of the right side is next slide
          if (dx < screenWidth / 3) {
            _controller.previousPage();
            // 1/3 of the left side is next slide
          } else if (dx > 2 * screenWidth / 3) {
            _controller.nextPage();
          }
        },

        child: Container(
          // vertical layer width between renders
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: double.infinity,
          child: ClipRRect(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(item, fit: BoxFit.cover),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final String currentPage = 'Carousel';
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color(0xFF242424),
          appBar: HeaderView(
            title: currentPage,
            isMenuOpen: isMenuOpen,
            onMenuTap: () => setState(() => isMenuOpen = !isMenuOpen),
          ),
          body: Builder(
            builder: (context) {
              final double height = MediaQuery.of(context).size.height;
              return Stack(
                children: [
                  // carousel
                  CarouselSlider(
                    items: buildImageSliders(context),
                    carouselController: _controller,
                    options: CarouselOptions(
                      height: height,
                      viewportFraction: 1.1, // for full width render
                      autoPlay: false,
                      onPageChanged: (index, reason) {
                        setState(() => _currentIndex = index);
                      },
                    ),
                  ),

                  // image counter
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${(_currentIndex + 1).toString().padLeft(2, '0')}/${imgList.length.toString().padLeft(2, '0')}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  // menu button
                  Positioned(
                    bottom: 10,
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
              );
            },
          ),
          bottomNavigationBar: FooterView(),
        ),

        // menu background shadow
        if (isMenuOpen)
          GestureDetector(
            onTap: () => setState(() => isMenuOpen = false),
            child: Container(color: Colors.black54),
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

/*
class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carousel with indicator controller demo')),
      body: Column(children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}

*/
