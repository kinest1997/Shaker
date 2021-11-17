import UIKit

var myRecipe: [Cocktail] = []

var ingredients: Set<String> = []
getRecipe(data: &myRecipe)
//
myRecipe.forEach {
    for i in $0.ingredients[0...] {
        ingredients.insert(i.rawValue)
    }
}
//ingredients.sorted {$0 < $1
//}
//
//print("----------------")
//
//print(ingredients.count)
print(ingredients.count)


struct MyDrinks: Codable {
    var iHave: Bool = false
    var base: Cocktail.Base
    var ingredients: Cocktail.Ingredients
}
