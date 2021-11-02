import UIKit

struct Cocktail: Codable {
    let name: String
    let craft: Craft
    let glass: Glass
    let recipe: String
    let ingredients: [String]
    let base: Base
    let alcohol: Alcohol
    let color: Color
    let mytip: String?
    
    enum Base: String, Codable {
        case 럼
        case 보드카
        case 데킬라
        case 브랜디
        case 위스키
        case 진
        case 리큐르
    }
    
    enum Color: String, Codable {
        case 빨간색
        case 주황색
        case 노란색
        case 초록색
        case 파란색
        case 보라색
        case 투명색
        case 하얀색
        case 검은색
        case 갈색
        
    }
    
    enum Alcohol: String, Codable {
        case high
        case low
    }
    
    enum Glass: String, Codable {
        case 하이볼
        case 샷잔
        case 온더락
        case 칵테일
        case 마티니
        case 콜린스
        case 마가리타
        case 필스너
    }
    
    enum Craft: String, Codable {
        case 빌드
        case 쉐이킹
        case 플로팅
        case 스터
        case 블렌딩
    }
    
}




