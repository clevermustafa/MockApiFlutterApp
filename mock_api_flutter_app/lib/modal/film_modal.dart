class FilmModal {
  String? title;
  String? director;
  String? producer;
  FilmModal(this.title, this.director, this.producer);

  FilmModal.fromJson(Map<String, dynamic> data) {
    title = data["title"];
    director = data["director"];
    producer = data["producer"];
  }
}