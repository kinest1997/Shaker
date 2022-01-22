//
//  SearchController.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/21.
//

import RxSwift
import RxCocoa
import UIKit

protocol SearchControllerBindble {
    
    var inputTexts: PublishRelay<String> { get }
    
    var outPuts: Signal<String> { get }
}

class SearchController: UISearchController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    func attribute() {
        self.searchBar.placeholder = "Name, Ingredients, Base, Glass, Color...".localized
        self.searchBar.searchTextField.font = .nexonFont(ofSize: 14, weight: .semibold)
        self.searchBar.keyboardType = .default
        self.definesPresentationContext = true
        
    }
    
    func bind(_ viewModel: SearchControllerBindble) {
        self.searchBar.rx.text
            .map { $0 ?? ""}
            .bind(to: viewModel.inputTexts)
            .disposed(by: disposeBag)
    }
}
