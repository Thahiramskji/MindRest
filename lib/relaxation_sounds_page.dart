import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';

class RelaxationSoundsPage extends StatefulWidget {
  const RelaxationSoundsPage({super.key});

  @override
  State<RelaxationSoundsPage> createState() => _RelaxationSoundsPageState();
}

class _RelaxationSoundsPageState extends State<RelaxationSoundsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D4059)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Relaxation Sounds",
          style: GoogleFonts.poppins(color: const Color(0xFF2D4059), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Relaxation Sounds",
              style: GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.bold, color: const Color(0xFF1D2D44)),
            ),
            const SizedBox(height: 10),
            Text(
              "Curate your auditory sanctuary for deep focus or restful sleep.",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            
            // Daftar Suara
            const SoundControlCard(title: "Rain Sound ☁️", image: "assets/images/breathing.jpg", audioPath: "audio/rain.mp3"),
            const SoundControlCard(title: "Ocean Waves 🌊", image: "assets/images/relaxation.jpg", audioPath: "audio/ocean.mp3"),
            const SoundControlCard(title: "Forest 🌲", image: "assets/images/relaxation.jpg", audioPath: "audio/forest.mp3"),
            const SoundControlCard(title: "Wind 🍃", image: "assets/images/breathing.jpg", audioPath: "audio/wind.mp3"),

            const SizedBox(height: 40),
            
            // Timer Section
            Center(
              child: Column(
                children: [
                  Text("Sleep Timer", style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  const Text("Automatically stop sounds after a selected period.", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      _timerButton("5 min"),
                      _timerButton("10 min"),
                      _timerButton("15 min"),
                      _timerButton("30 min"),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _timerButton("Off", isOff: true),
                ],
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _timerButton(String label, {bool isOff = false}) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: isOff ? const Color(0xFFF2E3E3) : Colors.transparent,
        side: BorderSide(color: isOff ? Colors.transparent : Colors.grey),
        shape: StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      ),
      child: Text(label, style: TextStyle(color: isOff ? Colors.red[900] : Colors.black87)),
    );
  }
}

// WIDGET KARTU SUARA (KOMPONEN TERPISAH)
class SoundControlCard extends StatefulWidget {
  final String title;
  final String image;
  final String audioPath;

  const SoundControlCard({super.key, required this.title, required this.image, required this.audioPath});

  @override
  State<SoundControlCard> createState() => _SoundControlCardState();
}

class _SoundControlCardState extends State<SoundControlCard> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  double _sliderValue = 0.5;

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _togglePlay() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      await _player.play(AssetSource(widget.audioPath));
      await _player.setVolume(_sliderValue);
    }
    setState(() => _isPlaying = !_isPlaying);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          // Bagian Gambar
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage(widget.image),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withAlpha(50), BlendMode.darken),
              ),
            ),
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(15),
            child: Text(
              widget.title,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // Bagian Kontrol (Play & Slider)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: _togglePlay,
                  icon: Icon(_isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled),
                  iconSize: 45,
                  color: const Color(0xFF1D2D44),
                ),
                Expanded(
                  child: Slider(
                    value: _sliderValue,
                    activeColor: const Color(0xFF456B7D),
                    inactiveColor: const Color(0xFF456B7D).withAlpha(50),
                    onChanged: (val) {
                      setState(() => _sliderValue = val);
                      _player.setVolume(val);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}