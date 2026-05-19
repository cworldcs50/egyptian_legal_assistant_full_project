class LegalSourceModel {
  final String name;
  final bool loaded;
  final String filename;

  const LegalSourceModel({
    required this.name,
    required this.loaded,
    required this.filename,
  });

  factory LegalSourceModel.fromJson(Map<String, dynamic> json) {
    return LegalSourceModel(
      name: json['name'] ?? '',
      loaded: json['loaded'] ?? false,
      filename: json['filename'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'filename': filename, 'loaded': loaded};
  }
}
