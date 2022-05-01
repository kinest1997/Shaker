//
//  RxController.swift
//  Cocktail
//
//  Created by 강희성 on 2022/05/01.
//

import UIKit
import RxSwift

/// rx를 사용하는 뷰 컨트롤러
protocol RxController {
    var disposeBag: DisposeBag { get }
}

extension RxController {
}
