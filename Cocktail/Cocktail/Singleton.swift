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
    
    func makeAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title.localized, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: nil))
        return alert
    }
    
    private init() { }
}

class ContentNetwork {
    static let shared = ContentNetwork()
    
    func setlinkAction(appURL: String, webURL: String){
        let appURL = URL(string: appURL)!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            let webURL = URL(string: webURL)!
            application.open(webURL)
        }
    }
}

class FirebaseRecipe {
    static let shared = FirebaseRecipe()
    
    let ref = Database.database().reference()
    
    var recipe: [Cocktail] = []
    
    var wishList: [Cocktail] = []
    
    var myRecipe: [Cocktail] = []
    
    var youTubeData: [YouTubeVideo] = []
    
    var cocktailLikeList: [String:[String: Bool]] = [:]
    
    let uid = Auth.auth().currentUser?.uid
    
    func getRecipe(completion: @escaping ([Cocktail]) -> (Void)) {
        ref.child("CocktailRecipes").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [[String: Any]],
                  let data = try? JSONSerialization.data(withJSONObject: value, options: []),
                  let cocktailList = try? JSONDecoder().decode([Cocktail].self, from: data) else {
                      completion([Cocktail]())
                      return }
            completion(cocktailList)
        }
    }
    
    func getMyRecipe(completion: @escaping ([Cocktail]) -> (Void)) {
        guard let uid = uid else { return }
        ref.child("users").child(uid).child("MyRecipes").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [[String: Any]],
                  let data = try? JSONSerialization.data(withJSONObject: value, options: []),
                  let cocktailList = try? JSONDecoder().decode([Cocktail].self, from: data) else {
                      completion([Cocktail]())
                      return }
            let myRecipes = cocktailList.filter { $0.myRecipe == true }
            completion(myRecipes)
        }
    }
    
    func getWishList(completion: @escaping ([Cocktail]) -> (Void)) {
        guard let uid = uid else { return }
        ref.child("users").child(uid).child("WishList").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [[String: Any]],
                  let data = try? JSONSerialization.data(withJSONObject: value, options: []),
                  let cocktailList = try? JSONDecoder().decode([Cocktail].self, from: data) else {
                      completion([Cocktail]())
                      return }
            let myRecipes = cocktailList.filter { $0.wishList == true }
            completion(myRecipes)
        }
    }
    
    func getYoutubeContents(completion: @escaping ([YouTubeVideo]) -> (Void)) {
        ref.child("Youtube").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [[String: Any]],
                  let data = try? JSONSerialization.data(withJSONObject: value, options: []),
                  let youTubeVideoList = try? JSONDecoder().decode([YouTubeVideo].self, from: data) else {
                      completion([YouTubeVideo]())
                      return }
            completion(youTubeVideoList)
        }
    }
    
    func getCocktailLikeData(completion: @escaping ([String:[String: Bool]]) -> (Void)) {
        Database.database().reference().child("CocktailLikeData").observe( .value) { snapshot in
            guard let value = snapshot.value as? [String:[String: Bool]] else { return }
            completion(value)
        }
    }
    
    func getSingleCocktialData(cocktail: Cocktail, completion: @escaping ([String: Bool]) -> (Void)) {
        Database.database().reference().child("CocktailLikeData").child(cocktail.name).observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Bool] else {
                completion([:])
                return  }
            completion(value)
        }
    }
    
    func likeOrDislikeCount(cocktailList: [String: Bool], choice: Bool) -> Int {
        switch choice {
        case true:
            return cocktailList.filter { $0.value == true }.count
        case false:
            return cocktailList.filter { $0.value == false }.count
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
        Database.database().reference().child("CocktailRecipes").setValue(jsonData)
    }
    
    func addLike(cocktail: Cocktail) {
        guard let uid = uid else { return }
        Database.database().reference().child("CocktailLikeData").child(cocktail.name).child(uid).setValue(true)
    }
    
    func uploadId(cocktail: Cocktail) {
        Database.database().reference().child("CocktailLikeData").child(cocktail.name).child("id").setValue(cocktail.name)
    }
    
    func addDislike(cocktail: Cocktail) {
        guard let uid = uid else { return }
        Database.database().reference().child("CocktailLikeData").child(cocktail.name).child(uid).setValue(false)
    }
    
    func deleteLike(cocktail: Cocktail) {
        guard let uid = uid else { return }
        Database.database().reference().child("CocktailLikeData").child(cocktail.name).child(uid).setValue(nil)
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
    
    func uploadyoutube() {
        guard let data = try? JSONEncoder().encode([YouTubeVideo(videoName: "firstName", videoCode: "HzxdVaKaPyA", owner: .drinkLecture)]),
              let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else { return }
        Database.database().reference().child("Youtube").setValue(jsonData)
    }
    private init() { }
}
