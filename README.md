# Assignment

## 과제 설명

---

이 과제는 아래 능력을 보기 위한 과제입니다.

- 아키텍처에 맞게 구현하는 능력
- 능동적 정보 습득능력
- API 문서 이해
- 공식 문서 이해
- MVVM 아키텍처 이해
- 협업 규칙에 맞게 작업 수행

저희 실제 서버를 이용해서 로그인부터 동아리 목록 불러오는 화면까지 구현하는 것을 목표로 합니다. 현재 사용하고 있는 Riverpod MVVM 아키텍처의 문제점을 개선하고자 Flutter 공식 MVVM 아키텍처 구현 방식을 도입하고자 합니다. 이를 통해 Clean Architecture 에 부합하는 구조를 만들어 궁극적으로 생산성을 늘리고 사용자 경험도 향상시킬 수 있는 앱을 만들고자 합니다. 배포 관련 문제로 FCM 관련 기능은 dummy token 을 보내는 식으로 제외하면 됩니다.

아래 초기 세팅되어 있는 프로젝트에서 로그인과 동아리 목록 불러오기 기능을 완성하면 됩니다.

## 과제 시작하기

---

**과제용 프로젝트** : 깃허브링크

**과제용 프로젝트 설명**

- 디렉터리 구성

```
lib/
├── config/                # 앱의 설정, 의존성 주입, 환경 변수 등 전역 설정 관련 코드
│   ├── constants.dart         # 앱에서 사용하는 상수값 정의
│   ├── dependencies.dart      # 의존성 주입 및 서비스 등록
│   └── flavor_config.dart     # 앱의 플러버(환경)별 설정 관리
├── data/                  # 데이터 계층: 외부 데이터 소스, 모델, 저장소 등
│   ├── models/                # 데이터 모델(엔티티) 정의
│   ├── repositories/          # 데이터 접근/가공 로직 (Repository 패턴)
│   └── services/              # 외부 서비스(API, FCM 등)와의 통신
│       ├── api_service.dart       # API 서버와의 통신 로직
│       └── fcm_service.dart       # FCM(푸시 알림) 관련 서비스 로직
├── domain/                # 비즈니스 로직 계층: UseCase, 도메인 모델 등
│   ├── models/                # 도메인 모델 정의 (data/models와 구분 가능)
│   └── use_cases/             # 실제 비즈니스 로직(UseCase) 구현
├── firebase/              # 파이어베이스 환경설정 관련 코드
│   ├── firebase_options_dev.dart  # 개발 환경용 파이어베이스 옵션
│   └── firebase_options_stg.dart  # 스테이징 환경용 파이어베이스 옵션
├── main.dart                  # 앱 실행의 기본 진입점
├── main_development.dart      # 개발 환경에서 앱 실행 진입점
├── main_staging.dart          # 스테이징 환경에서 앱 실행 진입점
├── routing/               # 라우팅(네비게이션) 관련 코드
│   ├── router.dart            # 라우터 설정 및 관리
│   └── routes.dart            # 라우트(경로) 목록 정의
├── ui/                    # View 계층: 화면, 위젯, ViewModel 등 UI 관련 코드
└── utils/                 # 공통 유틸리티 함수/클래스
    ├── command.dart           # 커맨드 패턴 등 명령 관련 유틸 함수
    └── result.dart            # 결과 처리 및 공통 Result 타입 정의
```

- 실행방법
    
    본 프로젝트는 staging(배포서버) & development(테스트서버) 두 가지 Flutter Flavor 를 도입하여 서로 다른 환경을 구현합니다. 
    https://docs.flutter.dev/deployment/flavors
    
    ![Screenshot 2025-06-29 at 5.36.33 PM.png](attachment:391ee95d-33e8-464f-99bf-46f484eafa11:Screenshot_2025-06-29_at_5.36.33_PM.png)
    
    debug 모드 : 
    
    개발 중에 가장 많이 사용하는 모드입니다. 
    디버깅 정보(예: 로그, DevTools 등)가 풍부하게 제공됩니다. 
    코드 최적화가 거의 적용되지 않아 실행 속도가 느릴 수 있습니다.
    
    profile 모드 : 
    
    성능 측정(프로파일링)을 위한 모드입니다.
    Hot reload는 지원되지 않지만, Hot restart는 가능합니다.
    일부 디버깅 정보는 제공되지만, debug 모드보다는 제한적입니다.
    코드가 최적화되어 실제 성능에 가까운 실행 환경을 제공합니다.
    주로 성능 테스트, 프레임 드랍, 렌더링 시간 측정 등에 사용합니다.
    
    release 모드 : 
    
    실제 배포(릴리즈)용 빌드입니다.
    모든 디버깅, 프로파일링 기능이 비활성화됩니다.
    assert 문이 완전히 제거됩니다.
    코드가 최대한 최적화되어 가장 빠른 실행 속도를 보입니다.
    앱 스토어에 올리거나 실제 사용자에게 배포할 때 사용하는 모드입니다.
    

과제용 레포지토리에서 아래와 같은 **작업 규칙**에 맞게 작업해주세요.

브랜치 관리 규칙 : Git Flow 기반 main / develop / {feature} / hotfix 4가지 브랜치로 나누어 기능 단위 작업

작업 방식

1. GitHub Project Dashboard 를 활용하여 전체적인 작업 공유 및 관리
    
    ![Screenshot 2025-06-28 at 4.17.12 PM.png](attachment:227c7a25-8a3f-49dc-af3c-30172a813abc:Screenshot_2025-06-28_at_4.17.12_PM.png)
    
2. 자신에게 할당된 작업을 Issue 로 만들고 develop 에서 기능에 맞는 브랜치를 파서 작업을 진행
    
    브랜치 명명 규칙 : feature/{기능이름} 형식으로 작성
    
3. 기능 단위로 커밋을 작성
    
    커밋 메시지 작성 규칙 : 
    {타입(필수)} : {제목(필수)}
    {본문(선택)}
    {푸터(선택)}
    
    | 타입 이름 | 내용 |
    | --- | --- |
    | feat | 새로운 기능에 대한 커밋 |
    | fix | 버그 수정에 대한 커밋 |
    | build | 빌드 관련 파일 수정 / 모듈 설치 또는 삭제에 대한 커밋 |
    | chore | 그 외 자잘한 수정에 대한 커밋 |
    | ci | ci 관련 설정 수정에 대한 커밋 |
    | docs | 문서 수정에 대한 커밋 |
    | style | 코드 스타일 혹은 포맷 등에 관한 커밋 |
    | refactor | 코드 리팩토링에 대한 커밋 |
    | test | 테스트 코드 수정에 대한 커밋 |
    | perf | 성능 개선에 대한 커밋 |
4. 해당 기능 로컬 브랜치에서 develop 과 merge 수행하여 merge conflict 해결
5. develop 으로 pull request 보내고 Leader 에게 알림
6. Leader 가 승인하면 작업 완료

[관련 문서 및 영상]

**Clean Architecture** (https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

**MVVM 아키텍처 공식 문서** (https://docs.flutter.dev/app-architecture)

**API 문서**

[Circle_Link_Server 모바일 명세서](https://documenter.getpostman.com/view/36800939/2sA3s1nrcY#30ff59c1-b4c6-4e4e-afff-6a74af015c0c)

**Figma**

https://www.figma.com/design/Ytnhv1rpmhvQ5pMKstvOlL/-FLAG--%EB%8F%99%EA%B5%AC%EB%9D%BC%EB%AF%B8-for-assignment?node-id=716-251&t=4mct4VNujZ7CpruF-1

GitHub Project 및 브랜치 사용법

https://www.youtube.com/watch?v=tkkbYCajCjM&t=36s

✅ 기존 UI 나 비즈니스 로직 참고

https://github.com/USW-Circle-Link/USW-Circle-Link-APP
