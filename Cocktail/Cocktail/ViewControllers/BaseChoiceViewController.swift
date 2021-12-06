//
//  BaseChoiceViewController.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/06.
//

import Foundation
import UIKit

class BaseChoiceViewController: UIViewController {
    
    var filteredRecipe: [Cocktail] = []
    
    let mainBigStackView = UIStackView()
    let leftStackView = UIStackView()
    let middleStackView = UIStackView()
    let rightStackView = UIStackView()
    
    
    let ginButton = UIButton()
    let tequilaButton = UIButton()
    let rumButton = UIButton()
    let vodkaButton = UIButton()
    let brandyButton = UIButton()
    let whiskeyButton = UIButton()
    let liqueorButton = UIButton()
    let anyThingButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func layout() {
        
    }
    
    func attribute() {
        
    }
}
