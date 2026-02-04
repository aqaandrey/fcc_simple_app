import 'footer_view.dart';
import 'side_menu_view.dart';
import 'header_view_with_menu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isMenuOpen = false;
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('currentUser');
    setState(() {
      _username = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String currentPage = 'Profile';

    return Stack(
      children: [
        Scaffold(
          appBar: HeaderView(
            title: currentPage,
            isMenuOpen: isMenuOpen,
            onMenuTap: () => setState(() => isMenuOpen = !isMenuOpen),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _username == null
                      ? const Text("You're not logged")
                      : Text('Welcome $_username!'),
                  const SizedBox(height: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        onPressed: () async {
                          final shouldLogout = await logoutModal(context);

                          if (shouldLogout) {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.remove('currentUser');

                            Navigator.of(
                              context,
                            ).pushNamedAndRemoveUntil('/', (route) => false);
                          }
                        },
                        child: const Text('Logout'),
                      ),
                      const SizedBox(height: 10),
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
                          ).pushNamedAndRemoveUntil('/menu/', (route) => false);
                        },
                        child: const Text('Menu'),
                      ),
                    ],
                  ),
                ],
              ),
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

Future<bool> logoutModal(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
