//
//  SettingTableViewController.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/04.
//

import UIKit
import SnapKit
import FirebaseAuth

class SettingTableViewController: UITableViewController {
    //뭐 자세한 목차는 천천히 정하고..
    let firstSectionNames: [String] = ["공지사항", "버전정보", "오픈소스라이브러리", "이용약관", "개인정보 처리방침"]
    let developerSectionNames : [String] = ["GitHub", "LinkedIn", "Instagram"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "normalCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension SettingTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Service Information".localized
        case 1:
            return "Alarm".localized
        case 2:
            return "DeveloperInfo".localized
        case 3:
            return "Account".localized
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        case 1:
            return 1
        case 2:
            return 3
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 1:
                print()
            case 2:
                print()
            case 3:
                print()
            case 4:
                print()
            case 5:
                print()
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                print()
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                setlinkAction(appURL: "github://profile/kinest1997/", webURL: "https://github.com/kinest1997")
            case 1:
                setlinkAction(appURL: "linkedin://profile/heesung-kang-kinest1997", webURL: "https://www.linkedin.com/in/heesung-kang-kinest1997")
            case 2:
                setlinkAction(appURL: "instagram://user?username=kinest1997", webURL: "https://instagram.com/kinest1997")
            default:
                break
            }
        case 3:
            switch indexPath.row {
            case 0:
                Auth.auth().currentUser == nil ? logIn() : logOut()
            default:
                break
            }
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let accessorySwitch = UISwitch()
        cell.accessoryView?.isHidden = true
        
        switch indexPath.section {
        case 0:
            content.text = firstSectionNames[indexPath.row]
            cell.contentConfiguration = content
        
            return cell
        case 1:
            content.text = "Alarm Setting".localized
            cell.accessoryView?.isHidden = false
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
            cell.contentConfiguration = content
            return cell
        case 2:
            content.text = developerSectionNames[indexPath.row]
            cell.contentConfiguration = content
            return cell
        case 3:
            content.text = Auth.auth().currentUser == nil ? "LogIn".localized : "LogOut".localized
            cell.contentConfiguration = content
            return cell
        default:
            return cell
        }
    }
    
    @objc func switchAction(sender: UISwitch) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
    func setlinkAction(appURL: String, webURL: String){
        let appURL = URL(string: appURL)!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            let webURL = URL(string: webURL)!
            application.open(webURL)
        }
    }
    
    func logIn() {
        UserDefaults.standard.set(false, forKey: "firstLogin")
        self.show(LoginViewController(), sender: nil)
    }
    
    func logOut() {
        let alert = UIAlertController(title: "Do you want to log out?".localized, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes".localized, style: .default, handler: {[weak self] _ in
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let error {
                print(error)
            }
            FirebaseRecipe.shared.myRecipe = []
            FirebaseRecipe.shared.wishList = []
            self?.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "No".localized, style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
