import 'legal_source_model.dart';

class SourcesResponse {
  final List<LegalSourceModel> sources;

  SourcesResponse({required this.sources});

  factory SourcesResponse.fromJson(Map<String, dynamic> json) {
    return SourcesResponse(
      sources:
          (json['SOURCES'] as List)
              .map((e) => LegalSourceModel.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'SOURCES': sources.map((e) => e.toJson()).toList()};
  }
}
