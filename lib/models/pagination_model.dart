class Pagination {
  final int? currentPage;
  final int? lastPage;
  final int? perPage;

  Pagination({
    this.currentPage,
    this.lastPage,
    this.perPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
      );
}
