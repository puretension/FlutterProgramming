import 'dart:convert';

import 'package:authentication_practice/common/const/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataUtils{
  //JsonKey를 annotate해준 thumburl넣기(static pathToUrl필수임)
  static String pathToUrl(String value){
    return 'http://$ip$value'; //이 반환값이 위의 thumbUrl에 저장됨
  }

  static List<String> listPathsToUrls(List paths){
    return paths.map((e) => pathToUrl(e)).toList();
  }

  static String plainToBase64(String plain){
    //일반 String코드 -> Base64 인코딩 (아래 2줄은 암기)
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(plain); //refresh token 받아오기위함
    return encoded;
  }
}