import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      body: Stack(
        children: [
          // Bagian atas berwarna hijau tua
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF3C887E),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(127, 0, 0, 0),
                  blurRadius: 20.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
          ),

          // Bagian bawah berwarna putih
          Container(
            margin: const EdgeInsets.only(top: 250),
            height: MediaQuery.of(context).size.height - 250,
            width: double.infinity,
            color: Colors.white,
          ),

          // Teks Profile dengan posisi yang dapat diatur
          Positioned(
            top: 60,
            left: MediaQuery.of(context).size.width / 2 - 45,
            child: const Text(
              'Profile',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // Ikon Kembali di sebelah kiri
          Positioned(
            top: 45,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Get.back(); // Kembali ke halaman sebelumnya
              },
            ),
          ),

          // Ikon Logout di sebelah kanan
          Positioned(
            top: 45,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                // Tampilkan dialog konfirmasi logout
                Get.defaultDialog(
                  title: 'Logout Confirmation',
                  middleText: 'Are you sure you want to log out?',
                  confirm: TextButton(
                    onPressed: () {
                      controller.logout(); // Panggil metode logout jika ya
                      Get.back(); // Tutup dialog
                    },
                    child: const Text('Yes'),
                  ),
                  cancel: TextButton(
                    onPressed: () {
                      Get.back(); // Tutup dialog jika tidak
                    },
                    child: const Text('No'),
                  ),
                );
              },
            ),
          ),

          // Foto profil dengan ikon
          Positioned(
            top: 115,
            left: MediaQuery.of(context).size.width / 2 - 60,
            child: GestureDetector(
              onTap: () {
                Get.bottomSheet(
                  Container(
                    color: Colors.white,
                    child: Wrap(
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: const Text('Gallery'),
                          onTap: () {
                            controller.pickImageFromGallery();
                            Get.back();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: const Text('Camera'),
                          onTap: () {
                            controller.pickImageFromCamera();
                            Get.back();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.delete),
                          title: const Text('Delete'),
                          onTap: () async {
                            await controller.deleteProfileImage();
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Obx(
                () => Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(127, 0, 0, 0),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 65,
                        backgroundImage: controller.profileImage.value != null
                            ? FileImage(controller.profileImage.value!)
                            : const AssetImage('assets/default_profile.png')
                                as ImageProvider,
                      ),
                      // Hanya tampilkan ikon person jika tidak ada gambar profil
                      if (controller.profileImage.value == null) ...[
                        const Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.white,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bagian username
          Positioned(
            top: 265,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Edit Username'),
                      content: TextFormField(
                        controller: controller.usernameController,
                        decoration: const InputDecoration(
                          hintText: 'Masukkan username baru',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back(); // Tutup dialog jika dibatalkan
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.saveProfile();
                            Get.back(); // Tutup dialog
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  );
                },
                child: Obx(() {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3C887E), // Warna latar belakang
                      borderRadius:
                          BorderRadius.circular(20), // Sudut melengkung
                    ),
                    child: Text(
                      controller.username.value.isNotEmpty
                          ? controller.username.value
                          : 'Username',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Warna teks
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          // Bagian Riwayat Kesehatan
          Positioned(
            top: 340,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Riwayat Kesehatan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 150,
                  height: 4, // ketebalan garis
                  color: const Color(0xFF3C887E), // warna hijau sesuai tema
                ),
              ],
            ),
          ),
          Positioned(
            top: 390,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(4, (index) {
                    // Daftar gambar yang ingin digunakan
                    final List<String> imageAssets = [
                      'assets/image/TINGGI BADAN.png', // Gambar untuk lingkaran pertama
                      'assets/image/BERAT BADAN.png', // Gambar untuk lingkaran kedua
                      'assets/image/UMUR.png', // Gambar untuk lingkaran ketiga
                      'assets/image/DARAH.png', // Gambar untuk lingkaran keempat
                    ];

                    final List<double> imageSizes = [
                      40.0, // Ukuran untuk gambar pertama
                      50.0, // Ukuran untuk gambar kedua
                      37.0, // Ukuran untuk gambar ketiga
                      45.0, // Ukuran untuk gambar keempat
                    ];

                    // Daftar teks yang ingin ditampilkan di bawah gambar
                    final List<String> labels = [
                      'Height', // Teks untuk lingkaran pertama
                      'Weight', // Teks untuk lingkaran kedua
                      'Age', // Teks untuk lingkaran ketiga
                      'Blood Type', // Teks untuk lingkaran keempat
                    ];

                    // Mengambil nilai dari controller atau nilai default
                    final List<String> values = [
                      '190', // Tinggi badan dalam cm
                      '60', // Berat badan dalam kg
                      '29', // Umur
                      'A', // Golongan darah
                    ];

                    // Mengambil satuan yang sesuai untuk setiap atribut
                    final List<String> units = [
                      'cm', // Satuan untuk tinggi
                      'kg', // Satuan untuk berat
                      '', // Tidak ada satuan untuk umur
                      '', // Tidak ada satuan untuk golongan darah
                    ];

                    // Mengambil gambar dan ukuran sesuai index
                    final imageAsset = imageAssets[index];
                    final double imageSize = imageSizes[index];
                    final String label = labels[index];
                    final String value = values[index];
                    final String unit = units[index];

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Aksi ketika lingkaran ditekan (jika perlu)
                            // Contoh: controller.updateHealthData(label, newValue);
                          },
                          child: Container(
                            width: 60.0, // Ukuran lingkaran hijau tetap
                            height: 60.0, // Ukuran lingkaran hijau tetap
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(
                                  0xFFDEF2EF), // Warna latar belakang lingkaran
                            ),
                            child: ClipOval(
                              child: Container(
                                width: 60.0, // Ukuran lingkaran tetap
                                height: 60.0, // Ukuran lingkaran tetap
                                alignment: Alignment
                                    .center, // Memastikan gambar terpusat
                                color: Colors.transparent,
                                child: Image.asset(
                                  imageAsset,
                                  fit: BoxFit.cover,
                                  width: imageSize, // Menentukan ukuran gambar
                                  height: imageSize, // Menentukan ukuran gambar
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                            height: 8), // Jarak antara gambar dan teks
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          unit.isNotEmpty
                              ? '$value $unit'
                              : value, // Menampilkan teks untuk nilai dengan satuan
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(
                                255, 87, 85, 85), // Warna untuk nilai
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 8), // Jarak sebelum garis
                // Garis pemisah memanjang ke samping
                Container(
                  height: 5, // Tinggi garis
                  width: double.infinity, // Lebar garis (memanjang penuh)
                  color: Colors.grey[300], // Warna garis abu-abu
                ),
                const SizedBox(
                    height: 15), // Jarak sebelum teks Riwayat Penyakit
                // Teks Riwayat Penyakit
              ],
            ),
          ),
          Positioned(
            top: 520,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Riwayat Kesehatan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 150,
                  height: 4, // ketebalan garis
                  color: const Color(0xFF3C887E), // warna hijau sesuai tema
                ),
              ],
            ),
          ),
          Positioned(
            top: 550, // Posisi awal dari Container ini
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20), // Jarak antara garis dan lingkaran
                // Elemen gambar dan label
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(4, (index) {
                    // Daftar gambar yang ingin digunakan
                    final List<String> imageAssets = [
                      'assets/image/TBC.png',
                      'assets/image/DEMAM BERDARAH.png',
                      'assets/image/ASMA.png',
                      'assets/image/OBESITAS.png',
                    ];

                    final List<double> imageSizes = [35.0, 38.0, 35.0, 38.0];

                    // Daftar teks yang ingin ditampilkan di bawah gambar
                    final List<String> labels = [
                      'TBC',
                      'DBD',
                      'Asma',
                      'Obesitas',
                    ];

                    final imageAsset = imageAssets[index];
                    final double imageSize = imageSizes[index];
                    final String label = labels[index];

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60.0, // Ukuran lingkaran hijau tetap
                          height: 60.0, // Ukuran lingkaran hijau tetap
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(
                                0xFFDEF2EF), // Warna latar belakang lingkaran
                          ),
                          child: ClipOval(
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              alignment: Alignment
                                  .center, // Memastikan gambar terpusat
                              color: Colors.transparent,
                              child: Image.asset(
                                imageAsset,
                                fit: BoxFit.cover,
                                width: imageSize,
                                height: imageSize,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                            height: 8), // Jarak antara gambar dan teks
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 15), // Jarak sebelum teks "Lainnya"

                // Elemen untuk teks "Lainnya"
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 115),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Lainnya',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3C887E),
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFF3C887E),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8), // Jarak sebelum garis

                // Garis pemisah memanjang ke samping
                Container(
                  height: 5, // Tinggi garis
                  width: double.infinity, // Lebar garis (memanjang penuh)
                  color: Colors.grey[300], // Warna garis abu-abu
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
