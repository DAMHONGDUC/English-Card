class EnglishToday {
  String? id;
  String? noun;
  String? quote;
  String? author;
  String? noun_vi;
  bool isFavorite = false;

  EnglishToday({
    this.id,
    this.noun,
    this.quote,
    this.isFavorite = false,
    this.author,
    this.noun_vi,
  });
}
