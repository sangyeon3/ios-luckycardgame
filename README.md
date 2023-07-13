# ios-luckycardgame
iOS 학습 프로젝트 #1

## 1주차 계획

### 7/4 화

- 코드리뷰 방식, 스타일가이드 확인 (0.5H) ✅
- 게임보드 화면 구현 (2H) ✅
- Info.plist 변경 방식 학습 + 앱 표시 이름 변경 (1H) ✅
- OOP, 추상화 학습 (1H) ✅
- 스위프트 타입별 메모리 분석, 스택과 힙 학습 (1H) ✅

### 7/5 수

- 럭키카드 클래스 구현 (2H) ✅
- struct와 class 차이 학습 (0.5H) ✅
- 참조접근자, 클래스 메모리 관리 방식과 뷰 객체 관리 방식, 메모리 분석 도구 학습 (2H) ✅
- 카드 나눠주기 구현 (1H) 

### 7/6 목

- 카드 나눠주기 구현 (1.5H)
- XCTest, 단위테스트 학습 (1H)
- LuckyGame 객체 작성 (1.5H)
- 단위 테스트 작성 (1H)

### 7/7 금

- 게임 로직 구현 (1.5H)
- 부족한 부분 마무리 (1.5H)

## 게임보드 UI (2023.07.04 18:00)

<image src="https://github.com/softeerbootcamp-2nd/ios-luckycardgame/assets/68235938/ba4ea294-d23b-4cad-80a5-300565ed6acb" width="393">

## LuckyCard 클래스 (2023.07.06 09:00)

- 카드의 모양과 숫자 정보를 갖는 LuckyCard 클래스 구현
- LuckyCard 인스턴스를 생성해주는 LuckyCardFactory 클래스 구현
- 전체 카드 덱을 생성해서 아래와 같은 형식으로 출력

<img width="918" alt="image" src="https://github.com/softeerbootcamp-2nd/ios-luckycardgame/assets/68235938/1b4197fd-35f6-4529-8bf4-845819169536">

## 카드 나눠주기 (2023.07.10 10:30)

- segmented control에서 선택된 참가자 수에 따라 카드를 나눠주고 화면을 업데이트
  - 나를 제외한 다른 플레이어의 카드나 남은 카드들은 카드 뒷면을 표시

![Simulator Screen Recording - iPhone 14 Pro - 2023-07-09 at 19 34 30](https://github.com/softeerbootcamp-2nd/ios-luckycardgame/assets/68235938/6a2276b9-493c-433a-ad10-9862d969bffb)



