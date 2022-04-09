//
//  ViewController.swift
//  Cocktail
//
//  Created by 강희성 on 2022/04/09.
//

import UIKit
import SnapKit

/// 로딩뷰를 가진 뷰 컨트롤러
class ViewController: UIViewController {
    private lazy var loadingView = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(loadingView)
        self.loadingView.isHidden = true
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    /// 로딩문구를 설정해준다
    func setLoadingTitile(text: String) {
        self.loadingView.explainLabel.text = text
    }
    /// 로딩 시작
    func startLoading() {
        self.loadingView.isHidden = false
    }
    /// 로딩 종료
    func stopLoading() {
        self.loadingView.isHidden = true
    }
}
