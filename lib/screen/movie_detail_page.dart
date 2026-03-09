import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import 'moviel_list_page.dart';

class MovieDetailPage extends StatefulWidget {
  final MovieModel movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  // Buat cek film ini udah masuk watchlist atau belum
  bool isSaved(MovieModel movie) {
    return WatchlistStorage.savedMovies.contains(movie);
  }

  // Buat nambah / hapus film dari daftar simpan
  void toggleSaved(MovieModel movie) {
    setState(() {
      if (WatchlistStorage.savedMovies.contains(movie)) {
        WatchlistStorage.savedMovies.remove(movie);
      } else {
        WatchlistStorage.savedMovies.add(movie);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Biar enak dipanggil, data film disimpan dulu ke variabel
    final movie = widget.movie;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "Movie Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
          width: 380,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster film
              Image.network(
                movie.imgUrl,
                width: double.infinity,
                height: 320,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 320,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image, size: 50),
                  );
                },
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Judul + tahun film
                        Text(
                          "${movie.title} (${movie.year})",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Sutradara
                        Text("Directed by ${movie.director}"),
                        const SizedBox(height: 14),

                        // Sinopsis
                        Text(
                          movie.synopsis,
                          style: const TextStyle(fontSize: 14, height: 1.5),
                        ),
                        const SizedBox(height: 16),

                        // Genre
                        Text(
                          "Genre: ${movie.genre}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),

                        // Daftar pemain
                        Text(
                          "Casts: ${movie.casts.join(', ')}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),

                        // Rating film
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 24,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Rated ${movie.rating}",
                              style: const TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        // Tombol wikipedia cuma tampil aja, ga perlu aktif
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: null,
                            style: ElevatedButton.styleFrom(
                              disabledBackgroundColor: Colors.grey.shade300,
                              disabledForegroundColor: Colors.black,
                              shape: const RoundedRectangleBorder(),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text("Go to Wikipedia"),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Tombol simpan / hapus dari daftar
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => toggleSaved(movie),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade300,
                              foregroundColor: Colors.black,
                              shape: const RoundedRectangleBorder(),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              isSaved(movie)
                                  ? "Hapus dari Daftar"
                                  : "Tambahkan ke Daftar",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
