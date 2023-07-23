import 'package:authentication_practice/common/const/data.dart';
import 'package:authentication_practice/common/dio/dio.dart';
import 'package:authentication_practice/common/layout/default_layout.dart';
import 'package:authentication_practice/restaurant/model/restaurant_detail_model.dart';
import 'package:authentication_practice/restaurant/model/restaurant_model.dart';
import 'package:authentication_practice/product/component/product_card.dart';
import 'package:authentication_practice/restaurant/component/restaurant_card.dart';
import 'package:authentication_practice/restaurant/repository/restaurant_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String id;
  const RestaurantDetailScreen({required this.id, super.key});

  // Future<RestaurantDetailModel> getRestaurantDetail(WidgetRef ref) async {
  //   // final dio = Dio();
  //   // dio.interceptors.add(
  //   //   CustomInterceptor(
  //   //     storage: storage,
  //   //   ),
  //   // );
  //
  //   // final dio = ref.watch(dioProvider);
  //   // final repository =
  //   //     RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');
  //   // return repository.getRestaurantDetail(id: id);
  //   //코드 축약
  //   return ref.watch(restaurantRepositoryProvider).getRestaurantDetail(id: id);
  // }
  // final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
  // final resp = await dio.get(
  //   'http://$ip/restaurant/$id',
  //   options: Options(
  //     headers: {
  //       'authorization': 'Bearer $accessToken',
  //     },
  //   ),
  // );
  // return resp.data;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: FutureBuilder<RestaurantDetailModel>(
        future: ref.watch(restaurantRepositoryProvider).getRestaurantDetail(id: id),
        builder: (_, AsyncSnapshot<RestaurantDetailModel> snapshot) {
          //print(snapshot.data);
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return CustomScrollView(
            slivers: [
              renderTop(
                model: snapshot.data!,
              ),
              renderLabel(),
              renderProducts(products: snapshot.data!.products),
            ],
          );
        },
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantDetailModel model,
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
              child: ProductCard.fromModel(model: model),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
