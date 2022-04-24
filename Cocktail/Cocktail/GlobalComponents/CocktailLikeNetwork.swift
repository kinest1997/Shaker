//
//  CocktailLikeNetwork.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/11.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import RxSwift
import RxCocoa

struct CocktailLikeData {
    let iLike: Like
    let likeCount: Int
    let dislikeCount: Int
}

enum Like {
    case like
    case disLike
    case none
}

struct CocktailLikeNetwork {

    let ref = Database.database().reference()

    let uid = Auth.auth().currentUser?.uid

    func getSingleCocktialDataRx(cocktail: Cocktail) -> Single<[String: Bool]> {
        return Single.create { observer in
            Database.database().reference().child("CocktailLikeData").child(cocktail.name).observeSingleEvent(of: .value) { snapshot in
                guard let value = snapshot.value as? [String: Bool] else {
                    observer(.success([:]))
                    return  }
                observer(.success(value))
            }
            return Disposables.create()
        }
    }
    /// 칵테일에 대하여 내가 좋아요 싫어요를 눌렀는지 확인하는 함수
    func preferenceCheck(likeData: [String: Bool]) -> CocktailLikeData {
        var like: Like = .none
        var likeCount = 0
        var disLikeCount = 0

        if likeData.contains(where: { (key: String, _: Bool) in
            key == Auth.auth().currentUser?.uid
        }) {
            switch likeData[Auth.auth().currentUser!.uid] {
            case true:
                like = .like
            case false:
                like = .disLike
            default:
                like = .none
            }
        }

        likeCount = FirebaseRecipe.shared.likeOrDislikeCount(cocktailList: likeData, choice: true)
        disLikeCount = FirebaseRecipe.shared.likeOrDislikeCount(cocktailList: likeData, choice: false)

        return CocktailLikeData(iLike: like, likeCount: likeCount, dislikeCount: disLikeCount)
    }

    func addLike(cocktail: Cocktail) {
        guard let uid = uid else { return }
        Database.database().reference().child("CocktailLikeData").child(cocktail.name).child(uid).setValue(true)
    }

    func addDislike(cocktail: Cocktail) {
        guard let uid = uid else { return }
        Database.database().reference().child("CocktailLikeData").child(cocktail.name).child(uid).setValue(false)
    }

    func deleteLike(cocktail: Cocktail) {
        guard let uid = uid else { return }
        Database.database().reference().child("CocktailLikeData").child(cocktail.name).child(uid).setValue(nil)
    }

    func likeOrDislikeCount(cocktailList: [String: Bool], choice: Bool) -> Int {
        switch choice {
        case true:
            return cocktailList.filter { $0.value == true }.count
        case false:
            return cocktailList.filter { $0.value == false }.count
        }
    }
}
