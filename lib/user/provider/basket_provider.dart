import 'package:authentication_practice/product/model/product_model.dart';
import 'package:authentication_practice/user/model/basket_item_model.dart';
import 'package:authentication_practice/user/model/patch_basket_body.dart';
import 'package:authentication_practice/user/repository/user_me_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final basketProvider =
    StateNotifierProvider<BasketProvider, List<BasketItemModel>>(
  (ref) {
    final repository = ref.watch(userMeRepositoryProvider);
    return BasketProvider(
      repository: repository,
    );
  },
);

//스크랩, 참여신청 모두 이로직이 들어감
class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  final UserMeRepository repository;
  BasketProvider({
    required this.repository,
  }) : super([]);

  //optimistic response 활용
  Future<void> patchBasket() async{
    await repository.patchBasket(
      body: PatchBasketBody(
        basket: state.map(
          (e) => PatchBasketBodyBasket(
            productId: e.product.id,
            count: e.count,
          ),
        ).toList(),
      ),
    );
  }

  Future<void> addToBasket({
    required ProductModel product,
  }) async {
    //요청을 먼저 보내고 응답이 오면 캐시를 업데이트(so far way)

    // 1) 아직 장바구니에 해당되는 상품이 없다면?
    // 장바구니에 상품 추가한다
    // 2) 만약에 이미 들어있다면
    // 장바구니에 있는 값에 +1 한다

    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if (exists) {
      state = state
          .map((e) => e.product.id == product.id
              ? e.copyWith(
                  count: e.count + 1,
                )
              : e)
          .toList();
    } else {
      //존재안한다면?
      state = [
        ...state,
        BasketItemModel(
          product: product,
          count: 1,
        ),
      ];
    }
    //Optimistic Response(긍정적 응답)
    //응답 성공할거라 가정하고 상태를 먼저 업데이트함
    await patchBasket(); //아래에 삭제를 햇을때도 넣자
  }

  Future<void> removeFromBasket({
    required ProductModel product,
    bool isDelete = false, // true면 count 관계없이 삭제한다
  }) async {
    // 1) 장바구니에 상품이 존재할때
    //   1) 상품의 카운트가 1보다 크면 -1한다
    //    2) 상품의 카운트가 1이면 삭제한다
    // 2) 상품이 존재하지 않을때
    //    즉시 함수를 반환하고 아무것도 하지 않는다.

    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if (!exists) {
      return;
    }

    final existingProduct = state.firstWhere((e) => e.product.id == product.id);

    if (existingProduct.count == 1 || isDelete) {
      state = state
          .where(
            (e) => e.product.id != product.id,
          )
          .toList();
    } else {
      state = state
          .map((e) =>
              e.product.id == product.id ? e.copyWith(count: e.count - 1) : e)
          .toList();
    }
    await patchBasket();
  }
}
