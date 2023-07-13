class PkbuRequest {
  final String kode_pembina;
  final String kode_kantor;
  final String pageNumber;
  final List filter_search_company;
  final List order_search_company;
  final String pageSize;

  PkbuRequest({
    required this.kode_pembina,
    required this.kode_kantor,
    required this.pageNumber,
    required this.filter_search_company,
    required this.order_search_company,
    required this.pageSize,
  });

  Map<String, dynamic> toJson() => <String, dynamic> {
    'kode_pembina': this.kode_pembina,
    'kode_kantor': this.kode_kantor,
    'pageNumber': this.pageNumber,
    'filter_search_company': this.filter_search_company,
    'order_search_company': this.order_search_company,
    'pageSize': this.pageSize,
  };
}