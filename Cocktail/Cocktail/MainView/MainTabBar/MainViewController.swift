//
//  MainViewController.swift
//  Cocktail
//
//  Created by 강희성 on 2021/11/02.
//

import Foundation
import UIKit
import Then

class MainViewController: UITabBarController {
    enum Tab: Int {
        case today
        case recipe
        case home
        case preference

        var name: String {
            switch self {
            case .today: return "Recommendation".localized
            case .recipe: return "Recipe".localized
            case .home: return "MyPage".localized
            case .preference: return "Preferneces".localized
            }
        }

        var image: UIImage? {
            switch self {
            case .today: return UIImage(systemName: "eyes")
            case .recipe: return UIImage(systemName: "book.closed")
            case .home: return UIImage(systemName: "mustache")
            case .preference: return UIImage(systemName: "gearshape")
            }
        }

        var selectedImage: UIImage? {
            switch self {
            case .today: return UIImage(systemName: "eyes.inverse")
            case .recipe: return UIImage(systemName: "book.closed.fill")
            case .home: return UIImage(systemName: "mustache.fill")
            case .preference: return UIImage(systemName: "gearshape.fill")
            }
        }
    }

    let todayCocktailCollectionViewController = TodayCocktailCollectionViewController()
    let cocktailRecipeViewController = CocktailRecipeViewController()
    let assistantViewController = AssistantViewController()
    let settingsViewController = SettingTableViewController(style: .insetGrouped)

    let assistantViewModel = AssistantViewModel()
    let cocktailRecipesViewModel = CocktailRecipeViewModel()

    let tabBarItems: [Tab: UITabBarItem] = [
        .today: UITabBarItem(title: Tab.today.name, image: Tab.today.image, selectedImage: Tab.today.selectedImage),
        .recipe: UITabBarItem(title: Tab.recipe.name, image: Tab.recipe.image, selectedImage: Tab.recipe.selectedImage),
        .home: UITabBarItem(title: Tab.home.name, image: Tab.home.image, selectedImage: Tab.home.selectedImage),
        .preference: UITabBarItem(title: Tab.preference.name, image: Tab.preference.image, selectedImage: Tab.preference.selectedImage)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .mainOrange
        self.tabBar.barStyle = .default
        todayCocktailCollectionViewController.tabBarItem = tabBarItems[.today]
        cocktailRecipeViewController.tabBarItem = tabBarItems[.recipe]
        assistantViewController.tabBarItem = tabBarItems[.home]
        settingsViewController.tabBarItem = tabBarItems[.preference]
        assistantViewController.bind(viewmodel: assistantViewModel)
        cocktailRecipeViewController.bind(cocktailRecipesViewModel)

        self.viewControllers = [
            UINavigationController(rootViewController: todayCocktailCollectionViewController),
            UINavigationController(rootViewController: cocktailRecipeViewController),
            UINavigationController(rootViewController: assistantViewController),
            UINavigationController(rootViewController: settingsViewController)
        ]
    }
}
