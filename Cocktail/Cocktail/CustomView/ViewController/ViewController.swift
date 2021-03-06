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
    /// 맥주모양 로딩뷰
    private lazy var loadingView = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(loadingView)
        self.loadingView.isHidden = true
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    /// 로딩 시작및 로딩 문구를 설정해준다
    func startLoading(text: String = "") {
        self.view.bringSubviewToFront(loadingView)
        self.loadingView.explainLabel.text = text
        self.loadingView.isHidden = false
    }
    
    /// 로딩 종료
    func stopLoading() {
        self.loadingView.isHidden = true
    }
}
