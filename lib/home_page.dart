import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'breathing_page.dart';
import 'sos_page.dart'; 
import 'relaxation_sounds_page.dart';
import 'gratitude_page.dart'; 
import 'mood_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // 1. DAFTAR HALAMAN (Cukup tulis sekali di sini saja)
  final List<Widget> _pages = [
    const HomeContent(),    // Index 0
    const MoodPage(),       // Index 1 (Halaman Mood yang asli)
    const GratitudePage(),  // Index 2 (Halaman Gratitude)
    const ProfilePage(),    // Index 3 (Halaman Profile yang baru)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black87),
        title: Text(
          'MindRest',
          style: GoogleFonts.poppins(
            color: const Color(0xFF2D4059), 
            fontWeight: FontWeight.bold, 
            fontSize: 22
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
          ),
        ],
      ),
      
      // Mengambil halaman dari daftar _pages berdasarkan index yang dipilih
      body: _pages[_selectedIndex], 

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF456B7D),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.sentiment_satisfied), label: 'Mood'),
          BottomNavigationBarItem(icon: Icon(Icons.edit_note), label: 'Gratitude'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------
// CLASS HomeContent (Isi Tab Home)
// ----------------------------------------------------------------------
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String _selectedMood = "Calm";

  final Map<String, String> _moodQuotes = {
    "Happy": "\"Happiness is from your own actions. Enjoy every spark of joy today!\"",
    "Calm": "\"Inner peace begins when you don't allow others to control your emotions.\"",
    "Neutral": "\"Balance is not something you find, it's something you create.\"",
    "Sad": "\"It's okay not to be okay. The sun will rise again tomorrow.\"",
    "Stressed": "\"Breathe. You're doing enough. Take it one step at a time.\"",
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Halo, Thahira 👋",
            style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF2D4059)),
          ),
          const SizedBox(height: 8),
          Text(
            "Bagaimana perasaanmu hari ini?",
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700]),
          ),
          const SizedBox(height: 25),

          // Mood Tracker Harian
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildMoodItem("Happy", "😊"),
                _buildMoodItem("Calm", "😌"),
                _buildMoodItem("Neutral", "😐"),
                _buildMoodItem("Sad", "😔"),
                _buildMoodItem("Stressed", "😫"),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Kartu Afirmasi
          Container(
            padding: const EdgeInsets.all(25),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
            ),
            child: Column(
              children: [
                const Icon(Icons.format_quote, color: Color(0xFF456B7D), size: 40),
                Text(
                  _moodQuotes[_selectedMood]!, 
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 16, fontStyle: FontStyle.italic, color: const Color(0xFF2D4059), height: 1.5),
                ),
                const SizedBox(height: 15),
                Text(
                  "— AFFIRMATION FOR ${_selectedMood.toUpperCase()}",
                  style: const TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold, color: Color(0xFF456B7D), fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),

          _buildActivityCard(
            title: "Breathing Exercise",
            subtitle: "ACTIVITY",
            imagePath: "assets/images/breathing.jpg",
            icon: Icons.air,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BreathingPage())),
          ),
          const SizedBox(height: 15),
          _buildActivityCard(
            title: "Relaxation Sounds",
            subtitle: "AMBIENT",
            imagePath: "assets/images/relaxation.jpg",
            icon: Icons.graphic_eq,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RelaxationSoundsPage())),
          ),
          const SizedBox(height: 15),

          // SOS Card
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SOSPage())),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFFC62828), borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("SOS Stress Relief", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text("Immediate techniques for panic or acute stress.", style: TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.white.withAlpha(50), shape: BoxShape.circle),
                    child: const Icon(Icons.star, color: Colors.white, size: 30),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildMoodItem(String label, String emoji) {
    bool isSelected = _selectedMood == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedMood = label),
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        width: 70,
        height: 90,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF456B7D) : Colors.white.withAlpha(150),
          borderRadius: BorderRadius.circular(15),
          border: isSelected ? null : Border.all(color: Colors.black12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 25)),
            const SizedBox(height: 5),
            Text(label, style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : Colors.black54)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard({required String title, required String subtitle, required String imagePath, required IconData icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap, 
      child: Container(
        height: 140,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black.withAlpha(76), BlendMode.darken)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white24, shape: BoxShape.circle), child: Icon(icon, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}