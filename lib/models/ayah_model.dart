class AyahModel {
  late int id;
  late String text;
  late String translation;

  AyahModel({
    required this.id,
    required this.text,
    required this.translation,
  });

  AyahModel.from(Map json) {
    id = json["id"];
    text = json["text"];
    translation = json["translation"];
  }
}
