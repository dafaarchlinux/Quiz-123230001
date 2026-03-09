import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import 'moviel_list_page.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  // Buat hapus film dari watchlist
  void removeFromWatchlist(MovieModel movie) {
    setState(() {
      WatchlistStorage.savedMovies.remove(movie);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Ambil semua film yang sudah disimpan
    final List<MovieModel> savedMovies = WatchlistStorage.savedMovies;

    return Scaffold(
      appBar: AppBar(title: const Text("Watchlist")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: savedMovies.isEmpty
            ? const Center(
                // Kalau belum ada film yang disimpan
                child: Text(
                  "Belum ada film yang disimpan",
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: savedMovies.length,
                itemBuilder: (context, index) {
                  final movie = savedMovies[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () async {
                          // Kalau item diklik, masuk ke halaman detail
                          await Navigator.pushNamed(
                            context,
                            '/movieDetail',
                            arguments: movie,
                          );

                          // Setelah balik dari detail, refresh lagi
                          setState(() {});
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Poster film
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                movie.imgUrl,
                                width: 80,
                                height: 110,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 80,
                                    height: 110,
                                    color: Colors.grey.shade300,
                                    child: const Icon(Icons.broken_image),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Info film
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text('Tahun: ${movie.year}'),
                                  const SizedBox(height: 4),
                                  Text('Genre: ${movie.genre}'),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),
                                      Text('Rating: ${movie.rating}'),
                                    ],
                                  ),
                                  const SizedBox(height: 10),

                                  // Tombol hapus dari daftar
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      removeFromWatchlist(movie);
                                    },
                                    icon: const Icon(Icons.delete_outline),
                                    label: const Text('Hapus dari Daftar'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
