import 'package:equatable/equatable.dart';

class Citation extends Equatable {
  final String lawName;
  final String articleNumber;
  final String text;

  const Citation({
    required this.lawName,
    required this.articleNumber,
    required this.text,
  });

  factory Citation.fromJson(Map<String, dynamic> json) {
    return Citation(
      lawName: json['lawName'] as String? ?? '',
      articleNumber: json['articleNumber'] as String? ?? '',
      text: json['text'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lawName': lawName,
      'articleNumber': articleNumber,
      'text': text,
    };
  }

  @override
  List<Object?> get props => [lawName, articleNumber, text];
}
