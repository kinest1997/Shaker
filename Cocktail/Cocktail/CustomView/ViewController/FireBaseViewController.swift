//
//  FireBaseViewController.swift
//  Cocktail
//
//  Created by 강희성 on 2022/05/01.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

/// 파이어베이스를 사용하는 뷰컨트롤러
class FireBaseViewController: ViewController {
    let uid = Auth.auth().currentUser?.uid
    
    let ref = Database.database().reference()
}
