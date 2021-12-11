//
//  LoginViewController.swift
//  Cocktail
//
//  Created by 강희성 on 2021/11/30.
//

import UIKit
import FirebaseAuth
import AuthenticationServices
import CryptoKit
import SnapKit
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    let userNotiCenter = UNUserNotificationCenter.current()
    
    let mainViewController = MainViewController()
    
    private var currentNonce: String?
    
    let appleLoginButton = UIButton()
    let justUseButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestAuthNoti()
        
        view.addSubview(appleLoginButton)
        view.addSubview(justUseButton)
        appleLoginButton.setTitle("애플 로그인", for: .normal)
        justUseButton.setTitle("그냥 사용하기", for: .normal)
        appleLoginButton.addAction(UIAction(handler: {[weak self] _ in
            self?.startSignInWithAppleFlow()
        }), for: .touchUpInside)
        
        justUseButton.addAction(UIAction(handler: {[weak self] _ in
            FirebaseRecipe.shared.getRecipe { data in
                FirebaseRecipe.shared.recipe = data
                UserDefaults.standard.set(false, forKey: "firstLaunch")
                let scenes = UIApplication.shared.connectedScenes
                let windowScene = scenes.first as? UIWindowScene
                let window = windowScene?.windows.first
                
                window?.rootViewController = self?.mainViewController
                
                self?.tabBarController?.tabBar.isHidden = false
//                self?.navigationController?.popToRootViewController(animated: true)
            }
        }), for: .touchUpInside)
        
        appleLoginButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        justUseButton.snp.makeConstraints {
            $0.top.equalTo(appleLoginButton.snp.bottom)
            $0.width.height.equalTo(appleLoginButton)
            $0.centerX.equalToSuperview()
        }
        
        view.backgroundColor = .darkGray
        appleLoginButton.backgroundColor = .blue
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func requestAuthNoti() {
        let notiAuthOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        userNotiCenter.requestAuthorization(options: notiAuthOptions) { (success, error) in
            if let error = error {
                print(#function, error)
            }
        }
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print ("Error Apple sign in: %@", error)
                    return
                }
                UserDefaults.standard.set(false, forKey: "firstLaunch")
                self.show(ColorChoiceViewController(), sender: nil)
            }
        }
    }
}

extension LoginViewController {
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
}

extension LoginViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
