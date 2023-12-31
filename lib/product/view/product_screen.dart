import 'package:authentication_practice/common/component/pagination_list_view.dart';
import 'package:authentication_practice/product/component/product_card.dart';
import 'package:authentication_practice/product/model/product_model.dart';
import 'package:authentication_practice/product/provider/product_provider.dart';
import 'package:authentication_practice/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (_) => RestaurantDetailScreen(
            //       id: model.restaurant.id,
            //     ),
            //   ),
            // );
            print(model.restaurant.id);
            context.goNamed(
              RestaurantDetailScreen.routeName,
              pathParameters: {
                'rid': model.restaurant.id, // model.id아님!(상품이름이아니라 상품이잇는 가계이름 줘야함)
              },
            );
          },
          child: ProductCard.fromProductModel(
            model: model,
          ),
        );
      },
    );
  }
}
