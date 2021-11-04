import UIKit

func getRecipe(data: inout [Cocktail]) {
    guard let cocktailURL = Bundle.main.url(forResource: "Cocktail", withExtension: "plist"), let cocktailData = FileManager.default.contents(atPath: cocktailURL.path) else { return }
    do {
        data = try PropertyListDecoder().decode([Cocktail].self, from: cocktailData)
    } catch let error{
        print("머선129",error.localizedDescription)
        print(String(describing: error))
    }
}
