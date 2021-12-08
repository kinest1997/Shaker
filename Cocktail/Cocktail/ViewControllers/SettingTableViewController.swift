//
//  SettingTableViewController.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/04.
//

import UIKit
import SnapKit
import FirebaseAuth
import StoreKit     //For AppStore Review Request
import MessageUI    //For Send Email

class SettingTableViewController: UITableViewController {
    enum Settings: Int, CaseIterable {
        case serviceInformation
        case alarm
        case support
        case developerInfo
        case account
        
        var sectionTitle: String {
            switch self {
            case .serviceInformation:
                return "Service Information".localized
            case .alarm:
                return "Alarm".localized
            case .support:
                return "Support".localized
            case .developerInfo:
                return "DeveloperInfo".localized
            case .account:
                return "Account".localized
            }
        }
        
        var rowTitles: [String] {
            switch self {
            case .serviceInformation:
                return ["공지사항", "버전정보 \(String(describing: Bundle.main.infoDictionary?["CFBundleShortVersionString"]))", "오픈소스라이브러리", "이용약관", "개인정보 처리방침"]
            case .alarm:
                return ["Alarm Setting"]
            case .support:
                return ["Review Shaker in the App Store".localized, "Join the Shaker TestFlight".localized]
            case .developerInfo:
                return ["GitHub", "LinkedIn", "Instagram"]
            case .account:
                return Auth.auth().currentUser == nil ? ["LogIn".localized] : ["LogOut".localized]
            }
        }
        
        var actions: [Void] {
            switch self {
            case .serviceInformation:
                return [print()]
            case .alarm:
                return []
            case .support:
                return [
                    requestAppStoreReview(),
                    setlinkAction(appURL: "itms-beta://", webURL: "")
                ]
            case .developerInfo:
                return [
                    setlinkAction(appURL: "github://profile/kinest1997/", webURL: "https://github.com/kinest1997"),
                    setlinkAction(appURL: "linkedin://profile/heesung-kang-kinest1997", webURL: "https://www.linkedin.com/in/heesung-kang-kinest1997"),
                    setlinkAction(appURL: "instagram://user?username=kinest1997", webURL: "https://instagram.com/kinest1997")
                ]
            case .account:
                return Auth.auth().currentUser == nil ? [logIn()] : [logOut()]
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "normalCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

///UITableView DataSource & Delegate
extension SettingTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Settings.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Settings(rawValue: section)?.sectionTitle
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Settings(rawValue: section)?.rowTitles.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Settings(rawValue: indexPath.section)?.actions[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = Settings(rawValue: indexPath.section)?.rowTitles[indexPath.row]
        cell.contentConfiguration = content
        
        switch indexPath.section {
        case 1:
            let accessorySwitch = UISwitch()
            UNUserNotificationCenter.current().getNotificationSettings { data in
                if data.notificationCenterSetting == .enabled {
                    DispatchQueue.main.async {
                        accessorySwitch.isOn = true
                    }
                } else {
                    DispatchQueue.main.async {
                        accessorySwitch.isOn = false
                    }
                }
            }
            accessorySwitch.addTarget(self, action: #selector(switchAction(sender:)), for: .valueChanged)
            cell.accessoryView = accessorySwitch
            return cell
        default:
            return cell
        }
    }
    
    @objc func switchAction(sender: UISwitch) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
}

///Actions per indexPath.row
extension SettingTableViewController {
    static private func requestAppStoreReview() {
        guard let appStoreURL = URL(string: "https://apps.apple.com/app/id") else { return }    //TODO: 앱아이디 입력해줄 것 예)id100043049583
        var components = URLComponents(url: appStoreURL, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "action", value: "write-review")]
        guard let writeReviewURL = components?.url else { return }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
    
    static private func setlinkAction(appURL: String, webURL: String){
        let appURL = URL(string: appURL)!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            let webURL = URL(string: webURL)!
            application.open(webURL)
        }
    }
    
    static private func logIn() {
        UIApplication.topMostViewController(self.rootViewController)?.show(LoginViewController(), sender: nil)
    }
    
    static private func logOut() {
        UserDefaults.standard.set(true, forKey: "firstLaunch")
        let alert = UIAlertController(title: "Do you want to log out?".localized, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes".localized, style: .default) { _ in
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let error {
                print(error)
            }
            FirebaseRecipe.shared.myRecipe = []
            FirebaseRecipe.shared.wishList = []
        })
        alert.addAction(UIAlertAction(title: "No".localized, style: .cancel, handler: nil))
        UIApplication.topMostViewController(self.rootViewController)?.present(alert, animated: true)
    }
}
