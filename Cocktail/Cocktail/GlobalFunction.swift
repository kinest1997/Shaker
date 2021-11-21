import UIKit

func getRecipe(data: inout [Cocktail]) {
    
    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Cocktail.plist")
    
    guard let cocktailData = FileManager.default.contents(atPath: documentURL.path) else { return }
    
//    guard let cocktailURL = Bundle.main.url(forResource: "Cocktail", withExtension: "plist"),
//          let cocktailData = FileManager.default.contents(atPath: cocktailURL.path) else { return }
    do {
        data = try PropertyListDecoder().decode([Cocktail].self, from: cocktailData).sorted {
            $0.name < $1.name
        }
        
    } catch let error{
        print("머선129",error.localizedDescription)
        print(String(describing: error))
    }
}
