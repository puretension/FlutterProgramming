# Learned by CodeFactory
https://www.inflearn.com/course/플러터-실전/dashboard
## 강의를 수강하며 알게된 개념 정리
## Provider & JsonSerializable

* Provider: 플러터에서 상태 관리 패키지 중 하나로, 상태를 관리하고 공유하기 위한 방법을 제공하며 다양한 Provider를 사용하면 상태 관리를 효율적으로 할 수 있다.
* JsonSerializable: 플러터에서 모델 클래스를 직렬화하고 역직렬화하기 위해 사용하는 패키지로 Dart 클래스를 JSON 데이터로 변환하거나 JSON 데이터를 Dart 클래스로 변환하는 데 도움을 준다.

## Retrofit & Dio Interceptor

* Retrofit: 플러터에서 네트워크 요청을 쉽게 처리할 수 있도록 도와주는 HTTP 클라이언트 라이브러리로 RESTful API를 사용하는 앱을 개발할 때 유용하다.
* Dio Interceptor: Dio는 또 다른 플러터용 HTTP 클라이언트 라이브러리로 Interceptor는 네트워크 요청과 응답을 가로채고 수정하는 데 사용되며, 예를 들어 헤더를 추가하거나 에러 처리를 할 때 사용된다.

## Pagination & Data Modeling

* Pagination: 앱에서 많은 양의 데이터를 처리할 때 데이터를 페이지로 나누어 처리하는 기술로 사용자 경험을 향상시키고 데이터 로딩을 최적화하는 데 도움이 된다.
* DataModeling: 데이터 모델링은 앱에서 사용할 데이터를 구조화하고 표현하는 과정으로 데이터 모델은 앱의 각 요소 간에 데이터를 교환하고 처리하는 데 사용된다.

## Cache & Code Generation

* Cache: 앱의 성능을 향상시키기 위해 데이터를 로컬에 저장하는 것을 의미하며 네트워크 요청을 줄이고 데이터 로딩 속도를 개선하는 데 도움이 된다.
* Code Generation: 코드 생성은 주로 반복적이고 번거로운 작업을 자동화하기 위해 사용되며, 플러터에서는 코드 생성을 통해 모델 클래스를 자동으로 생성하거나 라우팅 코드를 생성할 수 있다.

## GoRouter & Authentication Logic

* GoRouter: 플러터 앱의 네비게이션을 관리하기 위한 라우팅 패키지 중 하나로 앱 내에서 화면 간 이동을 관리하는 데 도움이 된다.
* Authentication Logic: 인증 로직은 사용자가 앱에 로그인하거나 인증을 통해 접근 권한을 얻는 등의 프로세스를 다루는 개념으로 사용자 인증은 보안과 사용자 경험을 고려해야 하는 중요한 부분이다.

## Debounce & Throttle

* Debounce: Debounce는 사용자의 연속적인 액션에 대응하는 방법 중 하나다. 예를 들어, 사용자가 검색어를 입력할 때 매 글자 입력마다 검색 요청을 보내는 것이 아니라, 사용자가 일정 시간 동안 입력을 중지했을 때 한 번만 검색 요청을 보내는 방법이다. 이를 통해 불필요한 네트워크 요청을 줄이고 리소스를 효율적으로 활용할 수 있다.

* Throttle: Throttle은 연속적인 이벤트를 일정 시간 간격으로 제한하여 처리하는 방법이다. 스크롤 이벤트 또는 마우스 이동 이벤트 등을 처리할 때 주로 사용되며, 일정 시간 간격으로 이벤트를 샘플링하여 리소스 사용을 최적화하고 앱의 성능을 개선하는데 도움이 된다
