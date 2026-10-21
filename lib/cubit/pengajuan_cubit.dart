import 'package:flutter_bloc/flutter_bloc.dart';

class PengajuanCubit extends Cubit<List<String>> {
  PengajuanCubit() : super(const <String>[]);

  int get totalPengajuan => state.length;

  void tambah(String namaLayanan) {
    // Cegah layanan yang sama masuk dua kali ke keranjang.
    if (state.contains(namaLayanan)) return;
    emit([...state, namaLayanan]);
  }

  void hapus(String namaLayanan) {
    emit(state.where((nama) => nama != namaLayanan).toList());
  }

  void kosongkan() {
    emit(const <String>[]);
  }
}
