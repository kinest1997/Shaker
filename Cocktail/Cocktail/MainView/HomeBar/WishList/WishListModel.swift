//
//  WishListModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/12.
//

import Foundation
import RxCocoa
import RxSwift

struct WishListmodel {
    let uid = FirebaseRecipe.shared.uid

    let ref = FirebaseRecipe.shared.ref

    func getWishListRx() -> Single<[Cocktail]> {
        return Single.create { observer in
            ref.child("users").child(uid!).child("WishList").observe(.value) { snapshot in
                guard let value = snapshot.value as? [[String: Any]],
                      let data = try? JSONSerialization.data(withJSONObject: value, options: []),
                      let cocktailList = try? JSONDecoder().decode([Cocktail].self, from: data) else {
                          observer(.success([Cocktail]()))
                          return }
                observer(.success(cocktailList))
            }
            return Disposables.create()
        }
    }

    func deleteWishList(list: [Cocktail], cocktail: Cocktail) {
        guard let number = list.firstIndex(of: cocktail) else { return}
        var modifiedList = list
        modifiedList.remove(at: number)
        guard let data = try? JSONEncoder().encode(modifiedList),
              let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
              let uid = uid else { return }
        ref.child("users").child(uid).child("WishList").setValue(jsonData)
    }
}
