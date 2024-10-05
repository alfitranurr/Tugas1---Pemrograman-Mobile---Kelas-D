import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Expanded(
            flex: 5,
            child: Image.asset(
              'assets/image/splashscreen.jpg',
              fit: BoxFit.contain,
              width: 250,
              height: 250,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Lelah dengan\npenyakit anda?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              'ini aku gatau mau isi apa yang penting ngetik aja dulu, kata fitra dia cinta speed',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          const Spacer(flex: 1), // Mengurangi jarak antara teks dan tombol
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/login');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: const Color(0xFF39847A), // Warna hijau
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50, // Lebar tombol "Have an account?" menjadi kotak kecil
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Get.toNamed('/login');
                        },
                        icon: const Icon(Icons.account_circle_outlined,
                            color: Color(0xFF39847A)),
                        label: const SizedBox.shrink(), // Tidak ada label
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF39847A)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // Jarak antara kedua tombol
                    SizedBox(
                      width: 230, // Mengatur lebar tombol "Not have an account?" menjadi lebih panjang
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/register');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 1),
                        ),
                        child: const Text(
                          'Not have an account?',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
