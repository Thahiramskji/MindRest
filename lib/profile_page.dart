import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Mengikuti background di main.dart
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: Column(
          children: [
            // 1. FOTO PROFIL
            Center(
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 20)
                  ],
                ),
                child: const CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
              ),
            ),
            const SizedBox(height: 25),

            // 2. NAMA USER
            Text(
              "Thahira",
              style: GoogleFonts.playfairDisplay(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1D2D44),
              ),
            ),
            const SizedBox(height: 40),

            // 3. STAT CARDS
            _buildStatCard(
              icon: Icons.sentiment_satisfied_alt,
              count: "124",
              label: "TOTAL MOOD TERCATAT",
            ),
            const SizedBox(height: 20),
            _buildStatCard(
              icon: Icons.edit_note,
              count: "48",
              label: "TOTAL JURNAL DIBUAT",
            ),
            const SizedBox(height: 20),
            _buildStatCard(
              icon: Icons.calendar_today_outlined,
              count: "312",
              label: "HARI PENGGUNAAN APLIKASI",
            ),

            const SizedBox(height: 60),

            // 4. LOG OUT BUTTON
            TextButton(
              onPressed: () {
                // Tambahkan logika logout di sini
              },
              child: Text(
                "LOG OUT",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[800],
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 100), // Spasi bawah agar tidak tertutup nav bar
          ],
        ),
      ),
    );
  }

  // Helper Widget untuk membuat kartu statistik
  Widget _buildStatCard({required IconData icon, required String count, required String label}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          // Lingkaran ikon biru muda
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFD1E9F6),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF456B7D), size: 28),
          ),
          const SizedBox(height: 15),
          // Angka besar
          Text(
            count,
            style: GoogleFonts.playfairDisplay(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1D2D44),
            ),
          ),
          const SizedBox(height: 5),
          // Label teks kecil
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.black45,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}