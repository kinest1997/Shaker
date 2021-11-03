//
//  MainViewController.swift
//  Cocktail
//
//  Created by 강희성 on 2021/11/02.
//

import Foundation
import UIKit

class MainViewController: UITabBarController {
    enum Tab: Int {
        case today
        case recipe
        case home
        case preference
    }
    
    let todayCocktailViewController = TodayCocktailViewController()
    let cocktailRecipeViewController = CocktailRecipeViewController()
    let homeBarViewController = HomeBarViewController()
    let settingsViewController = SettingsViewController()
    
    
    let tabBarItems: [Tab: UITabBarItem] = [
        .today: UITabBarItem(title: "추천", image: UIImage(systemName: "eyeglasses"), selectedImage: UIImage(systemName: "eyes.inverse")),
        .recipe: UITabBarItem(title: "레시피", image: UIImage(systemName: "book.closed.fill"), selectedImage: UIImage(systemName: "list.bullet")),
        .home: UITabBarItem(title: "내술장", image: UIImage(systemName: "mustache.fill"), selectedImage: UIImage(systemName: "mustache.fill")),
        .preference: UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape.fill"), selectedImage: UIImage(systemName: "gearshape.fill"))
    ]

    
    override func viewDidLoad() {
        
        tabBar.tintColor = .systemBrown
        tabBar.backgroundColor = .darkGray
        super.viewDidLoad()
        self.tabBar.barStyle = .default
        //attribute
        todayCocktailViewController.tabBarItem = tabBarItems[.today]
        cocktailRecipeViewController.tabBarItem = tabBarItems[.recipe]
        homeBarViewController.tabBarItem = tabBarItems[.home]
        settingsViewController.tabBarItem = tabBarItems[.preference]
        //..
        self.viewControllers = [
            UINavigationController(rootViewController: todayCocktailViewController),
            UINavigationController(rootViewController: cocktailRecipeViewController),
            UINavigationController(rootViewController: homeBarViewController),
            UINavigationController(rootViewController: settingsViewController)
        ]
    }
}
