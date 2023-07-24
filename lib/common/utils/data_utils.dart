import 'package:authentication_practice/common/const/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataUtils{
  //JsonKey를 annotate해준 thumburl넣기(static pathToUrl필수임)
  static String pathToUrl(String value){
    return 'http://$ip$value'; //이 반환값이 위의 thumbUrl에 저장됨
  }

  static List<String> listPathsToUrls(List<String>paths){
    return paths.map((e) => pathToUrl(e)).toList();
  }
}