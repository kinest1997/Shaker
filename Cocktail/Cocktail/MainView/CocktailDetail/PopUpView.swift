//
//  PopUpView.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/05.
//

import Foundation
import UIKit
import SnapKit

class PopUpView: UIView {
    let textLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        textLabel.font = .nexonFont(ofSize: 16, weight: .semibold)
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.frame = CGRect(x: .zero, y: .zero, width: 180, height: 70)
        self.textLabel.textColor = .white

        self.backgroundColor = .mainGray
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func animating(text: String) {
        self.textLabel.text = text
        self.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isHidden = true
        }
    }
    // 애니메이션 작동안해서 화남
//    var animating: Bool = false {
//        willSet {
//            self.isHidden = false
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                self.isHidden = true
//            }
//
//            //            UIView.animate(withDuration: 1, delay: 0, options: .transitionCrossDissolve) {
//            //                self.textLabel.textColor = .black
//            //                self.backgroundColor = .borderGray
//            //            } completion: { bool in
//            //                self.backgroundColor = .clear
//            //                self.textLabel.textColor = .clear
//            //            }
//        }
//    }
}
