import 'package:authentication_practice/common/view/root_tab.dart';
import 'package:authentication_practice/order/view/order_done_screen.dart';
import 'package:authentication_practice/restaurant/view/basket_screen.dart';
import 'package:authentication_practice/restaurant/view/restaurant_detail_screen.dart';
import 'package:authentication_practice/user/model/user_model.dart';
import 'package:authentication_practice/user/provider/user_me_provider.dart';
import 'package:authentication_practice/user/view/login_screen.dart';
import 'package:authentication_practice/common/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(
      userMeProvider,
      (previous, next) {
        if (previous != next) {
          notifyListeners();
        }
      },
    );
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, __) => RootTab(),
          routes: [
            GoRoute(
              path: 'restaurant/:rid',
              name: RestaurantDetailScreen.routeName,
              builder: (_, state) =>
                  RestaurantDetailScreen(id: state.pathParameters['rid']!),
              //restaurantScreen의 goNamed와 연결
            ),
          ],
        ),
        GoRoute(
          path: '/basket',
          name: BasketScreen.routeName,
          builder: (_, state) => BasketScreen(),
          //restaurantScreen의 goNamed와 연결
        ),
        GoRoute(
          path: '/order_done',
          name: OrderDoneScreen.routeName,
          builder: (_, state) => OrderDoneScreen(),
          //restaurantScreen의 goNamed와 연결
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, __) => SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, __) => LoginScreen(),
        ),
      ];

  logout() {
    ref.read(userMeProvider.notifier).logout();
    notifyListeners();
  }

  //SplashScreen
  //앱 처음 시작했을때 토큰 존재 확인하고
  //로그인 스크린으로 보내줄지 홈 스크린으로 보내줄지 확인 과정 필요
  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);
    final logginIn = state.path == '/login';

    //유저 정보 없는데 로그인중이면 그대로 로그인 페이지,
    // 만약 로그인중 아니면 로그인 페이지 이동
    if (user == null) {
      return logginIn ? null : '/login';
    }
    //user != null
    //UserModel
    //사용자 정보가 있는 상태면(유저정보를 가져왔는데)
    //로그인중이거나 현재위치가 SplashScreen이면?
    //홈으로 이동('/'이게 홈임)
    if (user is UserModel) {
      return logginIn || state.uri.toString() == '/splash' ? '/' : null;
    }
    if (user is UserModelError) {
      return !logginIn ? '/login' : null;
    }

    return null;
  }
}
