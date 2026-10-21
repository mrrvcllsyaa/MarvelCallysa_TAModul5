import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import '../pages/beranda_page.dart';
import '../pages/layanan_page.dart';
import '../pages/warga_page.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeks = 0;

  static const _judul = ['Beranda', 'Layanan', 'Warga'];

  final List<Widget> _halaman = const [
    BerandaPage(),
    LayananPage(),
    WargaPage(),
  ];

  void _pilihHalaman(int indeks) {
    setState(() => _indeks = indeks);
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final lebar = constraints.maxWidth;
        final layarLebar = lebar >= 700;

        final isi = Scaffold(
          appBar: AppBar(
            title: Text(_judul[_indeks]),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Center(
                  child: BlocSelector<PengajuanCubit, List<String>, int>(
                    selector: (state) => state.length,
                    builder: (context, total) => Tooltip(
                      message: 'Jumlah layanan dalam keranjang',
                      child: Badge(
                        isLabelVisible: total > 0,
                        label: Text('$total'),
                        child: const Icon(Icons.assignment_outlined, size: 26),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          drawer: Drawer(
            child: SafeArea(
              child: Column(
                children: [
                  const UserAccountsDrawerHeader(
                    accountName: Text('Nusantara Cerdas Mobile'),
                    accountEmail: Text('Layanan digital warga'),
                    currentAccountPicture: CircleAvatar(
                      child: Icon(Icons.location_city, size: 32),
                    ),
                  ),
                  _drawerItem(Icons.home_outlined, 'Beranda', 0),
                  _drawerItem(Icons.miscellaneous_services, 'Layanan', 1),
                  _drawerItem(Icons.people_alt_outlined, 'Warga', 2),
                ],
              ),
            ),
          ),
          body: IndexedStack(index: _indeks, children: _halaman),
          bottomNavigationBar: layarLebar
              ? null
              : NavigationBar(
                  selectedIndex: _indeks,
                  onDestinationSelected: _pilihHalaman,
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Beranda',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.miscellaneous_services_outlined),
                      selectedIcon: Icon(Icons.miscellaneous_services),
                      label: 'Layanan',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.people_alt_outlined),
                      selectedIcon: Icon(Icons.people),
                      label: 'Warga',
                    ),
                  ],
                ),
        );

        if (!layarLebar) return isi;

        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: _indeks,
                onDestinationSelected: _pilihHalaman,
                extended: lebar >= 1000,
                labelType: lebar >= 1000
                    ? NavigationRailLabelType.none
                    : NavigationRailLabelType.all,
                leading: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Icon(Icons.location_city, size: 32),
                ),
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: Text('Beranda'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.miscellaneous_services_outlined),
                    selectedIcon: Icon(Icons.miscellaneous_services),
                    label: Text('Layanan'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.people_alt_outlined),
                    selectedIcon: Icon(Icons.people),
                    label: Text('Warga'),
                  ),
                ],
              ),
              const VerticalDivider(width: 1),
              Expanded(child: isi),
            ],
          ),
        );
      },
    );
  }

  Widget _drawerItem(IconData icon, String label, int indeks) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      selected: _indeks == indeks,
      onTap: () => _pilihHalaman(indeks),
    );
  }
}
