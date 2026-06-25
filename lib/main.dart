import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

// Menghilangkan scrollbar agar tampilan bersih seperti HP
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    return child; 
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'MindRest',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF456B7D)),
      ),
      // INI RAHASIANYA: Builder akan membungkus SETIAP halaman yang dibuka
      builder: (context, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFE0E0E0), // Warna background luar browser
          body: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 450), // Lebar maksimal HP
              decoration: BoxDecoration(
                color: const Color(0xFFFDF7F2), // Warna dasar aplikasi
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(40),
                    blurRadius: 30,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: child, // Di sini halaman (Home/Breathing) akan muncul
            ),
          ),
        );
      },
      home: const HomePage(),
    );
  }
}