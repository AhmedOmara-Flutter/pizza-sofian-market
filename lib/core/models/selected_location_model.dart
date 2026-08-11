import 'package:pizza_sofian_market/core/entities/selected_location_entity.dart';

class SelectedLocationModel extends SelectedLocationEntity {
  const SelectedLocationModel({
    required super.title,
    required super.subTitle,
    required super.cost,
  });

  factory SelectedLocationModel.fromJson(Map<String, dynamic> json) {
    return SelectedLocationModel(
      title: (json['title'] ?? '').toString(),
      subTitle: (json['subTitle'] ?? '').toString(),
      cost: (json['cost'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subTitle': subTitle,
      'cost': cost,
    };
  }

  factory SelectedLocationModel.fromEntity(SelectedLocationEntity entity) {
    return SelectedLocationModel(
      title: entity.title,
      subTitle: entity.subTitle,
      cost: entity.cost,
    );
  }

  SelectedLocationEntity toEntity() {
    return SelectedLocationEntity(
      title: title,
      subTitle: subTitle,
      cost: cost,
    );
  }
}