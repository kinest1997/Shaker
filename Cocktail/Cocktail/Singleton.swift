import UIKit
import FirebaseDatabase
import FirebaseAuth
import AuthenticationServices

///유저의 개인 취향을 저장하는곳, 설정에서 나중에 취향 재설정 가능하게 하자

class UserFavor {
    static let shared = UserFavor()
    
    var colorFavor: [Cocktail.Color] = []
    
    var alcoholFavor: Cocktail.Alcohol?
    
    var drinkTypeFavor: Cocktail.DrinkType?
    
    var baseDrinkFavor: Cocktail.Base?
    
    private init() { }
}

class FirebaseRecipe {
    static let shared = FirebaseRecipe()
    
    var ref = Database.database().reference()
    
    var recipe: [Cocktail] = []
    
    var wishList: [Cocktail] = []
    
    var myRecipe: [Cocktail] = []
    
    let uid = Auth.auth().currentUser?.uid
    
    func getRecipe(completion: @escaping ([Cocktail]) -> (Void)) {
        ref.child("CocktailList").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [[String: Any]],
                  let data = try? JSONSerialization.data(withJSONObject: value, options: []),
                  let cocktailList = try? JSONDecoder().decode([Cocktail].self, from: data) else { return }
            completion(cocktailList)
        }
    }
    
    func getMyRecipe(completion: @escaping ([Cocktail]) -> (Void)) {
        guard let uid = uid else { return }
        ref.child("users").child(uid).child("MyRecipes").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [[String: Any]],
                  let data = try? JSONSerialization.data(withJSONObject: value, options: []),
                  let cocktailList = try? JSONDecoder().decode([Cocktail].self, from: data) else { return }
            let myRecipes = cocktailList.filter { $0.myRecipe == true }
            completion(myRecipes)
        }
    }
    
    func getWishList(completion: @escaping ([Cocktail]) -> (Void)) {
        guard let uid = uid else { return }
        ref.child("users").child(uid).child("WishList").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [[String: Any]],
                  let data = try? JSONSerialization.data(withJSONObject: value, options: []),
                  let cocktailList = try? JSONDecoder().decode([Cocktail].self, from: data) else { return }
            let myRecipes = cocktailList.filter { $0.wishList == true }
            completion(myRecipes)
        }
    }
    
    func uploadWishList() {
        guard let data = try? JSONEncoder().encode(FirebaseRecipe.shared.wishList),
              let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
              let uid = uid else { return }
        ref.child("users").child(uid).child("WishList").setValue(jsonData)
    }
    
    func uploadMyRecipe() {
        guard let data = try? JSONEncoder().encode(FirebaseRecipe.shared.myRecipe),
              let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
              let uid = uid else { return }
        ref.child("users").child(uid).child("MyRecipes").setValue(jsonData)
    }
    
    func uploadWholeRecipe() {
        let cocktailList = getJSONRecipe()
        guard let data = try? JSONEncoder().encode(cocktailList) else { return }
        let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
        Database.database().reference().child("CocktailList").setValue(jsonData)
    }
    
    func getJSONRecipe() -> [Cocktail] {
        guard let bundleURL = Bundle.main.url(forResource: "CocktailData", withExtension: "json"),
              let cocktailData = FileManager.default.contents(atPath: bundleURL.path) else { return [] }
        do {
            let cocktailList = try JSONDecoder().decode([Cocktail].self, from: cocktailData).sorted {
                $0.name < $1.name
            }
            return cocktailList
        } catch let error{
            print(String(describing: error))
            return []
        }
    }
    private init() { }
}
