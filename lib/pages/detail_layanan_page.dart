import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import '../models/layanan.dart';

class DetailLayananPage extends StatefulWidget {
  const DetailLayananPage({super.key, required this.layanan});

  static const routeName = '/detail-layanan';

  final Layanan layanan;

  @override
  State<DetailLayananPage> createState() => _DetailLayananPageState();
}

class _DetailLayananPageState extends State<DetailLayananPage> {
  bool _sedangMengirim = false;

  Future<void> _ajukanPermohonan() async {
    if (_sedangMengirim) return;

    setState(() => _sedangMengirim = true);

    // Simulasi proses pengiriman singkat. Ganti dengan proses API
    // jika backend sudah tersedia.
    await Future<void>.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    context.read<PengajuanCubit>().tambah(widget.layanan.nama);

    setState(() => _sedangMengirim = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.layanan.nama} ditambahkan ke pengajuan.'),
      ),
    );

    // Tetap mengirim nilai balik melalui Navigator.pop seperti ketentuan.
    Navigator.pop(context, widget.layanan.nama);
  }

  @override
  Widget build(BuildContext context) {
    final layanan = widget.layanan;

    return Scaffold(
      appBar: AppBar(title: const Text('Rincian Layanan')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: const Icon(Icons.description_outlined, size: 38),
          ),
          const SizedBox(height: 20),
          Text(
            layanan.nama,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Chip(
            avatar: const Icon(Icons.category_outlined, size: 18),
            label: Text(layanan.bidang),
          ),
          const SizedBox(height: 16),
          Text(layanan.deskripsi),
          const SizedBox(height: 24),
          Text(
            'Persyaratan',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          ...layanan.persyaratan.map(
            (syarat) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.check_circle_outline),
              title: Text(syarat),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _sedangMengirim ? null : _ajukanPermohonan,
            icon: _sedangMengirim
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.send_outlined),
            label: Text(
              _sedangMengirim
                  ? 'Sedang mengirim...'
                  : 'Ajukan Permohonan',
            ),
          ),
        ],
      ),
    );
  }
}
