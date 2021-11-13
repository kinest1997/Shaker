import UIKit
import RealmSwift

struct Cocktail: Codable {
    let name: String
    let craft: Craft
    let glass: Glass
    let recipe: String
    var ingredients: [Ingredients]
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
    enum Ingredients: String, Codable {
        
        case gin = "진"
        case vodka = "보드카"
        
        case whiskey = "위스키"
        case scotchWhiskey = "스카치위스키"
        case bourbonWhiskey = "버번위스키"
        case ryeWhiskey = "라이위스키"
        case jackDanielWhiskey = "잭다니엘"
        
        case tequila = "데킬라"
        
        case baileys = "베일리스"
        case melonLiqueur = "멜론리큐르"
        case whiteCacaoLiqueur = "화이트카카오리큐르"
        case sweetVermouth = "스위트베르무트"
        case dryVermouth = "드라이베르무트"
        case peachTree = "피치트리"
        case grapeFruitLiqueur = "자몽리큐르"
        case cacaoLiqueur = "카카오리큐르"
        case cremeDeCassis = "크렘드카시스"
        case greenMintLiqueur = "그린민트리큐르"
        case campari = "캄파리"
        case kahlua = "깔루아"
        case blueCuraso = "블루큐라소"
        case malibu = "말리부"
        case bananaliqueur = "바나나리큐르"
        case amaretto = "아마레또"
        case triplesec = "트리플섹"
        case butterScotchLiqueur = "버터스카치리큐르"
        case angosturaBitters = "앙고스투라비터스"
        case brandy = "브랜디"
        
        case coke = "콜라"
        case tonicWater = "토닉워터"
        case milk = "우유"
        case orangeJuice = "오렌지주스"
        case cranBerryJuice = "크렌베리주스"
        case clubSoda = "탄산수"
        case grapeFruitJuice = "자몽주스"
        case pineappleJuice = "파인애플주스"
        case gingerAle = "진저에일"
        case sweetAndSourMix = "스윗앤사워믹스"
        case appleJuice = "사과주스"
        case cider = "사이다"
        case lemonJuice = "레몬주스"
        
        case whiteRum = "화이트럼"
        case darkRum = "다크럼"
        case overProofRum = "오버프루프럼"
        
        case lime = "라임"
        case limeSqueeze = "라임즙"
        case limeSyrup = "라임시럽"
        case lemon = "레몬"
        case lemonSqueeze = "레몬즙"
        case appleMint = "애플민트"
        case whippingCream = "휘핑크림"
        case honey = "꿀"
        case olive = "올리브"
        case oliveJuice = "올리브주스"
        case sugar = "설탕"
        case sugarSyrup = "설탕시럽"
        case rawCream = "생크림"
        case grenadineSyrup = "그레나딘시럽"
        
//        var list: [String] {
//            get {
//                switch whatIPicked {
//                case "진":
//                    return ["진"]
//                case "보드카":
//                    return ["보드카"]
//                case "위스키":
//                    return ["스카치위스키", "버번위스키", "라이위스키", "위스키", "잭다니엘"]
//                case "데킬라":
//                    return ["데킬라"]
//                case "리큐르":
//                    return ["베일리스", "멜론리큐르", "화이트카카오리큐르", "스위트베르무트" , "피치트리", "자몽리큐르", "카카오리큐르", "크렘드카시스", "그린민트리큐르", "캄파리", "깔루아", "블루큐라소", "말리부", "바나나리큐르", "아마레또", "트리플섹", "버터스카치리큐르", "드라이베르무트" ]
//                case "브랜디":
//                    return ["브랜디"]
//                case "음료":
//                    return ["콜라", "토닉워터", "우유", "오렌지주스", "크렌베리주스", "탄산수", "자몽주스", "파인애플주스", "진저에일", "스윗앤사워믹스", "사과주스", "사이다", "레몬주스"]
//                case "럼":
//                    return ["오버프루프럼", "화이트럼", "다크럼"]
//                case "Asset":
//                    return ["라임", "라임즙", "레몬", "애플민트", "꿀", "올리브", "레몬즙", "올리브주스", "설탕시럽", "휘핑크림", "설탕", "생크림", "라임시럽", "그레나딘시럽"]
//                default:
//                    return []
//                }
//            }
//        }
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
    
}

//realm은 일단 보류
//class MyDrinks: Object {
//    @objc dynamic var name: String = ""
//    override static func primaryKey() -> String? {
//          return "name"
//        }
//}



