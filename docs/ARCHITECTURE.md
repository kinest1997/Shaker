# Shaker 코드베이스

Shaker는 칵테일 추천, 레시피 탐색, 보유 재료 관리, 위시리스트와 사용자 레시피를 제공하는 iPhone 앱이다. 화면은 UIKit과 SnapKit으로 구성하고 일부 화면 이벤트와 데이터 조회에 RxSwift/RxCocoa를 사용한다.

## 실행 흐름과 소스 위치

1. [AppDelegate](../Cocktail/Cocktail/AppDelegate.swift)가 Firebase를 초기화하고 전체 레시피와 좋아요 데이터를 불러온다. 푸시 알림 등록과 Siren 업데이트 확인도 여기서 시작한다.
2. [SceneDelegate](../Cocktail/Cocktail/SceneDelegate.swift)가 `UserDefaults`의 `firstLaunch` 값에 따라 로그인 화면 또는 메인 탭을 연다. [FirstLaunch](../Cocktail/Cocktail/FirstLaunch)에서 Apple 로그인과 취향 선택을 처리하며, 로그인 없이 메인 탭으로 진입할 수도 있다.
3. [MainViewController](../Cocktail/Cocktail/MainView/MainTabBar/MainViewController.swift)가 오늘의 칵테일, 레시피, 홈바, 설정 탭을 구성한다. [MainView](../Cocktail/Cocktail/MainView)에 칵테일 상세와 홈바의 보유 재료, 위시리스트, 사용자 레시피 화면이 있다.

| 위치 | 역할 |
| --- | --- |
| [Singleton](../Cocktail/Cocktail/Singleton) | Firebase 조회·저장과 레시피, 위시리스트, 좋아요 등의 메모리 상태. 주 진입점은 `NetworkHelper.swift`의 `FirebaseRecipe.shared` |
| [CocktailStructs](../Cocktail/Cocktail/CocktailStructs) | 칵테일, 추천, YouTube, 좋아요 및 오류 모델 |
| [CustomView](../Cocktail/Cocktail/CustomView), [Extensions](../Cocktail/Cocktail/Extensions) | 공통 UI와 UIKit, Rx, 문자열 확장 |
| [Resource](../Cocktail/Cocktail/Resource) | 번들 레시피 JSON과 재료 plist, 이미지, 폰트, 한국어·영어 번역. 보유 재료와 일부 취향 설정은 `UserDefaults`에 저장 |

## Firebase 데이터 접근

앱 설정의 Firebase 프로젝트 ID는 `shaker-app-23dec`이다. 아래 표는 현재 코드의 요청과 기능 유지에 필요한 권한을 설명한다. 실제 게시 규칙은 Firebase Console의 `shaker-app-23dec-default-rtdb` 인스턴스에서 확인한다.

| 서비스와 경로 | 앱 동작과 필요한 권한 |
| --- | --- |
| RTDB `/CocktailRecipes`, `/CocktailRecommendation`, `/Youtube` | 게스트도 레시피, 추천, 영상 목록 조회. 목록을 관리하는 작업은 일반 사용자 쓰기 권한 없이 처리 가능 |
| RTDB `/users/$uid/WishList`, `/users/$uid/MyRecipes` | 로그인한 본인만 조회·저장. 앱은 목록 전체를 해당 경로에 저장 |
| RTDB `/CocktailLikeData` | 앱 시작 시 전체 경로를 구독하고 상세 화면에서 칵테일별로 조회. 현행 게스트 집계를 유지하려면 상위 경로 읽기가 필요하며, 공개 읽기 시 UID별 반응도 함께 노출됨 |
| RTDB `/CocktailLikeData/$cocktail/$uid` | 로그인한 본인이 `true` 또는 `false` 저장, 반응 취소 시 삭제 |
| Storage `/CustomCocktails/$uid/Recipes/…` | 사용자 레시피 이미지 업로드와 삭제. 앱은 다운로드 URL을 레시피 데이터에 저장하며, Storage 권한은 별도 규칙에서 관리 |

규칙 변경 시 게스트의 레시피·집계 조회, 본인의 위시리스트·내 레시피 저장과 반응 추가·취소, 타인 데이터와 DB 루트 접근 거부를 확인한다. 앱에서 저장을 확인할 때는 화면을 다시 열어 값이 유지되는지 본다.

## Xcode와 검증

- [Cocktail.xcodeproj](../Cocktail/Cocktail.xcodeproj)를 Xcode에서 열고 `Cocktail` 앱 스킴을 선택한다. 프로젝트 설정은 iPhone, 최소 iOS 15.0, Swift 5 모드, 앱 버전 1.0.5다.
- Swift Package Manager로 Firebase iOS SDK, SnapKit, RxSwift/RxCocoa/RxRelay, Kingfisher, Lottie, Siren을 가져온다.
- [위젯 소스](../Cocktail/Cocktail%20Widget)와 [테스트 예제](../Cocktail/CocktailTests)는 저장소에 있으며, 현재 Xcode 프로젝트의 앱 타깃 목록에는 위젯과 테스트 타깃이 등록돼 있지 않다.
- 실기기에서 Apple 로그인과 푸시를 검증할 때는 앱 서명과 [entitlements](../Cocktail/Cocktail/Cocktail.entitlements) 구성을 확인한다.

## 알려진 로그인 상태 문제

[FirebaseRecipe](../Cocktail/Cocktail/Singleton/NetworkHelper.swift)는 앱 시작 시 초기화되며 당시 Firebase Auth UID를 `let uid`에 저장한다. 같은 앱 실행 중 게스트가 로그인하거나 계정이 바뀌면 위시리스트·내 레시피·좋아요 쓰기가 건너뛰어지거나 현재 계정과 다른 UID로 요청될 수 있다. 재현할 때는 게스트에서 바로 로그인한 경우와 로그인 상태에서 앱을 재실행한 경우의 저장 결과를 비교한다.
