import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GratitudePage extends StatefulWidget {
  const GratitudePage({super.key});

  @override
  State<GratitudePage> createState() => _GratitudePageState();
}

class _GratitudePageState extends State<GratitudePage> {
  // Controller untuk mengambil teks dari input
  final TextEditingController _journalController = TextEditingController();

  // Data dummy untuk Riwayat (Nanti bisa ditambah saat klik Simpan)
  final List<Map<String, String>> _history = [
    {
      "date": "Senin, 20 Mei 2024",
      "content": "Aku bersyukur bisa menikmati secangkir kopi hangat pagi ini sambil mendengarkan kicauan burung di jendela."
    },
    {
      "date": "Minggu, 19 Mei 2024",
      "content": "Bersyukur karena pekerjaan selesai tepat waktu dan aku punya malam yang tenang bersama keluarga."
    },
    {
      "date": "Sabtu, 18 Mei 2024",
      "content": "Sangat berterima kasih atas dukungan sahabatku saat aku merasa lelah. Kehadirannya benar-benar menguatkan hari ini."
    },
  ];

  void _saveEntry() {
    if (_journalController.text.isNotEmpty) {
      setState(() {
        // Tambahkan ke daftar paling atas
        _history.insert(0, {
          "date": "Hari ini", 
          "content": _journalController.text
        });
        _journalController.clear(); // Kosongkan input
      });
      // Tampilkan notifikasi kecil
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Catatan syukur berhasil disimpan!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Ikut background main.dart
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Gratitude Journal",
              style: GoogleFonts.playfairDisplay(
                fontSize: 32, 
                fontWeight: FontWeight.bold, 
                color: const Color(0xFF1D2D44)
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Take a moment to reflect on the beauty in your life.",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black45),
            ),
            const SizedBox(height: 30),

            // CARD PROMPT HARI INI
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.edit_note, color: Color(0xFF456B7D)),
                      const SizedBox(width: 8),
                      Text(
                        "PROMPT HARI INI",
                        style: GoogleFonts.poppins(
                          fontSize: 12, 
                          fontWeight: FontWeight.bold, 
                          color: const Color(0xFF456B7D), 
                          letterSpacing: 1
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Sebutkan satu hal yang kamu syukuri hari ini",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold, 
                      color: const Color(0xFF2D4059)
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _journalController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Hari ini aku bersyukur karena...",
                      hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
                      filled: true,
                      fillColor: const Color(0xFFFDF7F2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _saveEntry,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1D2D44),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text("Simpan", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 40),

            // RIWAYAT SECTION
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Riwayat",
                  style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.bold, color: const Color(0xFF2D4059)),
                ),
                TextButton(
                  onPressed: () {}, 
                  child: const Text("Lihat Semua", style: TextStyle(color: Colors.black45, fontSize: 12))
                ),
              ],
            ),
            const SizedBox(height: 10),

            // LIST RIWAYAT
            ..._history.map((item) => _buildHistoryCard(item['date']!, item['content']!)),
            
            const SizedBox(height: 100), // Spasi bawah agar tidak tertutup nav bar
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard(String date, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 14, color: Color(0xFF456B7D)),
                  const SizedBox(width: 8),
                  Text(date, style: const TextStyle(color: Color(0xFF456B7D), fontSize: 13, fontWeight: FontWeight.bold)),
                ],
              ),
              const Icon(Icons.more_horiz, color: Colors.black26),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "\"$content\"",
            style: GoogleFonts.poppins(
              fontSize: 14, 
              fontStyle: FontStyle.italic, 
              color: Colors.black87,
              height: 1.6
            ),
          ),
        ],
      ),
    );
  }
}