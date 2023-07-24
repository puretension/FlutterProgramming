import 'package:authentication_practice/common/model/cursor_pagination_model.dart';
import 'package:authentication_practice/common/model/model_with_id.dart';
import 'package:authentication_practice/common/model/pagination_params.dart';
import 'package:authentication_practice/common/repository/base_pagination_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//pagination 일반화 시작
class PaginationProvider<
T extends IModelWithId,
U extends IBasePaginationRepository<T>
> extends StateNotifier<CursorPaginationBase> {
  final U repository;

  PaginationProvider({
    required this.repository,
  }) : super(CursorPaginationLoading()){
    paginate();
  }

      Future<void> paginate({
      int fetchCount = 20,
      //추가로 데이터 더 가져오기
      //true - 추가로 데이터 더 가져옴
      //false - 새로고침(현재 상태 덮어씌움)
      bool fetchMore = false,
      //강제로 다시 로딩하기
      //true - CursorPaginationLoading()
      bool forceRefetch = false,
    }) async {
      try {
        // final resp = await repository.paginate(); //20개 가져오고
        // state = resp;

        //5가지의 가능성
        //State의 상태
        //[상태가]
        //1) CursorPagination - 정상적으로 데이터가 있는 상태
        //2) CursorPaginationLoading - 데이터가 로딩중인 상태
        //3) CursorPaginationError - 에러가 있는 상태
        //4) CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터 가져올때
        //5) CursorPaginationFetchMore - 추가데이터를 paginate 해오라는 요청을 받았을때

        // 바로 반환하는 상황
        // 1) hasMore == false(기존 상태에서 이미 다음 데이터가 없다는 값을 들고 있다면?)
        // 2) 로딩중 - fetchMore: true
        // fetchMore 아닐때 - 새로고침 의도가 있을 수 있다
        if (state is CursorPagination && !forceRefetch) {
          //pagination 1번이상 한 경우
          final pState = state as CursorPagination; //
          //더이상 데이터 없다면?
          if (!pState.meta.hasMore) {
            return;
          }
        }

        final isLoading = state is CursorPaginationLoading; //완전 첫 로딩
        final isRefetching =
            state is CursorPaginationRefetching; //데이터 있는데 유저 새로고침 할때
        final isFetchingMore =
            state is CursorPaginationFetchingMore; //아래 스크롤 후 로딩

        // 2번 반환 상황) // 2) 로딩중 - fetchMore: true
        if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
          return;
        }

        //PaginationParams 생성
        PaginationParams paginationParams = PaginationParams(
          count: fetchCount,
        );

        // fetchMore
        // 데이터를 추가로 더 가져오는 상황
        if (fetchMore) {
          final pState = state as CursorPagination<T>;

          state = CursorPaginationFetchingMore(
            meta: pState.meta,
            data: pState.data,
          );

          paginationParams = paginationParams.copyWith(
            after: pState.data.last.id,
          );
        }

        //데이터를 처음부터 가져오는 상황(paginationParams변경 안해도됨)
        else {
          // 만약 데이터가 있는 상황이라면?
          // 기존 데이터 보존하고 Fetch (API 요청) 진행
          if (state is CursorPagination && !forceRefetch) {
            final pState = state as CursorPagination<T>;
            state = CursorPaginationRefetching<T>(
              meta: pState.meta,
              data: pState.data,
            );
          }
          // 나머지 상황
          else {
            state = CursorPaginationLoading();
          }
        }

        final resp = await repository.paginate(
          paginationParams: paginationParams, //쿼리로 자동 반환되는 paginationParams
        );

        if (state is CursorPaginationFetchingMore) {
          final pState = state as CursorPaginationFetchingMore<T>;

          state = resp.copyWith(
            data: [
              ...pState.data, //기존에 잇는 데이터에
              ...resp.data, //새로운 데이터 추가
            ],
          );
        } else {
          // 상태가 CursorPaginationFetchingMore 아니라면?
          state = resp;
        }
      } catch (e,stack) {
        print(e);
        print(stack);
        state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
      }
  }
}
