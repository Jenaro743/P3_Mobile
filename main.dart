
import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _bbController = TextEditingController();
  final _tbController = TextEditingController();

  double? _hasilBMI;
  String _keterangan = 'Masukkan data untuk menghitung BMI';
  String _jenisKelamin = 'Laki-laki';
  String? _error;

  Color _warnaHasil = const Color(0xFF64748B);

  void _hitungBMI() {
    final bb = double.tryParse(
      _bbController.text.trim().replaceAll(',', '.'),
    );
    final tb = double.tryParse(
      _tbController.text.trim().replaceAll(',', '.'),
    );

    setState(() {
      if (bb == null ||
          tb == null ||
          !bb.isFinite ||
          !tb.isFinite ||
          bb <= 0 ||
          tb <= 0 ||
          tb > 300 ||
          bb > 500) {
        _hasilBMI = null;
        _error = 'Masukkan berat dan tinggi badan yang valid.';
        _keterangan = 'Data belum valid';
        _warnaHasil = const Color(0xFF64748B);
        return;
      }

      final tbMeter = tb / 100;
      final bmi = bb / (tbMeter * tbMeter);

      _hasilBMI = bmi;
      _error = null;

      if (bmi < 18.5) {
        _keterangan = 'Berat badan kurang';
        _warnaHasil = const Color(0xFF0284C7);
      } else if (bmi < 25) {
        _keterangan = 'Berat badan normal';
        _warnaHasil = const Color(0xFF16A34A);
      } else if (bmi < 30) {
        _keterangan = 'Berat badan berlebih';
        _warnaHasil = const Color(0xFFF59E0B);
      } else {
        _keterangan = 'Obesitas';
        _warnaHasil = const Color(0xFFDC2626);
      }
    });
  }

  void _resetBMI() {
    setState(() {
      _bbController.clear();
      _tbController.clear();
      _hasilBMI = null;
      _jenisKelamin = 'Laki-laki';
      _keterangan = 'Masukkan data untuk menghitung BMI';
      _error = null;
      _warnaHasil = const Color(0xFF64748B);
    });
  }

  @override
  void dispose() {
    _bbController.dispose();
    _tbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text(
          'Kalkulator BMI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF4338CA),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE0E7FF),
              Color(0xFFF8FAFC),
              Color(0xFFF1F5F9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.health_and_safety_rounded,
                  size: 65,
                  color: Color(0xFF4338CA),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Kenali Kondisi Tubuhmu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Masukkan data tubuh untuk mengetahui indeks massa tubuh.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 25),

                // Form input
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4338CA)
                            .withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Data Pribadi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 20),

                      const Text(
                        'Jenis Kelamin',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(height: 8),

                      DropdownButtonFormField<String>(
                        value: _jenisKelamin,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Color(0xFF4338CA),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF8FAFC),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Laki-laki',
                            child: Text('Laki-laki'),
                          ),
                          DropdownMenuItem(
                            value: 'Perempuan',
                            child: Text('Perempuan'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _jenisKelamin = value;
                            });
                          }
                        },
                      ),

                      const SizedBox(height: 18),
                      _inputField(
                        controller: _bbController,
                        label: 'Berat Badan',
                        hint: 'Contoh: 65',
                        icon: Icons.monitor_weight_outlined,
                        satuan: 'kg',
                      ),

                      const SizedBox(height: 18),
                      _inputField(
                        controller: _tbController,
                        label: 'Tinggi Badan',
                        hint: 'Contoh: 170',
                        icon: Icons.height_rounded,
                        satuan: 'cm',
                      ),

                      if (_error != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          _error!,
                          style: const TextStyle(
                            color: Color(0xFFDC2626),
                            fontSize: 13,
                          ),
                        ),
                      ],

                      const SizedBox(height: 24),

                      // Tombol hitung
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: _hitungBMI,
                          icon: const Icon(Icons.calculate_outlined),
                          label: const Text(
                            'Hitung BMI',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4338CA),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Tombol reset
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
                          onPressed: _resetBMI,
                          icon: const Icon(Icons.refresh_rounded),
                          label: const Text(
                            'Reset',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF4338CA),
                            side: const BorderSide(
                              color: Color(0xFF4338CA),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // Kartu hasil BMI
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: _warnaHasil.withValues(alpha: 0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _warnaHasil.withValues(alpha: 0.08),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'HASIL PERHITUNGAN',
                        style: TextStyle(
                          fontSize: 13,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Icon(
                        _jenisKelamin == 'Laki-laki'
                            ? Icons.male_rounded
                            : Icons.female_rounded,
                        size: 38,
                        color: const Color(0xFF4338CA),
                      ),

                      Text(
                        'BMI $_jenisKelamin',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF475569),
                        ),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        _hasilBMI?.toStringAsFixed(1) ?? '--',
                        style: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                          color: _warnaHasil,
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: _warnaHasil.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          _keterangan,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: _warnaHasil,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 8),

                      const Text(
                        'Kategori BMI Dewasa',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 12),

                      _kategori(
                        'Kurang',
                        '< 18,5',
                        const Color(0xFF0284C7),
                      ),
                      _kategori(
                        'Normal',
                        '18,5 – 24,9',
                        const Color(0xFF16A34A),
                      ),
                      _kategori(
                        'Berlebih',
                        '25 – 29,9',
                        const Color(0xFFF59E0B),
                      ),
                      _kategori(
                        'Obesitas',
                        '≥ 30',
                        const Color(0xFFDC2626),
                      ),

                      const SizedBox(height: 12),
                      const Text(
                        'BMI merupakan alat skrining, bukan diagnosis medis. '
                        'Kategori ini menggunakan batas umum untuk orang dewasa.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                const Text(
                  'Jaga pola makan, rutin bergerak, dan terapkan gaya hidup sehat.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String satuan,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: const Color(0xFF4338CA),
            ),
            suffixText: satuan,
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _kategori(String nama, String rentang, Color warna) {
    final aktif = _hasilBMI != null &&
        ((nama == 'Kurang' && _hasilBMI! < 18.5) ||
            (nama == 'Normal' &&
                _hasilBMI! >= 18.5 &&
                _hasilBMI! < 25) ||
            (nama == 'Berlebih' &&
                _hasilBMI! >= 25 &&
                _hasilBMI! < 30) ||
            (nama == 'Obesitas' && _hasilBMI! >= 30));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(
            aktif ? Icons.check_circle : Icons.circle,
            color: warna,
            size: 17,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              nama,
              style: TextStyle(
                fontWeight: aktif ? FontWeight.bold : FontWeight.normal,
                color: const Color(0xFF334155),
              ),
            ),
          ),
          Text(
            rentang,
            style: TextStyle(
              fontWeight: aktif ? FontWeight.bold : FontWeight.normal,
              color: warna,
            ),
          ),
        ],
      ),
    );
  }
}
