//
//  SettingDetailView.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/22.
//

import UIKit
import SnapKit
import MessageUI

class SettingDetailViewController: UIViewController {
    enum Developers: Int, CaseIterable {
        case developer
        case illustrator
        case mainDesigner
        case subDesigner
        
        var sectionTitle: String {
            switch self {
            case .developer:
                return "개발자"
            case .illustrator:
                return "일러스트레이터"
            case .mainDesigner:
                return "메인디자이너"
            case .subDesigner:
                return "서브디자이너"
            }
        }
        
        var rowTitle: [String] {
            switch self {
            case .developer:
                return ["GitHub", "LinkedIn", "Instagram"]
            case .illustrator:
                return ["Instagram", "Email"]
            case .mainDesigner:
                return ["Instagram"]
            case .subDesigner:
                return ["Instagram"]
            }
        }
    }
    
    let mainTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainTableView)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        mainTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func sendEmail(address: String) {
        let composeVC = MFMailComposeViewController()
         composeVC.mailComposeDelegate = self
         // Configure the fields of the interface.
         composeVC.setToRecipients([address])
         composeVC.setSubject("제목을 입력하세요")
         composeVC.setMessageBody("내용을 입력하세요", isHTML: false)
         // Present the view controller modally.
         self.present(composeVC, animated: true, completion: nil)
    }
}

extension SettingDetailViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Developers(rawValue: section)?.rowTitle.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        cell.selectionStyle = .none
        var content = cell.defaultContentConfiguration()
        content.text = Developers(rawValue: indexPath.section)?.rowTitle[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Developers(rawValue: section)?.sectionTitle
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                setlinkAction(appURL: "github://profile/kinest1997/", webURL: "https://github.com/kinest1997")
            case 1:
                setlinkAction(appURL: "linkedin://profile/heesung-kang-kinest1997", webURL: "https://www.linkedin.com/in/heesung-kang-kinest1997")
            case 2:
                setlinkAction(appURL: "instagram://user?username=kinest1997", webURL: "https://instagram.com/kinest1997")
            default:
                return
            }
        case 1:
            switch indexPath.row {
            case 0:
                setlinkAction(appURL: "instagram://user?username=wonseok_artwork", webURL: "https://instagram.com/wonseok_artwork")
            case 1:
                sendEmail(address: "wsj7860@naver.com")
            default:
                return
            }
        case 2:
            setlinkAction(appURL: "instagram://user?username=soorea_effect", webURL: "https://instagram.com/soorea_effect")
        case 3:
            setlinkAction(appURL: "instagram://user?username=bo5min", webURL: "https://instagram.com/bo5min")
        default:
            return
        }
    }
    
    private func setlinkAction(appURL: String, webURL: String){
        let appURL = URL(string: appURL)!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            let webURL = URL(string: webURL)!
            application.open(webURL)
        }
    }
}
