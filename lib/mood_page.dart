import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoodPage extends StatefulWidget {
  const MoodPage({super.key});

  @override
  State<MoodPage> createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  String _selectedMood = "Senang"; 
  final TextEditingController _noteController = TextEditingController();

  final List<Map<String, dynamic>> _moodOptions = [
    {"label": "Sedih", "emoji": "😔", "color": const Color(0xFFFFEBEE)},
    {"label": "Biasa", "emoji": "😐", "color": const Color(0xFFF5F5F5)},
    {"label": "Senang", "emoji": "😊", "color": const Color(0xFFB3E5FC)},
    {"label": "Hebat", "emoji": "🤩", "color": const Color(0xFFFFF9C4)},
    {"label": "Tenang", "emoji": "🧘", "color": const Color(0xFFF3E5F5)},
  ];

  // List Riwayat (Sekarang tidak 'final' agar bisa ditambah)
  List<Map<String, dynamic>> _history = [
    {
      "mood": "Senang",
      "emoji": "😊",
      "time": "Hari ini, 09:41",
      "note": "Menyelesaikan proyek besar di kantor dan sempat berjalan santai",
      "bgColor": const Color(0xFFB3E5FC)
    },
    {
      "mood": "Tenang",
      "emoji": "🧘",
      "time": "Kemarin, 21:15",
      "note": "Melakukan meditasi 10 menit sebelum tidur. Merasa lebih ringan",
      "bgColor": const Color(0xFFF3E5F5)
    },
  ];

  // --- FUNGSI SIMPAN ---
  void _saveMood() {
    if (_noteController.text.isNotEmpty) {
      setState(() {
        // Ambil data mood yang sedang dipilih untuk mencari warnanya
        var currentMoodData = _moodOptions.firstWhere((m) => m['label'] == _selectedMood);

        // Tambahkan data baru ke urutan paling atas (index 0)
        _history.insert(0, {
          "mood": _selectedMood,
          "emoji": currentMoodData['emoji'],
          "time": "Hari ini, ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
          "note": _noteController.text,
          "bgColor": currentMoodData['color'],
        });

        // Kosongkan input setelah simpan
        _noteController.clear();
      });

      // Tampilkan notifikasi sukses
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mood berhasil disimpan!")),
      );
    } else {
      // Notifikasi jika catatan kosong
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tuliskan sesuatu terlebih dahulu!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 15)],
              ),
              child: Column(
                children: [
                  Text(
                    "Bagaimana perasaanmu hari ini?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF2D4059)),
                  ),
                  const SizedBox(height: 25),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: _moodOptions.map((m) => _buildMoodCard(m)).toList(),
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: _noteController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Apa yang membuatmu merasa seperti ini?",
                      hintStyle: const TextStyle(color: Colors.black26, fontSize: 13),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.black12)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _saveMood, // MEMANGGIL FUNGSI SIMPAN
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1D2D44),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text("Simpan Mood", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Riwayat Mood", style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.bold, color: const Color(0xFF2D4059))),
                TextButton(onPressed: () {}, child: const Text("Lihat Semua", style: TextStyle(color: Color(0xFF456B7D), fontSize: 12))),
              ],
            ),
            const SizedBox(height: 10),
            ..._history.map((item) => _buildHistoryCard(item)).toList(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodCard(Map<String, dynamic> m) {
    bool isSelected = _selectedMood == m['label'];
    return GestureDetector(
      onTap: () => setState(() => _selectedMood = m['label']),
      child: Container(
        width: 80,
        height: 100,
        decoration: BoxDecoration(
          color: isSelected ? m['color'] : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.black12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(m['emoji'], style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 5),
            Text(m['label'], style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(5), blurRadius: 5)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: item['bgColor'], shape: BoxShape.circle),
            child: Text(item['emoji'], style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item['mood'], style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(item['time'], style: const TextStyle(color: Colors.black38, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 5),
                Text(item['note'], style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54, height: 1.5)),
              ],
            ),
          )
        ],
      ),
    );
  }
}