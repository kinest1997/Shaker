//
//  SearchController.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/21.
//

import RxSwift
import RxCocoa
import UIKit

protocol SearchControllerBindable {
    
    var inputTexts: PublishRelay<String> { get }
    
    var outPuts: Signal<String> { get }
}

class SearchController: UISearchController {
    
    let disposeBag = DisposeBag()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute() {
        self.searchBar.placeholder = "Name, Ingredients, Base, Glass, Color...".localized
        self.searchBar.searchTextField.font = .nexonFont(ofSize: 14, weight: .semibold)
        self.searchBar.keyboardType = .default
        self.definesPresentationContext = true
    }
    
    func bind(_ viewModel: SearchControllerBindable) {
        self.searchBar.rx.text
            .map { $0 ?? ""}
            .bind(to: viewModel.inputTexts)
            .disposed(by: disposeBag)
    }
}
