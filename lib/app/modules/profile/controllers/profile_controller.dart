import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var profileImage = Rx<File?>(null);
  var username = ''.obs;
  late TextEditingController usernameController;

  // Variabel untuk nilai riwayat kesehatan
  var height = '-'.obs;
  var weight = '-'.obs;
  var age = '-'.obs;
  var bloodType = '-'.obs;

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    loadProfileData(); // Memuat data saat inisialisasi
  }

  @override
  void onClose() {
    usernameController.dispose();
    super.onClose();
  }

  // Fungsi untuk memperbarui nilai riwayat kesehatan
  void updateHealthData(String label, String value) {
    switch (label) {
      case 'Height':
        height.value = value;
        break;
      case 'Weight':
        weight.value = value;
        break;
      case 'Age':
        age.value = value;
        break;
      case 'Blood Type':
        bloodType.value = value;
        break;
      default:
        print('Unknown label: $label');
    }
    // Panggil metode saveHealthData untuk menyimpan data kesehatan
    saveHealthData(); 
  }

  // Fungsi untuk menyimpan data kesehatan
  Future<void> saveHealthData() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Simpan data kesehatan
    await prefs.setString('height', height.value);
    await prefs.setString('weight', weight.value);
    await prefs.setString('age', age.value);
    await prefs.setString('bloodType', bloodType.value);
    
    Get.snackbar('Success', 'Health data saved successfully!');
  }

  // Fungsi untuk mengambil gambar dari galeri
  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      profileImage.value = File(image.path);
      await saveProfile(); // Simpan gambar setelah diambil
    } else {
      Get.snackbar('Error', 'Gagal mengambil gambar dari galeri.');
    }
  }

  Future<void> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      profileImage.value = File(image.path);
      await saveProfile(); // Simpan gambar setelah diambil
    } else {
      Get.snackbar('Error', 'Gagal mengambil gambar dari kamera.');
    }
  }

  // Fungsi untuk menyimpan profil dan riwayat kesehatan

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();

    // Simpan username
    if (usernameController.text.isNotEmpty) {
      username.value = usernameController.text;
      await prefs.setString('username', username.value);
    } else {
      Get.snackbar('Warning', 'Username tidak boleh kosong!');
      return; // Hentikan eksekusi jika username kosong
    }

    // Simpan foto profil
    if (profileImage.value != null) {
      try {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = profileImage.value!.path.split('/').last;
        final savedImage = await profileImage.value!.copy('${appDir.path}/$fileName');
        await prefs.setString('profileImagePath', savedImage.path);
      } catch (e) {
        Get.snackbar('Error', 'Failed to save profile image: $e');
        return; // Keluar dari fungsi jika ada error
      }
    }

    Get.snackbar('Success', 'Profile saved successfully!');
  }

  Future<void> deleteProfileImage() async {
    profileImage.value = null; // Set gambar profil menjadi null
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profileImagePath'); // Hapus path gambar dari SharedPreferences
    Get.snackbar('Success', 'Profile image deleted successfully!');
  }

  Future<void> loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    // Muat username
    String? savedUsername = prefs.getString('username');
    if (savedUsername != null) {
      username.value = savedUsername;
      usernameController.text = savedUsername;
    }
    // Muat foto profil
    String? profileImagePath = prefs.getString('profileImagePath');
    if (profileImagePath != null) {
      profileImage.value = File(profileImagePath);
    }

    // Muat data kesehatan
    height.value = prefs.getString('height') ?? '-';
    weight.value = prefs.getString('weight') ?? '-';
    age.value = prefs.getString('age') ?? '-';
    bloodType.value = prefs.getString('bloodType') ?? '-';
  }

  // Metode logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username'); // Hapus username dari SharedPreferences
    await prefs.remove('profileImagePath'); // Hapus gambar profil dari SharedPreferences
    profileImage.value = null; // Set gambar profil menjadi null
    username.value = ''; // Reset username

    Get.offAllNamed('/login'); // Ganti dengan rute halaman login Anda
    Get.snackbar('Success', 'You have logged out successfully!');
  }
}
