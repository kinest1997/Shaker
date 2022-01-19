//
//  CocktailDetailModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/11.
//

import Foundation
import FirebaseDatabase
import RxCocoa
import RxSwift

struct CocktailDetailModel {
    
    func getSingleCocktialData(cocktail: Cocktail, completion: @escaping ([String: Bool]) -> (Void)) {
        Database.database().reference().child("CocktailLikeData").child(cocktail.name).observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Bool] else {
                completion([:])
                return  }
            completion(value)
        }
    }

    
}
