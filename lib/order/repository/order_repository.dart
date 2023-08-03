

import 'package:authentication_practice/common/const/data.dart';
import 'package:authentication_practice/common/dio/dio.dart';
import 'package:authentication_practice/common/model/cursor_pagination_model.dart';
import 'package:authentication_practice/common/model/pagination_params.dart';
import 'package:authentication_practice/common/repository/base_pagination_repository.dart';
import 'package:authentication_practice/order/model/order_model.dart';
import 'package:authentication_practice/order/model/post_order_body.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_repository.g.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref){
  final dio = ref.watch(dioProvider);
  
  return OrderRepository(dio, baseUrl: 'http://$ip/order');
});


@RestApi()
abstract class OrderRepository implements IBasePaginationRepository<OrderModel>{
  factory OrderRepository(Dio dio, {String baseUrl}) = _OrderRepository;

  @GET('/')
  @Headers({
    'accessToken' : 'true',
  })
  Future<CursorPagination<OrderModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
});
  
  @POST('/')
  @Headers({
    'accessToken' : 'true'
  })
  Future<OrderModel> postOrder({
    @Body() required PostOrderBody body
});
}