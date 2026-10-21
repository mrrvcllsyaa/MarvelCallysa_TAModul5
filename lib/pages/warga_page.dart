import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../models/layanan.dart';
import 'detail_layanan_page.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Layanan Favorit',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, favorit) {
            final daftarFavorit = daftarLayanan
                .where((layanan) => favorit.contains(layanan.nama))
                .toList();

            if (daftarFavorit.isEmpty) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    'Belum ada layanan favorit. Buka menu Layanan dan '
                    'tekan ikon bintang pada layanan yang ingin disimpan.',
                  ),
                ),
              );
            }

            return Column(
              children: daftarFavorit.map((layanan) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.star, color: Colors.amber),
                    title: Text(layanan.nama),
                    subtitle: Text(layanan.bidang),
                    trailing: IconButton(
                      tooltip: 'Batalkan favorit',
                      icon: const Icon(Icons.star_border),
                      onPressed: () => context
                          .read<FavoritCubit>()
                          .batalTandai(layanan.nama),
                    ),
                    onTap: () => Navigator.pushNamed(
                      context,
                      DetailLayananPage.routeName,
                      arguments: layanan,
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Keranjang Pengajuan',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
            ),
            BlocSelector<PengajuanCubit, List<String>, int>(
              selector: (state) => state.length,
              builder: (context, total) => Chip(
                avatar: const Icon(Icons.shopping_bag_outlined, size: 18),
                label: Text('$total layanan'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        BlocBuilder<PengajuanCubit, List<String>>(
          builder: (context, pengajuan) {
            if (pengajuan.isEmpty) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    'Keranjang pengajuan masih kosong. Buka rincian layanan '
                    'dan tekan Ajukan Permohonan untuk menambahkannya.',
                  ),
                ),
              );
            }

            return Column(
              children: [
                ...pengajuan.map((nama) {
                  final layanan = daftarLayanan.firstWhere(
                    (item) => item.nama == nama,
                    orElse: () => Layanan(
                      nama: nama,
                      bidang: 'Layanan',
                      deskripsi: '',
                      persyaratan: const [],
                    ),
                  );
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.assignment_turned_in_outlined),
                      title: Text(nama),
                      subtitle: Text(layanan.bidang),
                      trailing: IconButton(
                        tooltip: 'Hapus dari pengajuan',
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () =>
                            context.read<PengajuanCubit>().hapus(nama),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () => context.read<PengajuanCubit>().kosongkan(),
                  icon: const Icon(Icons.delete_sweep_outlined),
                  label: const Text('Kosongkan Keranjang'),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Purwarupa ini menyimpan daftar pengajuan secara lokal; '
                  'belum mengirim data ke server dinas.',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
