import 'package:authentication_practice/common/const/data.dart';
import 'package:authentication_practice/common/dio/dio.dart';
import 'package:authentication_practice/common/model/cursor_pagination_model.dart';
import 'package:authentication_practice/common/model/pagination_params.dart';
import 'package:authentication_practice/common/repository/base_pagination_repository.dart';
import 'package:authentication_practice/restaurant/model/restaurant_detail_model.dart';
import 'package:authentication_practice/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
        RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');
    return repository;
  },
);

@RestApi()
abstract class RestaurantRepository implements
    IBasePaginationRepository<RestaurantModel> {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // 'http://$ip/restaurant/'
  @GET('/') //일반 레스토랑용
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate({
    //retrofit에서 쿼리 추가할때
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

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
