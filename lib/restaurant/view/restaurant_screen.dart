import 'dart:math';

import 'package:authentication_practice/common/const/data.dart';
import 'package:authentication_practice/common/dio/dio.dart';
import 'package:authentication_practice/restaurant/model/restaurant_detail_model.dart';
import 'package:authentication_practice/restaurant/model/restaurant_model.dart';
import 'package:authentication_practice/restaurant/repository/restaurant_repository.dart';
import 'package:authentication_practice/restaurant/view/restaurant_detail_screen.dart';
import 'package:authentication_practice/restaurant/component/restaurant_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> paginateRestaurant() async {
    final dio = Dio(); //detailScreen의 dio와 다름!!
    dio.interceptors.add(
      CustomInterceptor(storage: storage),
    );
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    //list로된 restaurant모델을 가져옴 이걸 그대로 리턴
    final resp =
    await RestaurantRepository
      (dio, baseUrl: 'http://$ip/restaurant').paginate();


    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FutureBuilder<List<RestaurantModel>>(
              future: paginateRestaurant(),
              builder: (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
                // print(snapshot.error);
                // print(snapshot.data);
                if (!snapshot.hasData) {
                  return Container();
                }
                return ListView.separated(
                    itemBuilder: (_, index) {
                      final pItem = snapshot.data![index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  RestaurantDetailScreen(id: pItem.id),
                            ),
                          );
                        },
                        child: RestaurantCard.fromModel(model: pItem),
                      );
                    },
                    separatorBuilder: (_, index) {
                      return SizedBox(
                        height: 16,
                      );
                    },
                    itemCount: snapshot.data!.length);
              },
            )),
      ),
    );
  }
}
