import 'package:authentication_practice/common/utils/data_utils.dart';
import 'package:authentication_practice/user/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel{
  final String id;
  final UserModel user;
  final int rating;
  final String content;
  @JsonKey(
    fromJson: DataUtils.listPathsToUrls,
  )
  final List<String> imgUrls;


  RatingModel({
    required this.id,
    required this.user,
    required this.rating,
    required this.content,
    required this.imgUrls,
});
  
  factory RatingModel.fromJson(Map<String, dynamic> json)
  => _$RatingModelFromJson(json);

}