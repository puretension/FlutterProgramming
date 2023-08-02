import 'package:authentication_practice/common/model/cursor_pagination_model.dart';
import 'package:authentication_practice/common/provider/pagination_provider.dart';
import 'package:authentication_practice/rating/model/rating_model.dart';
import 'package:authentication_practice/restaurant/repository/restaurant_rating_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantRatingProvider = StateNotifierProvider
    .family<RestaurantRatingStateNotifier,
CursorPaginationBase,String>((ref,id) {
  final repo = ref.watch(restaurantRatingRepositoryProvider(id));
  
  return RestaurantRatingStateNotifier(repository: repo);
});

// final restaurantRatingRepositoryProvider = Provider
//     .family<RestaurantRatingRepository,String>((ref,id){
//   final dio = ref.watch(dioProvider);
//
//   return RestaurantRatingRepository(dio,baseUrl: 'http://$ip/restaurant/$id/rating');
//
// });

class RestaurantRatingStateNotifier
    extends PaginationProvider<RatingModel,RestaurantRatingRepository> {
  RestaurantRatingStateNotifier({
    required super.repository,
});
}
