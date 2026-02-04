import 'footer_view.dart';
import 'side_menu_view.dart';
import 'header_view_with_menu.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  bool isMenuOpen = false;
  final String _address = '1600 Amphitheatre Parkway, Mountain View, CA';
  final String _email = 'freecodecamp@app.com';
  final int _phoneNumber = 88005553535;

  void _openMap() async {
    final encoded = Uri.encodeComponent(_address);
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$encoded',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _writeEmail() async {
    final Uri url = Uri(
      scheme: 'mailto',
      path: _email,
      queryParameters: {
        'subject': 'FreeCodeCamp App — Support Request',
        'body': [
          'Hello team,',
          '',
          'I have a question regarding your application.',
          '',
          'Details:',
          '- ',
          '',
          'Best regards,',
          'Your user',
        ].join('\n'),
      },
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _callNumber() async {
    final Uri url = Uri(scheme: 'tel', path: _phoneNumber.toString());
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String currentPage = 'Contacts';

    return Stack(
      children: [
        Scaffold(
      appBar: HeaderView(
        title: currentPage,
        isMenuOpen: isMenuOpen,
        onMenuTap: () => setState(() => isMenuOpen = !isMenuOpen),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Our office '),
                    InkWell(
                      onTap: _openMap,
                      child: Text(
                        _address,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    Text('You can write to this email '),
                    InkWell(
                      onTap: _writeEmail,
                      child: Text(
                        _email,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text('Or you can call this number '),
                    InkWell(
                      onTap: _callNumber,
                      child: Text(
                        '$_phoneNumber',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
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
