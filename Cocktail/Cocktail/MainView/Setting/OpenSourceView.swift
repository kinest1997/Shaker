//
//  OpenSourceView.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/04.
//

import Foundation
import SnapKit
import SafariServices
import UIKit

class OpenSourceView: UIViewController {
    let mainTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    enum OpenSource: Int, CaseIterable {
        case snapkit
        case lottie
        case rxSwift
        case kingfisher
        case firebase
        case siren
        
        var url: String {
            switch self {
            case .snapkit:
                return "https://github.com/SnapKit/SnapKit/blob/develop/LICENSE"
            case .lottie:
                return "https://github.com/airbnb/lottie-ios/blob/master/LICENSE"
            case .rxSwift:
                return "https://github.com/ReactiveX/RxSwift"
            case .kingfisher:
                return "https://github.com/onevcat/Kingfisher/blob/master/LICENSE"
            case .firebase:
                return "https://github.com/firebase/firebase-ios-sdk/blob/master/LICENSE"
            case .siren:
                return "https://github.com/ArtSabintsev/Siren/blob/master/LICENSE"
            }
        }
        
        var name: String {
            switch self {
            case .snapkit:
                return "SnapKit"
            case .lottie:
                return "Lottie"
            case .rxSwift:
                return "RxSwift"
            case .kingfisher:
                return "KingFisher"
            case .firebase:
                return "Firebase"
            case .siren:
                return "Siren"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(SettingCell.self, forCellReuseIdentifier: "SettingCell")
    }
}

extension OpenSourceView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OpenSource.allCases.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: OpenSource(rawValue: indexPath.row)!.url) else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as? SettingCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.mainLabel.text = OpenSource(rawValue: indexPath.row)?.name
        return cell
    }
}
