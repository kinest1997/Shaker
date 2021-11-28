//
//  test.swift
//  Cocktail
//
//  Created by 강희성 on 2021/11/26.
//

import SwiftUI

struct CocktailSmallView: View {
    var configuration: Cocktail
    
    var body: some View {
        VStack  {
            Image(uiImage: UIImage(named: configuration.name) ?? UIImage(systemName: "circle")!)
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
            Spacer()
            Text(configuration.name)
                .foregroundColor(.blue)
            Text(configuration.alcohol.rawValue)
                .foregroundColor(.gray)
        }
    }
}

//struct test_Previews: PreviewProvider {
//    static var previews: some View {
//        let configuration = Cocktail(name: "바보", craft: .blending, glass: .cocktail, recipe: "갈아", ingredients: [.amaretto], base: .assets, alcohol: .high, color: .black, mytip: "머겅", drinkType: .longDrink, myRecipe: true, wishList: false)
//        Test(configuration: configuration)
//            .frame(width: 400, height: 400)
//.previewInterfaceOrientation(.landscapeLeft)
//    }
//}
