import UIKit
var recipe: [Cocktail] = []
let bundleURL = Bundle.main.url(forResource: "Cocktail", withExtension: "plist")

let cocktailData = FileManager.default.contents(atPath: bundleURL!.path)

do {
    recipe = try PropertyListDecoder().decode([Cocktail].self, from: cocktailData!).sorted {
        $0.name < $1.name
    }
}

let data = recipe.map {
    $0.name
}
print(data)



