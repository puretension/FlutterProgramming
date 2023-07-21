import 'package:authentication_practice/common/const/data.dart';

class DataUtils{
  //JsonKey를 annotate해준 thumburl넣기(static pathToUrl필수임)
  static pathToUrl(String value){
    return 'http://$ip$value'; //이 반환값이 위의 thumbUrl에 저장됨
  }
}