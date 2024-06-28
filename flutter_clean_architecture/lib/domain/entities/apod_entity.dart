import 'package:equatable/equatable.dart';

class ApodEntity extends Equatable {
  final String? copyright;
  final DateTime? date;
  final String? explanation;
  final String? hdurl;
  final String? mediaType;
  final String? serviceVersion;
  final String? thumbnailUrl;
  final String? title;
  final String? url;

  const ApodEntity({
    this.copyright,
    this.date,
    this.explanation,
    this.hdurl,
    this.mediaType,
    this.serviceVersion,
    this.thumbnailUrl,
    this.title,
    this.url,
  });

  @override
  List<Object?> get props => [
        copyright,
        explanation,
        hdurl,
        mediaType,
        serviceVersion,
        thumbnailUrl,
        title,
        url,
      ];
}
