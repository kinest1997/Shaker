//import UIKit
//
//let rawData0 = """
//    {"base": "보드카"}
//"""
//let rawData1 = """
//    {"base": "vodka"}
//"""
//
//struct MyData: Codable {
//    var base: Cocktail.Base
//
//    enum codingKeys: String, CodingKey {
//        case base
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        self.base = try container.decode(Base.self)
//    }
//}
//
//let data0 = rawData0.data(using: .utf8)
//let data1 = rawData1.data(using: .utf8)
//
//print("xxx0", data0)
//do {
//    let decode0 = try JSONDecoder().decode(MyData.self, from: data0!)
//    let decode1 = try JSONDecoder().decode(MyData.self, from: data1!)
//
////    print("xxx1", decode1[0])
//}
