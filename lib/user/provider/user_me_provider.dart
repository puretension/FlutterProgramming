import 'package:authentication_practice/common/const/data.dart';
import 'package:authentication_practice/user/model/user_model.dart';
import 'package:authentication_practice/user/repository/auth_repository.dart';
import 'package:authentication_practice/user/repository/user_me_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//로그아웃 되었다면 null들어가게끔 UserModelBase?
class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final UserMeRepository repository;
  final FlutterSecureStorage storage;
  final AuthRepository authRepository;

  UserMeStateNotifier({
    required this.authRepository,
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    //내 정보 가져오기
    getMe();
  }

  getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    if (refreshToken == null || accessToken == null) {
      state = null; //토큰이 2중 1개라도 없다면 로그아웃
      return;
    }

    final resp = await repository.getMe();
    state = resp;
  }

  Future<UserModelBase>login({
    required String username,
    required String password,
}) async{
    try{
      state = UserModelLoading();

      final resp = await authRepository.login(
        username: username,
        password: password,
      );

      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);

      final userResp = await repository.getMe();

      state = userResp;

      return userResp;
    }catch(e){
      state = UserModelError(message: '로그인에 실패했습니다');

      return Future.value(state);
    }

  }
  Future<void> logout() async{
    state = null;
    //2가지 동시 실행
    Future.wait([
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY),
    ]);

  }
}
