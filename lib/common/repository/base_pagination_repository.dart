import 'package:authentication_practice/common/model/cursor_pagination_model.dart';
import 'package:authentication_practice/common/model/model_with_id.dart';
import 'package:authentication_practice/common/model/pagination_params.dart';
import 'package:authentication_practice/restaurant/model/restaurant_model.dart';

abstract class IBasePaginationRepository<T extends IModelWithId>{
  Future<CursorPagination<T>> paginate({
    //retrofit에서 쿼리 추가할때
      PaginationParams? paginationParams = const PaginationParams(),
  });
}