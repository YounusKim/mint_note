import 'dart:convert';

class Genre {
  final String genreId;
  final String genreName;

  Genre({required this.genreId, required this.genreName});

  Map<String, dynamic> toMap() {
    return {'genreId': genreId, 'genreName': genreName};
  }

  factory Genre.fromMap(Map<String, dynamic> map) {
    return Genre(
      genreId: map['genreId'] ?? '',
      genreName: map['genreName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Genre.fromJson(String source) => Genre.fromMap(json.decode(source));
}
