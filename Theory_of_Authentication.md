# 1. Session

유저의 정보를 **DB에 저장, 상태 유지** 도구

## Session의 특징

- Session은 특수한 ID값으로 구성
- Session은 서버에서 생성되며 클라이언트에서 쿠키를 통해 저장
- 클라이언트에서 요청 보낼때 Session ID를 같이 보내면 현재 요청을 보내는 사용자가 누구인지 서버에서 알 수 있다.(요청마다 매번 ID,PW 물어볼필요 X)
- Session ID는 DB에 저장되기때문에 요청이 있을때마다 매번 DB를 확인해야하는 단점
- 서버에 데이터가 저장되기때문에 클라이언트에 사용자 정보가 노출될 위험이 없다
- DB에 Session을 저장해야 하기 때문에 Horizontal Scaling이 어렵다


## 2. Token

유저의 정보를 **BASE64로 인코딩된 String 값**에 저장하는 도구

## Token 특징⭐️

- Token은 Header, Payload, Signature로 구성, Base64로 encoded
- Token은 서버에서 생성되며 클라이언트에서 저장됨
- 클라이언트에서 요청을 보낼때 Token ID를 같이 보내면 현재 요청을 보내는 사용자가 누구인지 서버에서 알 수 있음(요청마다 매번 ID,PW 물어볼 필요X)
- Token은 Session과 달리 DB에 저장되지않고 Signature값을 이용하여 검증가능. 매번 검증할때마다 DB를 들여다볼 필요가 없다
- 정보가 모두 Token에 담겨있고 클라이언트에서 토큰을 저장하기에 정보 유출 위험O
- DB가 필요없기에 Horizontal Scaling이 쉽다

**Token 전송 → API 서버에서 자체검증 → DB에 데이터요청 → 결과응답 → Client에게 데이터 전송** 

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

# 4. Refresh Token & Access Token

- 두 토큰 모두 JWT기반
- Access Token은 API 요청시 검증용토큰. 인증이 필요한 API사용시 꼭 Access Token을 Header에 넣어 보내야함 ex) 유저 정보 수정, 회사 채용공고 지원 인원 확인 등
- Refresh Token은 Access Token을 추가로 발급할때 사용함.  Access Token을 새로고침(Refresh)하는 기능이 있으므로 Refresh Token이라고함
- Access Token은 유효기간 짧고, Refresh Token은 유효기간이 길다
- 자주 노출되는 Access Token은 유효기간을 짧게 해서 Token이 탈취되어도 해커가 오래 사용 못하도록 방지
- 상대적으로 노출이적은 R Token은 A Token을 새로 발급 받을때만 사용되므로 안전함
Refresh Token 기간도 만료된다면(401에러) → Logout
