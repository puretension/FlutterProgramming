# 1. Session

유저의 정보를 **DB에 저장, 상태 유지** 도구

## Session의 특징

- Session은 특수한 ID값으로 구성
- Session은 서버에서 생성되며 클라이언트에서 쿠키를 통해 저장
- 클라이언트에서 요청 보낼때 Session ID를 같이 보내면 현재 요청을 보내는 사용자가 누구인지 서버에서 알 수 있다.(요청마다 매번 ID,PW 물어볼필요 X)
- Session ID는 DB에 저장되기때문에 요청이 있을때마다 매번 DB를 확인해야하는 단점
- 서버에 데이터가 저장되기때문에 클라이언트에 사용자 정보가 노출될 위험이 없다
- DB에 Session을 저장해야 하기 때문에 Horizontal Scaling이 어렵다
    
    ![스크린샷 2023-07-21 오전 10.44.40.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/652bf084-a5a0-421c-a061-7313a67a45b3/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2023-07-21_%EC%98%A4%EC%A0%84_10.44.40.png)
    
    ![스크린샷 2023-07-21 오전 10.46.09.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/4db569b7-4dcd-41ff-9389-eb2042d90925/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2023-07-21_%EC%98%A4%EC%A0%84_10.46.09.png)
    
    ![스크린샷 2023-07-21 오전 10.52.45.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/421bfb0b-7a61-4f70-93a0-5e9efd131bdf/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2023-07-21_%EC%98%A4%EC%A0%84_10.52.45.png)
    

## 2. Token

유저의 정보를 **BASE64로 인코딩된 String 값**에 저장하는 도구

## Token 특징⭐️

- Token은 Header, Payload, Signature로 구성, Base64로 encoded
- Token은 서버에서 생성되며 클라이언트에서 저장됨
- 클라이언트에서 요청을 보낼때 Token ID를 같이 보내면 현재 요청을 보내는 사용자가 누구인지 서버에서 알 수 있음(요청마다 매번 ID,PW 물어볼 필요X)
- Token은 Session과 달리 DB에 저장되지않고 Signature값을 이용하여 검증가능. 매번 검증할때마다 DB를 들여다볼 필요가 없다
- 정보가 모두 Token에 담겨있고 클라이언트에서 토큰을 저장하기에 정보 유출 위험O
- DB가 필요없기에 Horizontal Scaling이 쉽다

![스크린샷 2023-07-21 오전 10.47.41.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/0118fd6f-c11a-43a2-afcc-664fd2f90e74/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2023-07-21_%EC%98%A4%EC%A0%84_10.47.41.png)

![스크린샷 2023-07-21 오전 10.49.13.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/ee0b6cf4-f6dc-42dd-bb35-a47018dc47c5/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2023-07-21_%EC%98%A4%EC%A0%84_10.49.13.png)

**Token 전송 → API 서버에서 자체검증 → DB에 데이터요청 → 결과응답 → Client에게 데이터 전송** 

![스크린샷 2023-07-21 오전 10.54.05.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/c7e197bf-372a-4e97-bb35-cf98648ca5b3/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2023-07-21_%EC%98%A4%EC%A0%84_10.54.05.png)

## Session과 Token 비교

| 비교요소 | Session | Token |
| --- | --- | --- |
| 유저의 정보를 어디에서 저장하는가? |  서버 | 클라이언트 |
| 클라이언트에서 서버로 보내는 정보? | 쿠키 | 토큰 |
| 유저정보를 가져올때 DB확인? | 필수 | Payload에 들어있는 정보만 필요하다면 불필요 |
| 클라이언트에서 인증정보 읽을 수 잇나? | 불가능 | 가능 |
| Horizontal Scaling 쉬운가? | 어려움 | 가능 |

# 3. JWT

## JWT란?

Json Web Token의 약자

Header, Payload, Signature로 구성

Base64로 Encoded

**Header**는 토큰 정보(토큰 종류, 암호화 알고리즘)

**Payload**는 사용자 검증 정보(발행일,만료일,사용자 ID)

**Signature**는 Base64로 인코딩된 Header, Playload를 알고리즘으로 싸인한 값이 들어잇음(토큰 발급 이후 조작여부 확인가능)

![스크린샷 2023-07-21 오전 10.59.57.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1dc7dc73-3eba-4eea-b70a-f84d45090f5f/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2023-07-21_%EC%98%A4%EC%A0%84_10.59.57.png)

![스크린샷 2023-07-21 오전 11.01.23.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/d56d7104-d266-4671-b117-4de9c56f5da8/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2023-07-21_%EC%98%A4%EC%A0%84_11.01.23.png)

# 4. Refresh Token & Access Token

- 두 토큰 모두 JWT기반
- Access Token은 API 요청시 검증용토큰. 인증이 필요한 API사용시 꼭 Access Token을 Header에 넣어 보내야함 ex) 유저 정보 수정, 회사 채용공고 지원 인원 확인 등
- Refresh Token은 Access Token을 추가로 발급할때 사용함.  Access Token을 새로고침(Refresh)하는 기능이 있으므로 Refresh Token이라고함
- Access Token은 유효기간 짧고, Refresh Token은 유효기간이 길다
- 자주 노출되는 Access Token은 유효기간을 짧게 해서 Token이 탈취되어도 해커가 오래 사용 못하도록 방지
- 상대적으로 노출이적은 R Token은 A Token을 새로 발급 받을때만 사용되므로 안전함

![스크린샷 2023-07-21 오전 11.06.21.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6eaffb84-b791-469c-8d57-369dcc9f161b/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2023-07-21_%EC%98%A4%EC%A0%84_11.06.21.png)

![스크린샷 2023-07-21 오전 11.06.53.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/121ed21c-a8d7-43ce-9ad0-8e58e5e7ad4a/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2023-07-21_%EC%98%A4%EC%A0%84_11.06.53.png)

![스크린샷 2023-07-21 오전 11.08.38.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1ab87eae-77b8-4b55-ba31-0025463a0da5/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2023-07-21_%EC%98%A4%EC%A0%84_11.08.38.png)

(1번과정에서 보내는 AccessToken은 기간이 만료되었다는 가정임)

![스크린샷 2023-07-21 오전 11.08.27.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/4008ab81-f370-4a47-a602-c447fff68338/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2023-07-21_%EC%98%A4%EC%A0%84_11.08.27.png)

Refresh Token 기간도 만료된다면(401에러) → Logout
