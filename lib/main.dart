import 'package:flutter/material.dart';

// Ini buat model film, dipakai pas mau kirim data ke halaman detail
import 'models/movie_model.dart';

// Ini import halaman-halaman yang dipakai
import 'screen/login_page.dart';
import 'screen/moviel_list_page.dart';
import 'screen/movie_detail_page.dart';
import 'screen/watchlist_page.dart';

void main() {
  runApp(const MainApp());
}

// Ini widget utama aplikasi
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Biar tulisan DEBUG di pojok kanan atas hilang
      debugShowCheckedModeBanner: false,

      // Judul aplikasi
      title: 'Movie App',

      // Halaman pertama yang kebuka pas app dijalankan
      initialRoute: '/',

      // Route yang biasa aja, jadi ga perlu kirim data
      routes: {
        '/': (context) => const LoginPage(),
        '/watchlist': (context) => const WatchlistPage(),
      },

      // Ini dipakai kalau route-nya butuh bawa data
      onGenerateRoute: (settings) {
        // Kalau pindah ke halaman daftar film
        if (settings.name == '/movieList') {
          final args = settings.arguments;

          return MaterialPageRoute(
            builder: (context) => MovielListPage(
              // Kalau ada data nama, pakai nama itu
              // Kalau ga ada, isi default "User"
              nama: args is String ? args : 'User',
            ),
          );
        }

        // Kalau pindah ke halaman detail film
        if (settings.name == '/movieDetail') {
          final args = settings.arguments;

          return MaterialPageRoute(
            builder: (context) => MovieDetailPage(
              // Data yang dikirim harus berupa MovieModel
              movie: args as MovieModel,
            ),
          );
        }

        // Kalau route-nya ga ketemu
        return null;
      },
    );
  }
}
