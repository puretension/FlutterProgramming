import 'package:authentication_practice/common/const/data.dart';
import 'package:authentication_practice/common/dio/dio.dart';
import 'package:authentication_practice/common/layout/default_layout.dart';
import 'package:authentication_practice/common/model/cursor_pagination_model.dart';
import 'package:authentication_practice/common/utils/pagination_utils.dart';
import 'package:authentication_practice/rating/component/rating_card.dart';
import 'package:authentication_practice/rating/model/rating_model.dart';
import 'package:authentication_practice/restaurant/model/restaurant_detail_model.dart';
import 'package:authentication_practice/restaurant/model/restaurant_model.dart';
import 'package:authentication_practice/product/component/product_card.dart';
import 'package:authentication_practice/restaurant/component/restaurant_card.dart';
import 'package:authentication_practice/restaurant/provider/restaurant_provider.dart';
import 'package:authentication_practice/restaurant/provider/restaurant_rating_provider.dart';
import 'package:authentication_practice/restaurant/repository/restaurant_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'restaurantDetail';
  final String id;
  const RestaurantDetailScreen({required this.id, super.key});

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  // Future<RestaurantDetailModel> getRestaurantDetail(WidgetRef ref) async {

  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
  }

  void listener() {
    PaginationUtils.paginate(
      controller: controller,
      provider: ref.read(restaurantRatingProvider(widget.id).notifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingsState = ref.watch(restaurantRatingProvider(widget.id));

    print(ratingsState);

    if (state == null) {
      return DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
        title: '불타는 떡볶이',
        child: CustomScrollView(
          controller: controller,
          slivers: [
            renderTop(
              model: state,
            ),
            if (state is! RestaurantDetailModel) renderLoading(),
            if (state is RestaurantDetailModel) renderLabel(),
            if (state is RestaurantDetailModel)
              renderProducts(products: state.products),
            if (ratingsState is CursorPagination<RatingModel>)
              renderRatings(
                models: ratingsState.data,
              ),
          ],
        ));
  }

  SliverPadding renderRatings({
    required List<RatingModel> models,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: RatingCard.fromModel(
              model: models[index],
            ),
          ),
          childCount: models.length,
        ),
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  lines: 5,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  SliverPadding renderProducts({
    required List<RestaurantProductModel> products,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];

            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ProductCard.fromRestaurantProductModel(model: model),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
