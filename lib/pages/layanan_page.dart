import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/favorit_cubit.dart';
import '../models/layanan.dart';
import 'detail_layanan_page.dart';

class LayananPage extends StatefulWidget {
  const LayananPage({super.key});

  @override
  State<LayananPage> createState() => _LayananPageState();
}

class _LayananPageState extends State<LayananPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  static const _bidang = ['Perizinan', 'Kesehatan', 'Transportasi'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _bidang.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Theme.of(context).colorScheme.surface,
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: _bidang.map((bidang) => Tab(text: bidang)).toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _bidang.map((bidang) {
              final layananBidang = daftarLayanan
                  .where((layanan) => layanan.bidang == bidang)
                  .toList();

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: layananBidang.length,
                itemBuilder: (context, index) {
                  final layanan = layananBidang[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(_ikonBidang(bidang)),
                      ),
                      title: Text(
                        layanan.nama,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(layanan.deskripsi, maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      trailing: BlocBuilder<FavoritCubit, Set<String>>(
                        builder: (context, favorit) {
                          final ditandai = favorit.contains(layanan.nama);
                          return IconButton(
                            tooltip: ditandai
                                ? 'Batalkan favorit'
                                : 'Tandai favorit',
                            onPressed: () => context
                                .read<FavoritCubit>()
                                .toggle(layanan.nama),
                            icon: Icon(
                              ditandai ? Icons.star : Icons.star_border,
                              color: ditandai ? Colors.amber.shade700 : null,
                            ),
                          );
                        },
                      ),
                      onTap: () => Navigator.pushNamed(
                        context,
                        DetailLayananPage.routeName,
                        arguments: layanan,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  IconData _ikonBidang(String bidang) {
    switch (bidang) {
      case 'Perizinan':
        return Icons.assignment_outlined;
      case 'Kesehatan':
        return Icons.health_and_safety_outlined;
      default:
        return Icons.directions_bus_outlined;
    }
  }
}
