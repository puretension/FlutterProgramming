import 'package:authentication_practice/common/const/data.dart';
import 'package:authentication_practice/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange{
  expensive,
  medium,
  cheap,
}

@JsonSerializable()
class RestaurantModel{
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

  // //JsonKey를 annotate해준 thumburl넣기(static pathToUrl필수임)
  // static pathToUrl(String value){
  //   return 'http://$ip$value'; //이 반환값이 위의 thumbUrl에 저장됨
  // }

  //g.dart파일과 동일함
//   factory RestaurantModel.fromJson({
//     required Map<String,dynamic> json,
// }){
//     return RestaurantModel(
//       id: json['id'],
//       name: json['name'],
//       thumbUrl: 'http://$ip${json['thumbUrl']}',
//       tags: List<String>.from(json['tags']),
//       priceRange: RestaurantPriceRange.values.firstWhere(
//             (e) => e.name == json['priceRange'],
//       ),
//       ratings: json['ratings'],
//       ratingsCount: json['ratingsCount'],
//       deliveryTime: json['deliveryTime'],
//       deliveryFee: json['deliveryFee'],
//     );
//   }
}