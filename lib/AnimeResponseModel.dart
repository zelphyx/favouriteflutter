// To parse this JSON data, do
//
//     final anime = animeFromJson(jsonString);

import 'dart:convert';

List<Anime> animeFromJson(String str) => List<Anime>.from(json.decode(str).map((x) => Anime.fromJson(x)));

String animeToJson(List<Anime> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Anime {
  String title;
  String episode;
  String year;
  String type;
  String genres;
  String plot;
  String embedUrl;
  String thumbnail;


  Anime({
    required this.title,
    required this.episode,
    required this.year,
    required this.type,
    required this.genres,
    required this.plot,
    required this.embedUrl,
    required this.thumbnail,
  });

  factory Anime.fromJson(Map<String, dynamic> json) => Anime(
    title: json["title"],
    episode: json["episode"],
    year: json["year"],
    type: json["type"],
    genres: json["genres"],
    plot: json["plot"],
    embedUrl: json["embed_url"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "episode": episode,
    "year": year,
    "type": type,
    "genres": genres,
    "plot": plot,
    "embed_url": embedUrl,
    "thumbnail": thumbnail,
  };
}
