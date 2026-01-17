import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // 1. Pastikan inisialisasi Flutter sudah siap
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Inisialisasi Supabase
  // Ganti URL dan AnonKey dengan yang ada di Project Settings > API Supabase-mu
  await Supabase.initialize(
    url: 'https://inaydrozzillpxdneltv.supabase.co',
    anonKey: 'sb_publishable_js-QBGTd2upKdQEa696D2Q_p110sXbj',
  );

  runApp(const MyApp());
}

// 3. Variabel global untuk memanggil Supabase di file lain
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latihan UKK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const TestKoneksiPage(),
    );
  }
}

// 4. Halaman sederhana untuk ngetes koneksi
class TestKoneksiPage extends StatefulWidget {
  const TestKoneksiPage({super.key});

  @override
  State<TestKoneksiPage> createState() => _TestKoneksiPageState();
}

class _TestKoneksiPageState extends State<TestKoneksiPage> {
  String status = "Menunggu koneksi...";

  @override
  void initState() {
    super.initState();
    cekKoneksi();
  }

  Future<void> cekKoneksi() async {
    try {
      // Mencoba mengambil data dari tabel 'alat'
      final data = await supabase.from('alat').select();
      setState(() {
        status = "Koneksi Berhasil! Jumlah alat: ${data.length}";
      });
    } catch (e) {
      setState(() {
        status = "Koneksi Gagal: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cek Supabase")),
      body: Center(
        child: Text(status, textAlign: TextAlign.center),
      ),
    );
  }
}