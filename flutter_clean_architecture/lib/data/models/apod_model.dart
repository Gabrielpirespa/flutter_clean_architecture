import 'dart:convert';

import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';

class ApodModel extends ApodEntity {
  const ApodModel({
    super.copyright,
    super.date,
    super.explanation,
    super.hdurl,
    super.mediaType,
    super.serviceVersion,
    super.thumbnailUrl,
    super.title,
    super.url,
  });

  factory ApodModel.fromEntity(ApodEntity apodEntity) => ApodModel(
      copyright: apodEntity.copyright,
      date: apodEntity.date,
      explanation: apodEntity.explanation,
      hdurl: apodEntity.hdurl,
      mediaType: apodEntity.mediaType,
      serviceVersion: apodEntity.serviceVersion,
      thumbnailUrl: apodEntity.thumbnailUrl,
      title: apodEntity.title,
      url: apodEntity.url);

  factory ApodModel.fromJson(Map<String, dynamic> map) => ApodModel(
        copyright: map["copyright"] ?? "Nasa APOD",
        date: DateTime.parse(map["date"]),
        explanation: map["explanation"],
        hdurl: map["hdurl"],
        mediaType: map["mediaType"],
        serviceVersion: map["serviceVersion"],
        thumbnailUrl: map["thumbnailUrl"],
        title: map["title"],
        url: map["url"],
      );

  Map<String, dynamic> toMap() => {
        "copyright": copyright,
        "date": date.toString(),
        "explanation": explanation,
        "hdurl": hdurl,
        "mediaType": mediaType,
        "serviceVersion": serviceVersion,
        "thumbnailUrl": thumbnailUrl,
        "title": title,
        "url": url,
      };

  String toJson() => json.encode(toMap());
}
