import 'package:authentication_practice/common/layout/default_layout.dart';
import 'package:authentication_practice/product/component/product_card.dart';
import 'package:authentication_practice/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: CustomScrollView(
        slivers: [
          renderTop(),
          renderLabel(),
          renderProducts(),
        ],
      ),

      // Column(
      //   children: [
      //     RestaurantCard(
      //         image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
      //         name: '불타는 떡볶이',
      //         tags: ['떡볶이','맛있음','치즈'],
      //         ratingsCount: 100,
      //         deliveryFee: 30,
      //         deliveryTime: 3000,
      //         ratings: 4.76,
      //         isDetail: true,
      //       detail: '맛있는 떡볶이',
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //       child: ProductCard(),
      //     ),
      //   ],
      // ),
    );
  }

  SliverToBoxAdapter renderTop(){
    return SliverToBoxAdapter(
      child: RestaurantCard(
        image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
        name: '불타는 떡볶이',
        tags: ['떡볶이','맛있음','치즈'],
        ratingsCount: 100,
        deliveryFee: 30,
        deliveryTime: 3000,
        ratings: 4.76,
        isDetail: true,
        detail: '맛있는 떡볶이',
      ),
    );
  }

  SliverPadding renderLabel(){
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

  renderProducts(){
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index){
              return Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ProductCard(),
              );
            },
          childCount: 10,
        ),
      ),
    );
  }

}
