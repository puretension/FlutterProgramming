import 'package:authentication_practice/common/const/data.dart';
import 'package:authentication_practice/common/model/model_with_id.dart';
import 'package:authentication_practice/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange{
  expensive,
  medium,
  cheap,
}

@JsonSerializable()
class RestaurantModel implements IModelWithId{
  final String id;
  final String name;
  //수정필요한 곳에 JsonKey후 아래의 PathUrl필수
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
});

  //json으로부터 instance를 만드는것
  factory RestaurantModel.fromJson(Map<String,dynamic>json)
   => _$RestaurantModelFromJson(json);

  //instance를 json으로 변환하는것
  Map<String,dynamic> toJson() => _$RestaurantModelToJson(this);

}