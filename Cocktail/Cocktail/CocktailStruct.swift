import UIKit

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
    
    enum Base: String, Codable, CaseIterable {
        case rum = "럼"
        case vodka = "보드카"
        case tequila = "데킬라"
        case brandy = "브랜디"
        case whiskey = "위스키"
        case gin = "진"
        case liqueur = "리큐르"
        case assets = "기타"
        case beverage = "음료"
        var list: [Ingredients] {
            switch self {
            case .gin:
                return [Cocktail.Ingredients.gin]
            case .rum:
                return [Cocktail.Ingredients.darkRum, Cocktail.Ingredients.whiteRum, Cocktail.Ingredients.overProofRum]
            case .vodka:
                return [Cocktail.Ingredients.vodka]
            case .tequila:
                return [Cocktail.Ingredients.tequila]
            case .brandy:
                return [Cocktail.Ingredients.brandy]
            case .whiskey:
                return [Cocktail.Ingredients.whiskey, Cocktail.Ingredients.ryeWhiskey, Cocktail.Ingredients.scotchWhiskey, Cocktail.Ingredients.bourbonWhiskey, Cocktail.Ingredients.jackDanielWhiskey]
            case .liqueur:
                return [Cocktail.Ingredients.baileys, Cocktail.Ingredients.melonLiqueur, Cocktail.Ingredients.whiteCacaoLiqueur, Cocktail.Ingredients.sweetVermouth, Cocktail.Ingredients.dryVermouth, Cocktail.Ingredients.peachTree, Cocktail.Ingredients.grapeFruitLiqueur, Cocktail.Ingredients.cacaoLiqueur, Cocktail.Ingredients.cremeDeCassis, Cocktail.Ingredients.greenMintLiqueur, Cocktail.Ingredients.campari, Cocktail.Ingredients.kahlua, Cocktail.Ingredients.blueCuraso, Cocktail.Ingredients.malibu, Cocktail.Ingredients.bananaliqueur, Cocktail.Ingredients.amaretto, Cocktail.Ingredients.triplesec, Cocktail.Ingredients.butterScotchLiqueur, Cocktail.Ingredients.angosturaBitters]
            case . assets:
                return [Cocktail.Ingredients.coke, Cocktail.Ingredients.tonicWater, Cocktail.Ingredients.milk, Cocktail.Ingredients.orangeJuice, Cocktail.Ingredients.cranBerryJuice, Cocktail.Ingredients.clubSoda, Cocktail.Ingredients.grapeFruitJuice, Cocktail.Ingredients.pineappleJuice, Cocktail.Ingredients.gingerAle, Cocktail.Ingredients.sweetAndSourMix, Cocktail.Ingredients.appleJuice, Cocktail.Ingredients.cider, Cocktail.Ingredients.lemonJuice]
            case .beverage:
                return [Cocktail.Ingredients.lime, Cocktail.Ingredients.limeSqueeze, Cocktail.Ingredients.limeSyrup, Cocktail.Ingredients.lemon, Cocktail.Ingredients.lemonSqueeze, Cocktail.Ingredients.appleMint, Cocktail.Ingredients.whippingCream, Cocktail.Ingredients.honey, Cocktail.Ingredients.olive, Cocktail.Ingredients.oliveJuice, Cocktail.Ingredients.sugar, Cocktail.Ingredients.sugarSyrup, Cocktail.Ingredients.rawCream, Cocktail.Ingredients.grenadineSyrup]
            }
        }
    }
    
    enum DrinkType: String, Codable {
        case longDrink = "롱드링크"
        case shortDrink =  "숏드링크"
        case shooter = "슈터"
    }
    
    enum Color: String, Codable {
        case red = "빨간색"
        case orange = "주황색"
        case yellow = "노란색"
        case green = "초록색"
        case blue = "파란색"
        case violet = "보라색"
        case clear = "투명색"
        case white = "하얀색"
        case black = "검은색"
        case brown = "갈색"
    }
    
    enum Alcohol: String, Codable {
        case high
        case mid
        case low
    }
    
    enum Glass: String, Codable {
        case highBall = "하이볼"
        case shot = "샷잔"
        case onTheRock = "온더락"
        case cocktail = "칵테일"
        case martini = "마티니"
        case collins = "콜린스"
        case margarita = "마가리타"
        case philsner = "필스너"
    }
    
    enum Craft: String, Codable {
        case build = "빌드"
        case shaking = "쉐이킹"
        case floating = "플로팅"
        case stir = "스터"
        case blending = "블렌딩"
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
    
        
        //        var base: String {
        //            switch self {
        //            case .vodka:
        //                return "보드카"
        //            case .gin:
        //                return "진"
        //            case .whiskey, .ryeWhiskey, .scotchWhiskey, .bourbonWhiskey, .jackDanielWhiskey:
        //                return "위스키"
        //            case .tequila:
        //                return "데킬라"
        //            case . baileys, .melonLiqueur, .whiteCacaoLiqueur, .sweetVermouth, .peachTree, .grapeFruitLiqueur, .cacaoLiqueur, .cremeDeCassis, .greenMintLiqueur, .campari, .kahlua, .blueCuraso, .malibu, .bananaliqueur, .amaretto, .triplesec, .butterScotchLiqueur, .dryVermouth:
        //                return "리큐르"
        //            default:
        //                return "없음"
        //            }
        //        }
    }
    
}

//realm은 일단 보류
//class MyDrinks: Object {
//    @objc dynamic var name: String = ""
//    override static func primaryKey() -> String? {
//          return "name"
//        }
//}




