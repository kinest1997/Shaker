import UIKit
import FirebaseDatabase
import FirebaseAuth
import AuthenticationServices

///유저의 개인 취향을 저장하는곳, 설정에서 나중에 취향 재설정 가능하게 하자
class UserFavor {
    static let shared = UserFavor()
    
    var colorFavor: [Cocktail.Color] = []
    
    var alcoholFavor: [Cocktail.Alcohol] = []
    
    var firstLogin: Bool = true
    
    //무슨 취향들을 추가해볼까나 일단 좋아하는 베이스? 일단 고민중
    
    private init() { }
}


class FireBase {
    static let shared = FireBase()
    
    var ref = Database.database().reference()
    
    var recipe: [Cocktail] = []
    
    var wishList: [Cocktail] = []
    
    var myRecipe: [Cocktail] = []
    
    let uid = Auth.auth().currentUser?.uid
    
    func getRecipe(completion: @escaping ([Cocktail]) -> (Void)) {
        Database.database().reference().child("CocktailList").getData { error, snapshot in
            guard let value = snapshot.value as? [[String: Any]],
                  let data = try? JSONSerialization.data(withJSONObject: value, options: []),
                  let cocktailList = try? JSONDecoder().decode([Cocktail].self, from: data) else { return print("이것이 에러다",error)}
            completion(cocktailList)
        }
        
        //        Database.database().reference().child("CocktailList").observeSingleEvent(of: .value) { snapshot in
        //            guard let value = snapshot.value as? [[String: Any]],
        //                  let data = try? JSONSerialization.data(withJSONObject: value, options: []),
        //                  let cocktailList = try? JSONDecoder().decode([Cocktail].self, from: data) else { return }
        //            completion(cocktailList)
        //        }
    }
    
    func getMyRecipe(completion: @escaping ([Cocktail]) -> (Void)) {
        guard let uid = uid else { return }
        self.ref.child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [[String: Any]],
                  let data = try? JSONSerialization.data(withJSONObject: value, options: []),
                  let cocktailList = try? JSONDecoder().decode([Cocktail].self, from: data) else { return }
            completion(cocktailList)
        }
    }
    
    func uploadWishList() {
        guard let data = try? JSONEncoder().encode(FireBase.shared.wishList),
              let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
              let uid = uid else { return }
        self.ref.child("users").child(uid).child("WishList").setValue(jsonData)
    }
    
    func uploadMyRecipe() {
        guard let data = try? JSONEncoder().encode(FireBase.shared.recipe),
              let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
              let uid = uid else { return }
        self.ref.child("users").child(uid).setValue(jsonData)
    }
    
    func uploadWholeRecipe() {
        let cocktailList = getJSONRecipe()
        guard let data = try? JSONEncoder().encode(cocktailList) else { return }
        let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
        Database.database().reference().child("CocktailList").setValue(jsonData)
    }
    
    func getJSONRecipe() -> [Cocktail] {
        guard let bundleURL = Bundle.main.url(forResource: "CocktailJSON", withExtension: "json"),
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
