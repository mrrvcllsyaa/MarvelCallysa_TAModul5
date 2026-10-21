import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/favorit_cubit.dart';
import 'cubit/pengajuan_cubit.dart';
import 'navigation/kerangka_navigasi.dart';
import 'pages/detail_layanan_page.dart';
import 'models/layanan.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FavoritCubit()),
        BlocProvider(create: (_) => PengajuanCubit()),
      ],
      child: const NusantaraCerdasApp(),
    ),
  );
}

class NusantaraCerdasApp extends StatelessWidget {
  const NusantaraCerdasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nusantara Cerdas Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF176B87)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F8FA),
      ),
      onGenerateRoute: (settings) {
        if (settings.name == DetailLayananPage.routeName) {
          final layanan = settings.arguments as Layanan;
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (_) => DetailLayananPage(layanan: layanan),
          );
        }
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const KerangkaNavigasi(),
        );
      },
      home: const KerangkaNavigasi(),
    );
  }
}
