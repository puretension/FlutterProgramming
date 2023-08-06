import 'package:authentication_practice/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

abstract class CursorPaginationBase {}
//cursorPagination is CursorPaginationBase

//1
class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({
    required this.message,
  });
}

//2
class CursorPaginationLoading extends CursorPaginationBase {}

//data is CursorPaginationLoading

@JsonSerializable(
  genericArgumentFactories: true,
)
//3   genericArgumentFactories: //제네릭 타입쓸거면 필수
class CursorPagination<T> extends CursorPaginationBase {
  final CursorPaginationMeta meta;
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

  CursorPagination copyWith({
    CursorPaginationMeta? meta,
    List<T>? data,
  }) {
    return CursorPagination<T>(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }
  //T Function(Object? json) fromJsonT   이게 제네릭타입추가로 생긴코드이며 Runtime에 암시해주기위함
  //BuildTime에 알지못하는 T값을 Json으로부터 인스턴스화하는 방법을 주입 해주기 위함
  // factory CursorPagination.fromJson(
  //         Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
  //     _$CursorPaginationFromJson(json, fromJsonT);
  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

//4
@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
  });

  CursorPaginationMeta copyWith({
    int? count,
    bool? hasMore,
  }) {
    return CursorPaginationMeta(
      count: count ?? this.count,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}

//데이터가 있는데 새로고침 할때
//CursorPagination 은 CursorPaginationBase 까지 상속함
// instance is CursorPagination    true
// instance is CursorPaginationBase   true
class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({
    required super.meta,
    required super.data,
  });
}

//5
//리스트의 맨 아래로 내려서 추가데이터 요청시
class CursorPaginationFetchingMore<T> extends CursorPagination<T> {
  CursorPaginationFetchingMore({
    required super.meta,
    required super.data,
  });
}
