import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BreathingPage extends StatefulWidget {
  const BreathingPage({super.key});

  @override
  State<BreathingPage> createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isStarted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Agar ikut warna background di main.dart
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF2D4059), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Breathing Exercise",
          style: GoogleFonts.poppins(color: const Color(0xFF2D4059), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Menyebar elemen
          children: [
            // Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: "Relax (4-4-6)",
                  isExpanded: true,
                  items: ["Relax (4-4-6)", "Energy (4-7-8)"].map((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
            ),

            // Lingkaran Animasi
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  width: 250,
                  height: 250,
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 180 * _animation.value,
                        height: 180 * _animation.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF456B7D).withAlpha(30),
                        ),
                      ),
                      Container(
                        width: 140,
                        height: 140,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF1D2D44),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Teks Instruksi
            Column(
              children: [
                Text(
                  _isStarted ? "Breathe slowly..." : "Ready to begin?",
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: const Color(0xFF2D4059)),
                ),
                const SizedBox(height: 10),
                Text(
                  "Find a comfortable position",
                  style: GoogleFonts.poppins(fontSize: 15, color: Colors.black45),
                ),
              ],
            ),

            // Tombol
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isStarted = !_isStarted;
                    _isStarted ? _controller.repeat(reverse: true) : _controller.stop();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D2D44),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: Text(
                  _isStarted ? "Stop Session" : "Start Session",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}