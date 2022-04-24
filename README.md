# Cocktail App

## 리팩토링 현황
> 난개발 유사 MVC 에서 Rx + MVVM 으로

### 홈화면
- 홈화면: x

### 레시피
- 레시피: 완료(2021-01-27)

### 마이페이지
- 내술장: 완료 (2021-01-19)
- 나의레시피: 완료 (2021-01-17)
- 즐겨찾기: 완료 (2021-01-16)

### 설정
- 설정: x

## 사용 라이브러리
### Convention
- SnapKit: AutoLayout 을 간결하게 작성하기 위해 사용
- KingFisher: 이미지 캐싱
- lottie: 간단한 애니메이션 구현
- Then: UI관련 코드 가독성 개선
- Siren: 업데이트 푸시알람

### Rx
- Rxswift: rx코드를 swift 문법에 결합시키기위해 사용
- RxCocoa: RxSwift 와 cocoaTouch framework 결합위해 사용
- RxAppstate: 라이프 사이클과 RxSwift 결합을 위해 사용

### Server
- FireBaseAuth: 애플 로그인 기능 추가및, uid 식별용
- FireBaseDatabase: realtimeDatabase 로 칵테일 레시피 및 선호도 정보, 즐겨찾기 정보 관리를 위해 사용
- FireBaseStorage: 칵테일 이미지 파일 관리를 위해 사용

## UI변천사

| 화면 |초반 |중반 | 마무리 |
| :--- | :--- | :--- | :--- |
| 홈화면| <img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%8F%E1%85%A1%E1%86%A8%E1%84%90%E1%85%A6%E1%84%8B%E1%85%B5%E1%86%AF%20%E1%84%92%E1%85%A9%E1%86%B7%20%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB/3213.png?raw=true" height="400px" width="400px">| <img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%8F%E1%85%A1%E1%86%A8%E1%84%90%E1%85%A6%E1%84%8B%E1%85%B5%E1%86%AF%20%E1%84%92%E1%85%A9%E1%86%B7%20%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB/C789B468-4D8F-4524-8B1D-FC6575CDE3EA_1_105_c.jpeg?raw=true" height="400px" width="400px">| <img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%8F%E1%85%A1%E1%86%A8%E1%84%90%E1%85%A6%E1%84%8B%E1%85%B5%E1%86%AF%20%E1%84%92%E1%85%A9%E1%86%B7%20%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB/76A200A0-7AD2-438D-BC39-A589BAA5689E_1_102_o.jpeg?raw=true" height="400px" width="400px">
|칵테일 레시피|<img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%8F%E1%85%A1%E1%86%A8%E1%84%90%E1%85%A6%E1%84%8B%E1%85%B5%E1%86%AF%20%E1%84%85%E1%85%A6%E1%84%89%E1%85%B5%E1%84%91%E1%85%B5/2A4B69AF-0215-4B9E-AA79-453BFB347608_1_105_c.jpeg?raw=true" height="400px" width="400px">|<img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%8F%E1%85%A1%E1%86%A8%E1%84%90%E1%85%A6%E1%84%8B%E1%85%B5%E1%86%AF%20%E1%84%85%E1%85%A6%E1%84%89%E1%85%B5%E1%84%91%E1%85%B5/8C587FB1-3A2E-4CD0-9E3B-3190CB7640CB_1_105_c.jpeg?raw=true" height="400px" width="400px">|<img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%8F%E1%85%A1%E1%86%A8%E1%84%90%E1%85%A6%E1%84%8B%E1%85%B5%E1%86%AF%20%E1%84%85%E1%85%A6%E1%84%89%E1%85%B5%E1%84%91%E1%85%B5/7A17706B-65C0-4B4E-9378-58742DB20841_1_102_o.jpeg?raw=true" height="400px" width="400px">|
|칵테일 추천|<img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%8E%E1%85%A9%E1%84%80%E1%85%B5%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB/07E87C35-64C6-442C-80FC-9B34D763CB49_1_105_c.jpeg?raw=true" height="400px" width="400px">|<img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%82%E1%85%A2%E1%84%89%E1%85%AE%E1%86%AF%E1%84%8C%E1%85%A1%E1%86%BC%20%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB/%E1%84%80%E1%85%A1%E1%84%8B%E1%85%B5%E1%86%B8%E1%84%8C%E1%85%A1%20%E1%84%8E%E1%85%B1%E1%84%92%E1%85%A3%E1%86%BC_1.png?raw=true" height="400px" width="400px">|<img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%8E%E1%85%A9%E1%84%80%E1%85%B5%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB/2D1409DD-7FDB-4BC0-BAB2-138CB4EE79CC_1_105_c.jpeg?raw=true" height="400px" width="400px">|
|칵테일 정보|<img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%8F%E1%85%A1%E1%86%A8%E1%84%90%E1%85%A6%E1%84%8B%E1%85%B5%E1%86%AF%20%E1%84%8C%E1%85%A5%E1%86%BC%E1%84%87%E1%85%A9%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB/%E1%84%8B%E1%85%AA%E1%84%8B%E1%85%B5%E1%84%8B%E1%85%A5%E1%84%91%E1%85%B3%E1%84%85%E1%85%A6%E1%84%8B%E1%85%B5%E1%86%B7.png?raw=true" height="400px" width="400px">|<img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%8F%E1%85%A1%E1%86%A8%E1%84%90%E1%85%A6%E1%84%8B%E1%85%B5%E1%86%AF%20%E1%84%8C%E1%85%A5%E1%86%BC%E1%84%87%E1%85%A9%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB/8FD0F1C8-B07A-48AE-A88C-9CD6E07D69A6_1_105_c.jpeg?raw=true" height="400px" width="400px">|<img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%8F%E1%85%A1%E1%86%A8%E1%84%90%E1%85%A6%E1%84%8B%E1%85%B5%E1%86%AF%20%E1%84%8C%E1%85%A5%E1%86%BC%E1%84%87%E1%85%A9%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB/3CC18443-3D87-4E3F-A0E6-FDCD9319AF5D_1_105_c.jpeg?raw=true" height="400px" width="400px">|
|편집화면|<img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%8F%E1%85%A1%E1%86%A8%E1%84%90%E1%85%A6%E1%84%8B%E1%85%B5%E1%86%AF%20%E1%84%91%E1%85%A7%E1%86%AB%E1%84%8C%E1%85%B5%E1%86%B8%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB/850CE315-8F0D-40A5-AEDE-4AE5158EBEAD_1_105_c.jpeg?raw=true" height="400px" width="400px">|<img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%8F%E1%85%A1%E1%86%A8%E1%84%90%E1%85%A6%E1%84%8B%E1%85%B5%E1%86%AF%20%E1%84%91%E1%85%A7%E1%86%AB%E1%84%8C%E1%85%B5%E1%86%B8%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB/5D494D1B-47CF-41FF-8B7A-79C0772A34F6_1_105_c.jpeg?raw=true" height="400px" width="400px">|<img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%8F%E1%85%A1%E1%86%A8%E1%84%90%E1%85%A6%E1%84%8B%E1%85%B5%E1%86%AF%20%E1%84%91%E1%85%A7%E1%86%AB%E1%84%8C%E1%85%B5%E1%86%B8%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB/9A23C0E9-08D3-404E-8CE3-CC2BBBE50A4B_1_102_o.jpeg?raw=true" height="400px" width="400px">|
|마이페이지|<img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%82%E1%85%A2%E1%84%89%E1%85%AE%E1%86%AF%E1%84%8C%E1%85%A1%E1%86%BC%20%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB/97C85384-7DCD-4C6B-A42F-B1B14E36D9D4_1_105_c.jpeg?raw=true" height="400px" width="400px">|<img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%82%E1%85%A2%E1%84%89%E1%85%AE%E1%86%AF%E1%84%8C%E1%85%A1%E1%86%BC%20%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB/%E1%84%86%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%91%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%8C%E1%85%B5_1.png?raw=true" height="400px" width="400px">|<img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%82%E1%85%A2%E1%84%89%E1%85%AE%E1%86%AF%E1%84%8C%E1%85%A1%E1%86%BC%20%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB/85B84A4E-AA22-4946-8856-8B55EDC015CD_1_105_c.jpeg?raw=true" height="400px" width="400px">|
|내술장|<img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%82%E1%85%A2%E1%84%89%E1%85%AE%E1%86%AF%E1%84%8C%E1%85%A1%E1%86%BC%20%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB/FDCA50FB-94BF-492F-AEEF-42DA8A72C1C7_1_105_c.jpeg?raw=true" height="400px" width="400px">|<img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%82%E1%85%A2%E1%84%89%E1%85%AE%E1%86%AF%E1%84%8C%E1%85%A1%E1%86%BC%20%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB/1269357D-EFF6-4692-9DC8-1B19ECF0B80D_1_105_c.jpeg?raw=true" height="400px" width="400px">|<img src="https://github.com/kinest1997/MyAssets/blob/main/%E1%84%82%E1%85%A2%E1%84%89%E1%85%AE%E1%86%AF%E1%84%8C%E1%85%A1%E1%86%BC%20%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB/F83DD533-95E0-432E-AC2E-92C63DFA8AA4_1_105_c.jpeg?raw=true" height="400px" width="400px">|

## 개발일지

### 1주차

| 변경내역 | 비고 | 
| :--- | :--- |
| 가장 기본 UI 생성 | TabBar, NavigationController  사용 |
| 가지고있던 레시피 한글파일 plist 데이터화 | 100개...|
| cocktail 객체 생성 | 메인화면 ScrollView로 변경|
| 칵테일 정보 보여주는 뷰 생성 | 스냅킷 매스터 |
| 칵테일레시피 전체를 보여주는 테이블뷰 생성 | tableView 사용 |
| 전체 레시피에서 검색기능 추가| UISearchController 첫만남 |
| 내술장 뷰 생성| 핵심 기능 |
| 내술장에 술 추가하는 뷰 생성 | CollectionView 사용|
| 버튼의 우상단에 badge 만들기 |custom class로 숫자를 보여주는 badge 표시   |

### 2주차

| 변경내역 | 비고 | 
| :--- | :--- |
| 내가 가지고있는 술 저장 기능 추가 | UserDefault 사용|
| 칵테일의 재료들 enum 화 | caseIterable 최고 |
| 재앙으로 인한 복구작업| 2주차 앞부분 삭제 |
| 내가 만들수있는 칵테일 목록 만드는 알고리즘 만듬| Set의 차집합개념 사용 |
| Localization 을 위한 칵테일 객체 영문화 | Localization 시작|

### 3주차 

| 변경내역 | 비고 | 
| :--- | :--- |
| 가진 재료수에 따라 뱃지의 숫자 변경 | View lifeCycle 이해 |
| 필터 만들기 재도전| Set의 intersection 사용하여 필터 알고리즘 완성 |
| 필터와 검색창 충돌| 필터링중인 함수에 조건 추가|
| 리팩토링 | 중복함수 간소화 |

### 4주차

| 변경내역 | 비고 | 
| :--- | :--- |
| 나만의 칵테일 레시피 추가뷰 생성 | UIMenu 첫만남|
| 재료 선택 위한 뷰 생성 | Tuple Array를 사용하여 재료 선택하여 저장|
| 나만의 레시피 저장 기능 추가 | 클로저 사용하여 저장 즉시 업데이트 되도록|
| 리팩토링 | indent 및 중복 코드 간소화 |
| 나만의 칵테일의 이미지 추가 기능 추가 | UIImagePickerController 사용|
| NSURL관련 코드 URL로 전부 변경 | absoluteString 과 path 는 다르다..|
| 이미지 파일크기 축소하여 저장 | UIGraphicsImageRenderer 사용|
| 즐겨찾기 기능의 필요성을 느껴 객체 수정 | 노가다..|

### 5주차

| 변경내역 | 비고 | 
| :--- | :--- |
| UIImagePickerController deprecate 예정이라 변경 | PhPicker 사용하는걸로 리팩토링|
| 즐겨찾기 기능 추가 완료 | 3항연산자 사용으로  간결해짐|
| 위젯 추가 예정 | SwiftUI 찍먹 |
| 간단히 칵테일 보여주는 위젯 추가 | AppGroup folder 사용 |
| 전체 레시피를 불러오는 시점 변경 | ApplifeCycle 이해 | 
| 앱아이콘 변경 | .png 파일이 아니면 보이지않는다..|
| 전체적인 앱 UI,UX 다듬을 멤버 3명 구함 | 포토샵장인, 일러스트레이터, 칵테일 장인|
| UI 개편 시작| UI관련 property 숙달|
| 앱내 데이터로 관리하던 칵테일 레시피 데이터베이스로 이전| Firebase realtimeDataBase, Storage 사용|
| 네트워크 통신으로 앱 업데이트없이 콘솔로 칵테일 컨텐츠 업데이트 가능| escaping 클로저 지옥 |
| 앱내부에서 이미지를 가지는게 아닌 네트워크에서 받아오는걸로 변경 | kingFisher 사용, 캐시메모리관리해주는 혜자 |
| 사용자 데이터 수집을 위한 애플로그인 추가| 애플 개발자 계정 등록...|
| 기존 개별 버튼 생성으로 만든 뷰를 collectionView로 개편| collectionView 숙달중|
| 메인화면 CollectionView로 개편 | collectionView compositional Layout 연습 |
| 네트워크 통신시에 생기는 딜레이를 위한 로딩뷰 생성 | lottie 사용, 너무귀엽다.|
| 전역에 존재하던 함수들 singleton 내부로 이사 | singleton 객체 사용 |

### 6주차

| 변경내역 | 비고 | 
| :--- | :--- | 
| 칵테일 객체 수정, 레시피 단계별로 분리하여 저장가능 및 수정 가능. | [string: [string]] 기괴한모양|
| 앱 설정창 생성| deeplink통한 인스타, 링크드인, 깃허브 연결 버튼 생성|
| 알림설정창 생성| 알람 설정 확인하는 property, 설정으로 이어지는 deeplink|
| Firebase 를 통한 원격 notification 전달 추가 | 새롭게 레시피 업데이트 될때마다 알람 보내기 가능|
| 로그인, 로그아웃, 로그인 하지않고 사용 추가| 비로그인시에 즐겨찾기, 나의 레시피 접근 불가.|
| 메인화면에서 유튜브 앱으로 이어지는 링크 생성| youtube deeplink 사용|
| 커뮤니티처럼 개별 칵테일 마다 좋아요, 싫어요 기능 추가| 사용자들을 칵테일의 좋아요 싫어요 갯수를 보고 개별적 판단 가능 |
| extension으로 뷰마다 중복작성하던 함수 간소화| class에 method 추가|
| 앱 UI 개편작업| 앱 런칭 초기화면부터 시작 |
| rxswift, mvvm 공부 시작| 모르겠음|
| 리팩토링 | 기존의 버튼 9개로 만든 뷰들 전부 컬렉션뷰로 변경 |

### 7주차 ~ 8주차
| 변경내역 | 비고 | 
| :--- | :--- | 
| font 적용 및 앱전역 폰트 설정 | .appearance() 갓갓|
| 홈화면 무한 show 오류 수정 | removeTarget..|
|홈화면 컨텐츠 다양화| compositionalLayout 숙달중..|
| 오픈소스 라이브러리 고지 페이지 완성| SFSafariViewController 사용|
|좋아요 싫어요 즐겨찾기 팝업 추가| 애니메이션 적용 실패...|
| 코드정리 및 기타 수정사항 변경. 거의 완성단계| 
|attributedString 정리| localization도 마무리|
| 앱 출시! |