import UIKit
import RealmSwift

struct Cocktail: Codable {
    let name: String
    let craft: Craft
    let glass: Glass
    let recipe: String
    var ingredients: [String]
    let base: Base
    let alcohol: Alcohol
    let color: Color
    let mytip: String
    let drinkType: DrinkType?
    
    enum Base: String, Codable {
        case 럼
        case 보드카
        case 데킬라
        case 브랜디
        case 위스키
        case 진
        case 리큐르
    }
    
    enum DrinkType: String, Codable {
        case 롱드링크
        case 숏드링크
        case 슈터
    }
    
    enum Color: String, Codable {
        case 빨간색
        case 주황색
        case 노란색
        case 초록색
        case 파란색
        case 보라색
        case 투명색
        case 하얀색
        case 검은색
        case 갈색
    }
    
    enum Alcohol: String, Codable {
        case high
        case mid
        case low
    }
    
    enum Glass: String, Codable {
        case 하이볼
        case 샷잔
        case 온더락
        case 칵테일
        case 마티니
        case 콜린스
        case 마가리타
        case 필스너
    }
    
    enum Craft: String, Codable {
        case 빌드
        case 쉐이킹
        case 플로팅
        case 스터
        case 블렌딩
    }
}

//realm은 일단 보류
//class MyDrinks: Object {
//    @objc dynamic var name: String = ""
//    override static func primaryKey() -> String? {
//          return "name"
//        }
//}
 
enum Ingredients: String {
    case vodka = "보드카"
    case gin = "진"
    case whiskey = "위스키"
    case scotchWhiskey = "스카치위스키"
    case bourbonWhiskey = "버번위스키"
    case ryeWhiskey
    case jackDanielWhiskey
    case tequila
    case baileys
    case melonLiqueur
    case whiteCacaoLiqueur
    case sweetVermouth
    case dryVermouth
    case peachTree
    case grapeFruitLiqueur
    case cacaoLiqueur
    case cremeDeCassis
    case greenMintLiqueur
    case campari
    case kahlua
    case blueCuraso
    case malibu
    case bananaliqueur
    case amaretto
    case triplesec
    case butterScotchLiqueur
    case brandy
    //case
    //case
    //case
    //case
    //case
    //case
    //case
    //case
    //case
    //case
    //case
    //case
    //case
    //case
    //
    //case
    
    var base: String {
        switch self {
        case .vodka:
            return "보드카"
        case .gin:
            return "진"
        case .whiskey, .ryeWhiskey, .scotchWhiskey, .bourbonWhiskey, .jackDanielWhiskey:
            return "위스키"
        case .tequila:
            return "데킬라"
        case . baileys, .melonLiqueur, .whiteCacaoLiqueur, .sweetVermouth, .peachTree, .grapeFruitLiqueur, .cacaoLiqueur, .cremeDeCassis, .greenMintLiqueur, .campari, .kahlua, .blueCuraso, .malibu, .bananaliqueur, .amaretto, .triplesec, .butterScotchLiqueur, .dryVermouth:
            return "리큐르"
        default:
            return "없음"
        }
    }
}


