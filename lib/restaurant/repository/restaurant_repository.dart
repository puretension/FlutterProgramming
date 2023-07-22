import 'package:authentication_practice/common/model/cursor_pagination_model.dart';
import 'package:authentication_practice/restaurant/model/restaurant_detail_model.dart';
import 'package:authentication_practice/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // 'http://$ip/restaurant/'
  @GET('/') //일반 레스토랑용
  @Headers({
    'accessToken': 'true',
  })

  Future<CursorPagination<RestaurantModel>> paginate();

  // 'http://$ip/restaurant/:id'
  @GET('/{id}') //Detailrestaurant용
  //@Headers는 강제 삽입
  @Headers({
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
