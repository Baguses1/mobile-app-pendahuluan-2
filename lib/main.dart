import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Adopt',
      theme: ThemeData(
        fontFamily: 'Sans-Serif',
        primaryColor: const Color(0xFF1E3A8A),
      ),
      home: const PetAdoptScreen(),
    );
  }
}

class PetAdoptScreen extends StatefulWidget {
  const PetAdoptScreen({super.key});

  @override
  State<PetAdoptScreen> createState() => _PetAdoptScreenState();
}

class _PetAdoptScreenState extends State<PetAdoptScreen> {
  int currentSlide = 1;
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Pet Adopt',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey[300], height: 1.0),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildCurrentPage(),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1A233D),
        currentIndex: _bottomNavIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
            if (index == 0) {
              currentSlide = 1;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation_outlined),
            label: 'Movie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
  Widget _buildCurrentPage() {
    switch (_bottomNavIndex) {
      case 0:
        return _buildHomeTabFlow(); 
      case 1:
        return _buildMovieTab();   
      case 2:
        return const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Text('Halaman Profile', style: TextStyle(fontSize: 18, color: Colors.grey)),
          ),
        );
      default:
        return _buildHomeTabFlow();
    }
  }
  Widget _buildHomeTabFlow() {
    switch (currentSlide) {
      case 1:
        return _buildSlide1();
      case 2:
        return _buildSlide2();
      case 3:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showJadwalDialog();
        });
        return _buildSlide2();
      default:
        return _buildSlide1();
    }
  }

  Widget _buildMovieTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        const Text(
          'PRAKTIKUM PAB',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        const SizedBox(height: 16),
        Container(
          height: 340,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              )
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {

            },
            child: const Text(
              'Play',
              style: TextStyle(
                color: Colors.black, 
                fontWeight: FontWeight.bold, 
                fontSize: 20
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSlide1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 24),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.4,
          children: [
            _buildCategoryCard('Kucing', () {
              setState(() {
                currentSlide = 2;
              });
            }),
            _buildCategoryCard('Anjing', () {}),
            _buildCategoryCard('Kelinci', () {}),
            _buildCategoryCard('Burung', () {}),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ]
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
      ),
    );
  }
  Widget _buildSlide2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              currentSlide = 1;
            });
          },
          child: const Text('< Kembali', style: TextStyle(color: Colors.black)),
        ),
        const SizedBox(height: 8),
        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Eko',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Tersedia',
                style: TextStyle(color: Colors.green[800], fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ],
        ),
        Text(
          'British Shorthair umur 1 Tahun',
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        const SizedBox(height: 16),
        const Text(
          'Tentang Eko',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Eko adalah kucing',
          style: TextStyle(color: Colors.grey[700], height: 1.4),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF224261),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              setState(() {
                currentSlide = 3;
              });
            },
            child: const Text(
              'AJUKAN ADOPSI',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.1),
            ),
          ),
        ),
      ],
    );
  }

  void _showJadwalDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text(
            'Jadwalkan Kunjungan!',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Text(
            'Ingin menjadwalkan kunjungan dengan Eko di shelter kami sebelum melakukan adopsi?',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey[300]!),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  currentSlide = 2;
                });
              },
              child: const Text('Tidak', style: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  currentSlide = 1;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Jadwal kunjungan berhasil dibuat!')),
                );
              },
              child: const Text('Ya', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}