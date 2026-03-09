class User {
  // Data dasar user
  final String username;
  final String password;
  final String nama;

  // Constructor buat isi data user
  User({required this.username, required this.password, required this.nama});
}

// Ini data user yang dipakai buat login
// Username = dafa
// Password = 001
User user1 = User(username: 'dafa', password: '001', nama: 'Dafa');
