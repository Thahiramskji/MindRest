import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SOSPage extends StatefulWidget {
  const SOSPage({super.key});

  @override
  State<SOSPage> createState() => _SOSPageState();
}

class _SOSPageState extends State<SOSPage> {
  // Untuk menyimpan teks instruksi yang akan muncul setelah klik tombol
  String _currentInstruction = "Kami di sini untuk membantumu kembali tenang. Tekan tombol di bawah saat kamu siap.";
  int _step = 0; // Langkah-langkah (0: awal, 1: Tarik Napas, 2: Pesan Positif, 3: Musik/Meditasi)

  void _handleSOSClick() {
    setState(() {
      _step++;
      if (_step == 1) {
        _currentInstruction = "Langkah 1: Tarik napas dalam-dalam. Fokus pada napasmu.";
      } else if (_step == 2) {
        _currentInstruction = "Langkah 2: Ingatlah, kamu kuat. Semua akan baik-baik saja.";
      } else if (_step == 3) {
        _currentInstruction = "Langkah 3: Mari kita dengarkan musik penenang sebentar.";
        // Di sini nanti bisa navigasi ke Relaxation Sounds atau memutar musik langsung
      } else {
        // Kembali ke awal atau navigasi ke halaman lain
        _step = 0;
        _currentInstruction = "Kami di sini untuk membantumu kembali tenang. Tekan tombol di bawah saat kamu siap.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Mengikuti background dari main.dart
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF2D4059), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "SOS Stress Relief",
          style: GoogleFonts.poppins(color: const Color(0xFF2D4059), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Menyebar elemen
          children: [
            // Text Header
            Column(
              children: [
                Text(
                  "Butuh bantuan segera?",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2D4059),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  _currentInstruction, // Teks akan berubah
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            // Lingkaran Besar "Aku Lagi Stres"
            GestureDetector(
              onTap: _handleSOSClick, // Tombol klik
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFFC62828), // Warna merah SOS
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.5), width: 5), // Ring putih
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _step == 0 ? Icons.local_hospital_rounded : (_step == 1 ? Icons.psychology : Icons.music_note), // Ikon berubah
                      color: Colors.white,
                      size: 50,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _step == 0 ? "AKU LAGI STRES" : (_step == 1 ? "TARIK NAPAS" : (_step == 2 ? "PESAN POSITIF" : "DENGARKAN MUSIK")),
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // Tombol "Kembali" atau "Lanjut" (opsional, bisa diganti dengan lingkaran di atas)
            // SizedBox(
            //   width: double.infinity,
            //   height: 50,
            //   child: ElevatedButton(
            //     onPressed: _handleSOSClick,
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color(0xFF2D4059),
            //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            //     ),
            //     child: Text(
            //       _step == 0 ? "Mulai Relaksasi" : "Lanjut",
            //       style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}