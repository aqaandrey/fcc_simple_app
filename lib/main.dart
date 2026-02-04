import 'welcome_view.dart';
import 'register_view.dart';
import 'login_view.dart';
import 'menu_view.dart';
import 'profile_view.dart';
import 'contacts_view.dart';
import 'help_view.dart';
import 'counter_view.dart';
import 'carousel_view.dart';
import 'carousel_view_old.dart';
import 'currency_rate_view.dart';
import 'package:flutter/material.dart' hide CarouselView;

void main() {
  runApp(
    MaterialApp(
      title: 'FreeCodeCampApp',
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.limeAccent),
      ),
      home: const WelcomeView(),
      routes: {
        '/home/': (context) => const WelcomeView(),
        '/register/': (context) => const RegisterView(),
        '/login/': (context) => const LoginView(),
        '/menu/': (context) => const MenuView(),
        '/profile/': (context) => const ProfileView(),
        '/counter/': (context) => const CounterView(),
        '/carousel/': (context) => const CarouselView(),
        // '/carousel/': (context) => const CarouselViewOld(),
        '/currencyRate/': (context) => const CurrencyRateView(),
        '/contacts/': (context) => const ContactsView(),
        '/help/': (context) => const HelpView(),
      },
    ),
  );
}

extension Lower on String {
  String get lower => toLowerCase();
}
