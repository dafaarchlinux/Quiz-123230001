import 'package:flutter/material.dart';
import '../models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller buat ngambil isi dari input username
  final TextEditingController _usernameController = TextEditingController();

  // Controller buat ngambil isi dari input password
  final TextEditingController _passwordController = TextEditingController();

  // Ini dipakai buat nandain apakah login gagal
  bool isLoginFailed = false;

  void _login() {
    // Ambil isi input lalu rapihin spasi depan belakang
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    // Kalau ada yang kosong, tampilkan pesan error
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        isLoginFailed = true;
      });

      _showErrorSnackBar('Data tidak boleh kosong');
      return;
    }

    // Cek login sesuai data user1 dari user.dart
    if (username == user1.username && password == user1.password) {
      setState(() {
        isLoginFailed = false;
      });

      // Kasih notif kalau login berhasil
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Login berhasil')));

      // Pindah ke halaman daftar film
      // arguments dipakai buat kirim nama user
      Navigator.pushReplacementNamed(
        context,
        '/movieList',
        arguments: user1.nama,
      );
    } else {
      // Kalau username/password salah
      setState(() {
        isLoginFailed = true;
      });

      _showErrorSnackBar('Username atau password salah');
    }
  }

  void _showErrorSnackBar(String message) {
    // Fungsi biar ga nulis SnackBar berulang-ulang
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(message),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool isLoginFailed,
    bool obscure = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        // Bayangan biar input kelihatan lebih bagus
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,

          // Icon jadi merah kalau login gagal
          prefixIcon: Icon(
            icon,
            color: isLoginFailed ? Colors.red : const Color(0xFF0377FF),
          ),
          hintStyle: const TextStyle(color: Colors.black54, fontSize: 16),
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          border: InputBorder.none,

          // Border biasa
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: isLoginFailed
                  ? Colors.red.withOpacity(0.5)
                  : Colors.transparent,
              width: 1.5,
            ),
          ),

          // Border pas lagi diklik
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFF0377FF), width: 2),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Jangan lupa dispose biar controller ga numpuk
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Warna background halaman
      backgroundColor: const Color(0xFFF2F2F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),

                // Judul halaman login
                const Text(
                  'Selamat\nDatang',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    letterSpacing: -1,
                  ),
                ),

                const SizedBox(height: 8),

                // Teks kecil di bawah judul
                Text(
                  'Silakan masuk ke akun Anda',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 60),

                // Input username
                _inputField(
                  controller: _usernameController,
                  hint: 'Username',
                  icon: Icons.person_outline,
                  isLoginFailed: isLoginFailed,
                ),

                const SizedBox(height: 16),

                // Input password
                _inputField(
                  controller: _passwordController,
                  hint: 'Password',
                  icon: Icons.lock_outline,
                  isLoginFailed: isLoginFailed,
                  obscure: true,
                ),

                const SizedBox(height: 40),

                // Tombol login
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0377FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
