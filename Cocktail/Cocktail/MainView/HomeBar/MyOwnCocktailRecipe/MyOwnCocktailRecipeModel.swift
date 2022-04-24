//
//  MyOwnCocktailRecipeModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/14.
//

import Foundation
import RxSwift
import RxCocoa
import RxAppState
import FirebaseAuth
import FirebaseStorage

struct MyOwnCocktailRecipeModel {

    let uid = FirebaseRecipe.shared.uid

    let ref = FirebaseRecipe.shared.ref

    func getMyRecipeRx() -> Single<[Cocktail]> {
        return Single.create {observer in
            ref.child("users").child(uid!).child("MyRecipes").observeSingleEvent(of: .value) { snapshot in
                guard let value = snapshot.value as? [[String: Any]],
                      let data = try? JSONSerialization.data(withJSONObject: value, options: []),
                      let cocktailList = try? JSONDecoder().decode([Cocktail].self, from: data) else {
                          observer(.success([Cocktail]()))
                          return }
                return observer(.success(cocktailList))
            }
            return Disposables.create()
        }
    }

    func deleteWishList(list: [Cocktail], cocktail: Cocktail) {
        var newCocktail = cocktail
        newCocktail.wishList = true
        guard let number = list.firstIndex(of: newCocktail) else { return }
        var modifiedList = list
        modifiedList.remove(at: number)
        guard let data = try? JSONEncoder().encode(modifiedList),
              let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
              let uid = uid else { return }
        ref.child("users").child(uid).child("WishList").setValue(jsonData)
    }

    func deleteMyRecipe(list: [Cocktail], cocktail: Cocktail) {
        guard let number = list.firstIndex(of: cocktail) else { return }
        var modifiedList = list
        modifiedList.remove(at: number)
        guard let data = try? JSONEncoder().encode(modifiedList),
              let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
              let uid = uid else { return }
        ref.child("users").child(uid).child("MyRecipes").setValue(jsonData)

        let storage = Storage.storage()
        let url = cocktail.imageURL
        let storageRef = storage.reference(forURL: url)

        storageRef.delete { error in
            if let error = error {
                print(error)
            }
        }
    }
}
