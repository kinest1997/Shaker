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
        .today: UITabBarItem(title: "오늘의 칵테일", image: UIImage(), selectedImage: UIImage()),
        .recipe: UITabBarItem(title: "레시피", image: UIImage(), selectedImage: UIImage()),
        .home: UITabBarItem(title: "내술장", image: UIImage(), selectedImage: UIImage()),
        .preference: UITabBarItem(title: "설정", image: UIImage(), selectedImage: UIImage())
    ]

    
    override func viewDidLoad() {
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
