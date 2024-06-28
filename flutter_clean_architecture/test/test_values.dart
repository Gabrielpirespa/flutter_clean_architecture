import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/data/models/apod_model.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';

ApodEntity testApodEntity = ApodEntity(
  copyright: "Stefan Seip",
  date: DateTime.parse("2004-09-27"),
  explanation: "The Great Nebula in Orion is a colorful place.",
  hdurl: "https://apod.nasa.gov/apod/image/0409/orion_seip_big.jpg",
  mediaType: "image",
  serviceVersion: "v1",
  thumbnailUrl: "https://apod.nasa.gov/apod/image/0409/orion_seip.jpg",
  title: "The Great Nebula in Orion",
  url: "https://apod.nasa.gov/apod/image/0409/orion_seip.jpg",
);

List<ApodEntity> testListApodEntity = [
  ApodEntity(
    copyright: "Stefan Seip",
    date: DateTime.parse("2004-09-27"),
    explanation: "The Great Nebula in Orion is a colorful place.",
    hdurl: "https://apod.nasa.gov/apod/image/0409/orion_seip_big.jpg",
    mediaType: "image",
    serviceVersion: "v1",
    thumbnailUrl: "https://apod.nasa.gov/apod/image/0409/orion_seip.jpg",
    title: "The Great Nebula in Orion",
    url: "https://apod.nasa.gov/apod/image/0409/orion_seip.jpg",
  ),
  ApodEntity(
    copyright: "Stefan Seip",
    date: DateTime.parse("2004-09-27"),
    explanation: "The Great Nebula in Orion is a colorful place.",
    hdurl: "https://apod.nasa.gov/apod/image/0409/orion_seip_big.jpg",
    mediaType: "image",
    serviceVersion: "v1",
    thumbnailUrl: "https://apod.nasa.gov/apod/image/0409/orion_seip.jpg",
    title: "The Great Nebula in Orion",
    url: "https://apod.nasa.gov/apod/image/0409/orion_seip.jpg",
  ),
  ApodEntity(
    copyright: "Stefan Seip",
    date: DateTime.parse("2004-09-27"),
    explanation: "The Great Nebula in Orion is a colorful place.",
    hdurl: "https://apod.nasa.gov/apod/image/0409/orion_seip_big.jpg",
    mediaType: "image",
    serviceVersion: "v1",
    thumbnailUrl: "https://apod.nasa.gov/apod/image/0409/orion_seip.jpg",
    title: "The Great Nebula in Orion",
    url: "https://apod.nasa.gov/apod/image/0409/orion_seip.jpg",
  )
];

ApodModel testApodModel = ApodModel(
  copyright: "Stefan Seip",
  date: DateTime.parse("2004-09-27"),
  explanation: "The Great Nebula in Orion is a colorful place.",
  hdurl: "https://apod.nasa.gov/apod/image/0409/orion_seip_big.jpg",
  mediaType: "image",
  serviceVersion: "v1",
  thumbnailUrl: "https://apod.nasa.gov/apod/image/0409/orion_seip.jpg",
  title: "The Great Nebula in Orion",
  url: "https://apod.nasa.gov/apod/image/0409/orion_seip.jpg",
);

List<ApodModel> testListApodModel = [
  ApodModel(
    copyright: "Stefan Seip",
    date: DateTime.parse("2004-09-27"),
    explanation: "The Great Nebula in Orion is a colorful place.",
    hdurl: "https://apod.nasa.gov/apod/image/0409/orion_seip_big.jpg",
    mediaType: "image",
    serviceVersion: "v1",
    thumbnailUrl: "https://apod.nasa.gov/apod/image/0409/orion_seip.jpg",
    title: "The Great Nebula in Orion",
    url: "https://apod.nasa.gov/apod/image/0409/orion_seip.jpg",
  ),
  ApodModel(
    copyright: "Stefan Seip",
    date: DateTime.parse("2004-09-27"),
    explanation: "The Great Nebula in Orion is a colorful place.",
    hdurl: "https://apod.nasa.gov/apod/image/0409/orion_seip_big.jpg",
    mediaType: "image",
    serviceVersion: "v1",
    thumbnailUrl: "https://apod.nasa.gov/apod/image/0409/orion_seip.jpg",
    title: "The Great Nebula in Orion",
    url: "https://apod.nasa.gov/apod/image/0409/orion_seip.jpg",
  ),
  ApodModel(
    copyright: "Stefan Seip",
    date: DateTime.parse("2004-09-27"),
    explanation: "The Great Nebula in Orion is a colorful place.",
    hdurl: "https://apod.nasa.gov/apod/image/0409/orion_seip_big.jpg",
    mediaType: "image",
    serviceVersion: "v1",
    thumbnailUrl: "https://apod.nasa.gov/apod/image/0409/orion_seip.jpg",
    title: "The Great Nebula in Orion",
    url: "https://apod.nasa.gov/apod/image/0409/orion_seip.jpg",
  ),
];

List<String> testHistoryList = [
  "2004-09-27",
  "2004-09-27/2004-09-27",
  "2004-09-27",
];

Failure testNoConnection = NoConnectionFailure();
