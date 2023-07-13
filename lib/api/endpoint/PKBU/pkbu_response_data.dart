class PkbuResponseData {
  final String npp;
  final String namaPerusahaan;
  final String nominalPiutang;
  final String kodePerusahaan;
  final String kodeKepesertaan;
  final String kodeKabupaten;
  final String blthItrfx;
  final String umurPiutang;
  final String nominalDenda;
  final String kode_iuran;
  final String kode_tagihan;
  final String kode_kantor;
  final String kode_divisi;
  final String tgl_spi;

  PkbuResponseData({
    required this.npp,
    required this.namaPerusahaan,
    required this.nominalPiutang,
    required this.kodePerusahaan,
    required this.kodeKepesertaan,
    required this.kodeKabupaten,
    required this.blthItrfx,
    required this.umurPiutang,
    required this.nominalDenda,
    required this.kode_iuran,
    required this.kode_tagihan,
    required this.kode_kantor,
    required this.kode_divisi,
    required this.tgl_spi,
  });

  factory PkbuResponseData.fromJson(Map<String, dynamic> json) => PkbuResponseData(
    npp: json['npp'],
    namaPerusahaan: json['namaPerusahaan'],
    nominalPiutang: json['nominalPiutang'],
    kodePerusahaan: json['kodePerusahaan'],
    kodeKepesertaan: json['kodeKepesertaan'],
    kodeKabupaten: json['kodeKabupaten'],
    blthItrfx: json['blthItrfx'],
    umurPiutang: json['umurPiutang'],
    nominalDenda: json['nominalDenda'],
    kode_iuran: json['kode_iuran'],
    kode_tagihan: json['kode_tagihan'],
    kode_kantor: json['kode_kantor'],
    kode_divisi: json['kode_divisi'],
    tgl_spi: json['tgl_spi'],
  );
}