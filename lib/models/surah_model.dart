class SurahModel {
  late int id;
  late String name;
  late String transliteration;
  late String translation;
  late String type;
  late int verses;

  SurahModel({
    required this.id,
    required this.name,
    required this.transliteration,
    required this.translation,
    required this.type,
    required this.verses,
  });

  SurahModel.fromJson(Map json) {
    id = json["id"];
    name = json["name"];
    transliteration = json["transliteration"];
    translation = json["translation"];
    type = json["type"];
    verses = json["total_verses"];
  }
}
