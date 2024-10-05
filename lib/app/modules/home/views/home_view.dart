import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../profile/views/profile_view.dart'; // Import ProfileView

class HomeView extends GetView {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), // Tinggi AppBar disesuaikan
        child: AppBar(
          backgroundColor: Colors.teal,
          automaticallyImplyLeading: false, // Remove the back button
          elevation: 4.0, // Menambahkan sedikit elevasi
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                // Search action
              },
            ),
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                // Notifications action
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor info card
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.teal.withOpacity(0.2),
                    child: const Icon(
                      Icons.person,
                      color: Colors.teal,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Doctor',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Mr. Icikiwir',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Doctor section
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor:
                          Colors.white, // Mengubah warna tulisan jadi putih
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text('Doctor'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Find Your Doctor section
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Find Your Doctor',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'See All',
                  style: TextStyle(fontSize: 16, color: Colors.teal),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Categories Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryItem('Brain', Icons.psychology_outlined),
                  _buildCategoryItem('Heart', Icons.favorite_outline),
                  _buildCategoryItem('Lungs', Icons.air),
                  _buildCategoryItem('Mouth', Icons.mood),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Popular Doctors section
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Doctors',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'See All',
                  style: TextStyle(fontSize: 16, color: Colors.teal),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Popular Doctors List
            _buildDoctorCard('Dr. Noah', 'St. Gregory\'s Medical', 4.5,
                'assets/images/dr_noah.jpg'),
            const SizedBox(height: 16),
            _buildDoctorCard('Dr. Maria', 'St. Female Medical', 4.3,
                'assets/images/dr_maria.jpg'),
            const SizedBox(height: 16),
            _buildDoctorCard('Dr. Maria', 'St. Female Medical', 4.3,
                'assets/images/dr_maria.jpg'),
            const SizedBox(height: 16),
            _buildDoctorCard('Dr. Maria', 'St. Female Medical', 4.3,
                'assets/images/dr_maria.jpg'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Doctor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        elevation: 8.0,
        iconSize: 24.0,
        onTap: (index) {
          if (index == 3) {
            // Profile button index
            Get.to(() => const ProfileView());
          }
        },
      ),
    );
  }

  // Widget for category item
  Widget _buildCategoryItem(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: SizedBox(
        width: 80, // Adjust width to make items larger
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.teal.withOpacity(0.2),
              child: Icon(icon, color: Colors.teal, size: 30),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for doctor card
  Widget _buildDoctorCard(
      String name, String hospital, double rating, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 30,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(hospital, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  Text('$rating', style: const TextStyle(fontSize: 14)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Chat with doctor action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor:
                      Colors.white, // Mengubah warna tulisan jadi putih
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Chat'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
