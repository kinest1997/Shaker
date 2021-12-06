import UIKit

struct MyDrinks: Codable, Hashable {
    var iHave: Bool
    var base: Cocktail.Base
    let name: Cocktail.Ingredients
}

protocol CocktailCondition {
    var rawValue: String { get }
}

struct YouTubeVideo: Codable {
    let videoName: String
    let videoCode: String
    let owner: YouTubeOwner
}

enum YouTubeOwner: String, Codable {
    case homeTendingDictionary
    case drinkLover
    case drinkLecture
    case linibini
    case mansHobby
    case yancon
}

enum SortingStandard {
    case alcohol
    case name
    case ingredientsCount
    case wishList
}

struct Cocktail: Codable, Hashable {
    let name: String
    let craft: Craft
    var glass: Glass
    let recipe: [String]
    var ingredients: [Ingredients]
    let base: Base
    let alcohol: Alcohol
    let color: Color
    let mytip: String
    let drinkType: DrinkType
    var myRecipe: Bool
    var wishList: Bool
    var imageURL: String?
    
    enum Base: String, Codable, CaseIterable, CocktailCondition {
        case rum
        case vodka
        case tequila
        case brandy
        case whiskey
        case gin
        case liqueur
        case assets
        case beverage
        
        var list: [Ingredients] {
            switch self {
            case .gin:
                return [Cocktail.Ingredients.gin, Cocktail.Ingredients.bombaySapphire,Cocktail.Ingredients.tanquerayNoTen]
            case .rum:
                return [Cocktail.Ingredients.darkRum, Cocktail.Ingredients.whiteRum, Cocktail.Ingredients.overProofRum, Cocktail.Ingredients.bacardi]
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
            case .beverage:
                return [Cocktail.Ingredients.coke, Cocktail.Ingredients.tonicWater, Cocktail.Ingredients.milk, Cocktail.Ingredients.orangeJuice, Cocktail.Ingredients.cranBerryJuice, Cocktail.Ingredients.clubSoda, Cocktail.Ingredients.grapeFruitJuice, Cocktail.Ingredients.pineappleJuice, Cocktail.Ingredients.gingerAle, Cocktail.Ingredients.sweetAndSourMix, Cocktail.Ingredients.appleJuice, Cocktail.Ingredients.cider, Cocktail.Ingredients.lemonJuice]
            case .assets:
                return [Cocktail.Ingredients.lime, Cocktail.Ingredients.limeSqueeze, Cocktail.Ingredients.limeSyrup, Cocktail.Ingredients.lemon, Cocktail.Ingredients.lemonSqueeze, Cocktail.Ingredients.appleMint, Cocktail.Ingredients.whippingCream, Cocktail.Ingredients.honey, Cocktail.Ingredients.olive, Cocktail.Ingredients.oliveJuice, Cocktail.Ingredients.sugar, Cocktail.Ingredients.sugarSyrup, Cocktail.Ingredients.rawCream, Cocktail.Ingredients.grenadineSyrup]
            }
        }
    }
    
    enum DrinkType: String, Codable, CaseIterable, CocktailCondition {
        case longDrink
        case shortDrink
        case shooter
    }
    
    enum Color: String, Codable, CaseIterable, CocktailCondition {
        case red
        case orange
        case yellow
        case green
        case blue
        case violet
        case brown
        case black
        case clear
    }
    
    enum Alcohol: String, Codable, CaseIterable, CocktailCondition {
        case extreme
        case high
        case mid
        case low
        var rank: Int {
            switch self {
            case .extreme:
                return 4
            case .high:
                return 3
            case .mid:
                return 2
            case .low:
                return 1
            }
        }
    }
    
    enum Glass: String, Codable, CaseIterable, CocktailCondition {
        case highBall
        case shot
        case onTheRock
        case cocktail
        case martini
        case collins
        case margarita
        case philsner
    }
    
    enum Craft: String, Codable, CaseIterable, CocktailCondition {
        case build
        case shaking
        case floating
        case stir
        case blending
    }
    
    enum Ingredients: String, Codable, CaseIterable {
        case gin
        case bombaySapphire
        case tanquerayNoTen
        
        case vodka
        
        case whiskey
        case scotchWhiskey
        case bourbonWhiskey
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
        case angosturaBitters
        
        case brandy
        
        case coke
        case tonicWater
        case milk
        case orangeJuice
        case cranBerryJuice
        case clubSoda
        case grapeFruitJuice
        case pineappleJuice
        case gingerAle
        case sweetAndSourMix
        case appleJuice
        case cider
        case lemonJuice
        
        case whiteRum
        case darkRum
        case overProofRum
        case bacardi
        
        case lime
        case limeSqueeze
        case limeSyrup
        case lemon
        case lemonSqueeze
        case appleMint
        case whippingCream
        case honey
        case olive
        case oliveJuice
        case sugar
        case sugarSyrup
        case rawCream
        case grenadineSyrup
    }
}
