class Layanan {
  const Layanan({
    required this.nama,
    required this.bidang,
    required this.deskripsi,
    required this.persyaratan,
  });

  final String nama;
  final String bidang;
  final String deskripsi;
  final List<String> persyaratan;
}

const List<Layanan> daftarLayanan = [
  Layanan(
    nama: 'Pembuatan KTP Elektronik',
    bidang: 'Perizinan',
    deskripsi: 'Layanan pengajuan pembuatan KTP elektronik bagi warga yang memenuhi ketentuan.',
    persyaratan: ['Kartu Keluarga', 'Surat pengantar jika diperlukan'],
  ),
  Layanan(
    nama: 'Perpanjangan Kartu Keluarga',
    bidang: 'Perizinan',
    deskripsi: 'Layanan perubahan atau pembaruan data pada Kartu Keluarga.',
    persyaratan: ['Kartu Keluarga lama', 'Dokumen pendukung perubahan data'],
  ),
  Layanan(
    nama: 'Pendaftaran Layanan Puskesmas',
    bidang: 'Kesehatan',
    deskripsi: 'Layanan pengajuan pendaftaran kunjungan ke fasilitas kesehatan.',
    persyaratan: ['Identitas diri', 'Kartu jaminan kesehatan jika tersedia'],
  ),
  Layanan(
    nama: 'Konsultasi Kesehatan Warga',
    bidang: 'Kesehatan',
    deskripsi: 'Layanan permohonan konsultasi awal dengan petugas kesehatan.',
    persyaratan: ['Identitas diri', 'Ringkasan keluhan kesehatan'],
  ),
  Layanan(
    nama: 'Pengaduan Transportasi Umum',
    bidang: 'Transportasi',
    deskripsi: 'Layanan penyampaian laporan atau pengaduan terkait transportasi umum.',
    persyaratan: ['Lokasi kejadian', 'Keterangan pengaduan'],
  ),
  Layanan(
    nama: 'Permohonan Informasi Rute',
    bidang: 'Transportasi',
    deskripsi: 'Layanan permintaan informasi rute dan fasilitas transportasi.',
    persyaratan: ['Rute atau lokasi yang ingin diketahui'],
  ),
];
