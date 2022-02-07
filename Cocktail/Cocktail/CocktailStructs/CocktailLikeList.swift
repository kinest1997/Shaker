//
//  CocktailLikeList.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/09.
//

import Foundation

// 칵테일 좋아요 정보 관련 객체
struct CocktailLikeList: Codable {
    let cocktail: [String: CocktailLikeCount]
}
// 칵테일의 이름 경로 아래에 좋아요를 누를때마다 그사람의 uid 가 추가되고 좋아요일경우 true, 싫어요일 경우 false
struct CocktailLikeCount: Codable {
    var people: [String: Bool] = [:]
}
