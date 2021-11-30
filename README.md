# Cocktail App

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
| 저장 과정 우선순위 낮춤 | DispatchQueue 사용하여 utility 수준으로 작동|
| 즐겨찾기 기능의 필요성을 느껴 객체 수정 | 노가다..|

### 5주차

| 변경내역 | 비고 | 
| :--- | :--- |
| UIImagePickerController deprecate 예정이라 변경 | PhPicker 사용하는걸로 리팩토링|
| 즐겨찾기 기능 추가 완료 | 3항연산자 사용으로  간결해짐|
| 위젯 추가 예정 | SwiftUI 찍먹 |
| 간단히 칵테일 보여주는 위젯 추가 | AppGroup folder 사용 |
| 전체 레시피를 불러오는 시점 변경 | ApplifeCycle 이해 | 