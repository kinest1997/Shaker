//
//  YouTube.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/09.
//

import Foundation

//유튜브 관련 컨텐츠 받아오는 객체
struct YouTubeVideo: Codable {
    let videoName: String
    let videoCode: String
    let owner: YouTubeOwner
}

enum YouTubeOwner: String, Codable {
    case homeTendingDictionary
    case drinkLover
    case drinkLecture
    case linibini
    case mansHobby
    case yancon
}
