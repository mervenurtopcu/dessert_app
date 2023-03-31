import 'dart:ffi';

import 'package:equatable/equatable.dart';

import '../base/base_firebase_model.dart';

class Dessert extends Equatable with IdModel, BaseFirebaseModel<Dessert> {
  final String? name;
  final double? rating;
  final String? restaurant;
  final String? backgroundImage;
  final String? id;

  Dessert({
    this.name,
    this.rating,
    this.restaurant,
    this.backgroundImage,
    this.id,
  });

  @override
  List<Object?> get props => [name, rating, restaurant, backgroundImage, id];

  Dessert copyWith({
    String? name,
    double? rating,
    String? restaurant,
    String? backgroundImage,
    String? id,
  }) {
    return Dessert(
      name: name ?? this.name,
      rating: rating ?? this.rating,
      restaurant: restaurant ?? this.restaurant,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rating': rating,
      'restaurant': restaurant,
      'backgroundImage': backgroundImage,
      'id': id,
    };
  }

  @override
  Dessert fromJson(Map<String, dynamic> json) {
    return Dessert(
      name: json['name'] as String?,
      rating: json['rating'] as double?,
      restaurant: json['restaurant'] as String?,
      backgroundImage: json['backgroundImage'] as String?,
      id: json['id'] as String?,
    );
  }
}
