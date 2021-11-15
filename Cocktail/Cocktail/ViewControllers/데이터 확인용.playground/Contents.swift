import UIKit

var myRecipe: [Cocktail] = []

var ingredients: Set<String> = []
getRecipe(data: &myRecipe)
//
//myRecipe.filter {
//    $0.base ==
//}.forEach {
//    for i in $0.ingredients[0...] {
//        ingredients.insert(i)
//    }
////    if $0.ingredients.contains("아마레도") {
////        print($0)
////    }
//
//}
//ingredients.sorted {$0 < $1
//}
//
//print("----------------")
//
//print(ingredients.count)

struct MyDrinks: Codable {
    var iHave: Bool = false
    var ingredients: Cocktail.Ingredients
}
