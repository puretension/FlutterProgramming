import 'package:authentication_practice/common/const/data.dart';
import 'package:authentication_practice/common/dio/dio.dart';
import 'package:authentication_practice/common/model/cursor_pagination_model.dart';
import 'package:authentication_practice/common/model/pagination_params.dart';
import 'package:authentication_practice/common/repository/base_pagination_repository.dart';
import 'package:authentication_practice/rating/model/rating_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'restaurant_rating_repository.g.dart';

final restaurantRatingRepositoryProvider = Provider
    .family<RestaurantRatingRepository,String>((ref,id){
  final dio = ref.watch(dioProvider);
  
  return RestaurantRatingRepository(dio,baseUrl: 'http://$ip/restaurant/$id/rating');

});

// http://ip/restaurant/:rid/rating //rid를 family로 받아서 이 http사용가능
@RestApi()
abstract class RestaurantRatingRepository
    implements IBasePaginationRepository<RatingModel>{
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
_RestaurantRatingRepository;

  //restaurant_repository 복붙해서 타입만 RatingModel 변경해주면됨
  @GET('/') //일반 레스토랑용
  @Headers({
    'accessToken': 'true',
  })

  Future<CursorPagination<RatingModel>> paginate({
    //retrofit에서 쿼리 추가할때
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}