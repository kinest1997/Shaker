//
//  TodayCocktailCollectionViewController.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/05.
//

import UIKit
import SnapKit
import Kingfisher
import SwiftUI
import FirebaseDatabase
import FirebaseAuth
import AuthenticationServices

protocol TodayCocktailCollectionViewBindable {
    
}

class TodayCocktailCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    enum Today: Int, CaseIterable {
        case firstSection
        case secondSection
        case thirdSection
        case fourthSection
        case fifthSection
        
        var titleText: NSMutableAttributedString {
            switch self {
            case .firstSection:
                
                let originText = "Recommendation Video".localized
                if NSLocale.current.languageCode == "ko" {
                    let text = NSMutableAttributedString.addOrangeText(text: originText, firstRange: NSRange(location: 7, length: 9), secondRange: NSRange(location: 8, length: 0), smallFont: UIFont.nexonFont(ofSize: 20, weight: .bold), orangeRange: NSRange(location: 0, length: 7))
                    return text
                } else {
                    let text = NSMutableAttributedString.addOrangeText(text: originText, firstRange: NSRange(location: 0, length: 15), secondRange: NSRange(), smallFont: UIFont.nexonFont(ofSize: 20, weight: .bold), orangeRange: NSRange(location: 15, length: 5))
                    return text
                }
                
            case .secondSection:
                
                let originText = "Let's make my own Recipes".localized
                if NSLocale.current.languageCode == "ko" {
                    let text = NSMutableAttributedString.addOrangeText(text: originText, firstRange: NSRange(location: 0, length: 4), secondRange: NSRange(location: 8, length: 9), smallFont: UIFont.nexonFont(ofSize: 20, weight: .bold), orangeRange: NSRange(location: 4, length: 4))
                    return text
                } else {
                    let text = NSMutableAttributedString.addOrangeText(text: originText, firstRange: NSRange(location: 0, length: 18), secondRange: NSRange(), smallFont: UIFont.nexonFont(ofSize: 20, weight: .bold), orangeRange: NSRange(location: 18, length: 7))
                    return text
                }
            case .thirdSection:
                
                let originText = "My WishList".localized
                if NSLocale.current.languageCode == "ko" {
                    let text = NSMutableAttributedString.addOrangeText(text: originText, firstRange: NSRange(location: 0, length: 3), secondRange: NSRange(location: 5, length: 6), smallFont: UIFont.nexonFont(ofSize: 20, weight: .bold), orangeRange: NSRange(location: 3, length: 2))
                    return text
                } else {
                    let text = NSMutableAttributedString.addOrangeText(text: originText, firstRange: NSRange(location: 0, length: 3), secondRange: NSRange(), smallFont: UIFont.nexonFont(ofSize: 20, weight: .bold), orangeRange: NSRange(location: 3, length: 8))
                    return text
                }

            case .fourthSection:
                
                let originText = "May I help your Order?".localized
                if NSLocale.current.languageCode == "ko" {
                    let text = NSMutableAttributedString.addOrangeText(text: originText, firstRange: NSRange(location: 2, length: 8), secondRange: NSRange(location: 3, length: 0), smallFont: UIFont.nexonFont(ofSize: 20, weight: .bold), orangeRange: NSRange(location: 0, length: 2))
                    return text
                } else {
                    let text = NSMutableAttributedString.addOrangeText(text: originText, firstRange: NSRange(location: 0, length: 16), secondRange: NSRange(location: 20, length: 1), smallFont: UIFont.nexonFont(ofSize: 20, weight: .bold), orangeRange: NSRange(location: 16, length: 5))
                    return text
                }
                
            case .fifthSection:
                
                let originText = "Todays drink?".localized
                if NSLocale.current.languageCode == "ko" {
                    let text = NSMutableAttributedString.addOrangeText(text: originText, firstRange: NSRange(location: 6, length: 2), secondRange: NSRange(), smallFont: UIFont.nexonFont(ofSize: 20, weight: .bold), orangeRange: NSRange(location: 0, length: 6))
                    return text
                } else {
                    let text = NSMutableAttributedString.addOrangeText(text: originText, firstRange: NSRange(location: 12, length: 1), secondRange: NSRange(), smallFont: UIFont.nexonFont(ofSize: 20, weight: .bold), orangeRange: NSRange(location: 0, length: 12))
                    return text
                }
            }
        }
        
        var explainText: NSMutableAttributedString {
            switch self {
            case .firstSection:
                let text = NSMutableAttributedString(string: "")
                return text
            case .secondSection:
                
                let originText = "The Recipe that I made myself".localized
                if NSLocale.current.languageCode == "ko" {
                    let text = NSMutableAttributedString.addOrangeText(text: originText, firstRange: NSRange(location: 0, length: 10), secondRange: NSRange(location: 13, length: 1), smallFont: UIFont.nexonFont(ofSize: 12, weight: .semibold), orangeRange: NSRange(location: 10, length: 3))
                    return text
                } else {
                    let text = NSMutableAttributedString.addOrangeText(text: originText, firstRange: NSRange(location: 0, length: 4), secondRange: NSRange(location: 10, length: 19), smallFont: UIFont.nexonFont(ofSize: 12, weight: .semibold), orangeRange: NSRange(location: 4, length: 6))
                    return text
                }
                
            case .thirdSection:
                let originText = "Dibs. Don't forget to watch it again".localized
                if NSLocale.current.languageCode == "ko" {
                    let text = NSMutableAttributedString.addOrangeText(text: originText, firstRange: NSRange(location: 1, length: 19), secondRange: NSRange(), smallFont: UIFont.nexonFont(ofSize: 12, weight: .semibold), orangeRange: NSRange(location: 0, length: 1))
                    return text
                } else {
                    let text = NSMutableAttributedString.addOrangeText(text: originText, firstRange: NSRange(location: 4, length: 32), secondRange: NSRange(), smallFont: UIFont.nexonFont(ofSize: 12, weight: .semibold), orangeRange: NSRange(location: 0, length: 4))
                    return text
                }
                
            case .fourthSection:
                let originText = "Hard to order? I can help you".localized
                if NSLocale.current.languageCode == "ko" {
                    let text = NSMutableAttributedString.addOrangeText(text: originText, firstRange: NSRange(location: 0, length: 13), secondRange: NSRange(), smallFont: UIFont.nexonFont(ofSize: 12, weight: .semibold), orangeRange: NSRange(location: 13, length: 17))
                    return text
                } else {
                    let text = NSMutableAttributedString.addOrangeText(text: originText, firstRange: NSRange(location: 0, length: 15), secondRange: NSRange(), smallFont: UIFont.nexonFont(ofSize: 12, weight: .semibold), orangeRange: NSRange(location: 15, length: 14))
                    return text
                }
                
            case .fifthSection:
                let text = NSMutableAttributedString(string: "")
                return text
            }
        }
    }
    
    let uid = Auth.auth().currentUser?.uid
    
    let ref = Database.database().reference()
    
    let loadingView = LoadingView()
    
    let topTitleView = UIView()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var youtubeData: [YouTubeVideo] = [] {
        didSet {
            canIDismissLoading()
        }
    }
    
    var myRecipe: [Cocktail] = [] {
        didSet {
            canIDismissLoading()
        }
    }
    
    var wishListData: [Cocktail] = [] {
        didSet {
            canIDismissLoading()
        }
    }
    
    var recommendationData: [Recommendation] = [] {
        didSet {
            canIDismissLoading()
        }
    }
    
    var dataReciped: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home".localized
        view.addSubview(collectionView)
        view.addSubview(loadingView)
        
        collectionView.backgroundColor = .white
        collectionView.register(HashTagCell.self, forCellWithReuseIdentifier: "HashTagCell")
        collectionView.register(HelpOrderCell.self, forCellWithReuseIdentifier: "HelpOrderCell")
        collectionView.register(TodayCocktailCollectionViewCell.self, forCellWithReuseIdentifier: "TodayCocktailCollectionViewCell")
        collectionView.register(TodayCocktailCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TodayCocktailCollectionViewHeader")
        collectionView.register(TitleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TitleHeaderView")
        collectionView.register(NoTitleHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "NoTitleHeader")
        collectionView.register(ButtonFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ButtonFooterView")
        
        collectionView.collectionViewLayout = collectionViewLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        loadingView.explainLabel.text = "Loading".localized
        
        getYoutubeContents {[weak self] data in
            FirebaseRecipe.shared.youTubeData = data.shuffled()
            self?.youtubeData = data.shuffled()
            self?.collectionView.reloadData()
            self?.loadingView.isHidden = true
        }
        
        getRecommendations {[weak self] data in
            self?.recommendationData = data
            self?.collectionView.reloadData()
        }
        
        if let _ = Auth.auth().currentUser {
            getMyRecipe {[weak self] data in
                FirebaseRecipe.shared.myRecipe = data.shuffled()
                self?.myRecipe = data
            }
            
            getWishList {[weak self] data in
                FirebaseRecipe.shared.wishList = data
                self?.wishListData = data
            }
        }
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        self.wishListData = FirebaseRecipe.shared.wishList
        self.myRecipe = FirebaseRecipe.shared.myRecipe

        self.collectionView.reloadData()
    }
    
    func canIDismissLoading() {
        dataReciped.append(true)
        if dataReciped.count == 4 {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.loadingView.isHidden = true
            }
            if UserDefaults.standard.object(forKey: "whatIHave") == nil {
                let alert = UIAlertController(title: "Hello".localized, message: "I don't have any alcohol in MyDrinks\nDo you want to go add it?".localized, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes".localized, style: .default, handler: {[weak self] _ in
                    self?.goToViewController(number: 2, viewController: MyDrinksViewController())
                }))
                alert.addAction(UIAlertAction(title: "No".localized, style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension TodayCocktailCollectionViewController {
    
    func collectionViewLayout() -> UICollectionViewLayout {
        
        return UICollectionViewCompositionalLayout {[weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            switch sectionNumber {
            case 0:
                return self.createYoutubeSection()
            case 1:
                return self.createWishListSection()
            case 2:
                return self.createWishListSection()
            case 3:
                return self.createOrderAssistSection()
            case 4:
                return self.createRecommendationSection()
                
            default:
                return nil
            }
        }
    }
    
    func createRecommendationSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 10, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(130))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let sectionHeader = createSectionHeader(height: 70)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func createOrderAssistSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 10, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .fractionalHeight(0.2))
            
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .groupPaging
        
        let sectionHeader = createSectionHeader(height: 30)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func createWishListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 10, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.15))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        let sectionHeader = createSectionHeader(height: 70)
        let sectionFooter = createSectionFooter(height: 50)
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        return section
    }
    
    func createYoutubeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 10, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalWidth(0.4))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        let sectionHeader = createSectionHeader(height: 140)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func createSectionHeader(height: CGFloat) -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeadSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeadSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return sectionHeader
    }
    
    func createSectionFooter(height: CGFloat) -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeadSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeadSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        return sectionHeader
    }
    
    //섹션 헤더설정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            guard let basicHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TodayCocktailCollectionViewHeader", for: indexPath) as? TodayCocktailCollectionViewHeader else { return UICollectionReusableView()}
            switch indexPath.section {
            case 0:
                guard let titleHeaderview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TitleHeaderView", for: indexPath) as? TitleHeaderView else { return UICollectionReusableView() }
                titleHeaderview.sectionTextLabel.attributedText = Today(rawValue: indexPath.section)?.titleText
                return titleHeaderview
            case 1:
                basicHeader.explainLabel.attributedText = Today(rawValue: indexPath.section)?.explainText
                basicHeader.sectionTextLabel.attributedText = Today(rawValue: indexPath.section)?.titleText
                return basicHeader
            case 2:
                basicHeader.explainLabel.attributedText = Today(rawValue: indexPath.section)?.explainText
                basicHeader.sectionTextLabel.attributedText = Today(rawValue: indexPath.section)?.titleText
                return basicHeader
            case 3:
                guard let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NoTitleHeader", for: indexPath) as? NoTitleHeader else { return UICollectionReusableView()}
                return headerview
            case 4:
                basicHeader.explainLabel.attributedText = Today(rawValue: indexPath.section)?.explainText
                basicHeader.sectionTextLabel.attributedText = Today(rawValue: indexPath.section)?.titleText
                return basicHeader
                
            default:
                return UICollectionReusableView()
            }
        } else if kind == UICollectionView.elementKindSectionFooter {

            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ButtonFooterView", for: indexPath) as? ButtonFooterView
            else { return UICollectionReusableView()}
            switch indexPath.section {
            case 1:
                footerView.bottomButton.removeTarget(self, action: #selector(showWishList), for: .touchUpInside)
                footerView.bottomButton.addTarget(self, action: #selector(showMyList), for: .touchUpInside)
                return footerView
            case 2:
                footerView.bottomButton.removeTarget(self, action: #selector(showMyList), for: .touchUpInside)
                footerView.bottomButton.addTarget(self, action: #selector(showWishList), for: .touchUpInside)
                return footerView
            default:
                return UICollectionReusableView()
            }
        }
        return UICollectionReusableView()
    }
    
    @objc func showWishList() {
        if Auth.auth().currentUser?.uid == nil {
            self.pleaseLoginAlert()
        } else {
            self.show(WishListCocktailListViewController(), sender: nil)
            self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    @objc func showMyList() {
        if Auth.auth().currentUser?.uid == nil {
            self.pleaseLoginAlert()
        } else {
            self.show(MyOwnCocktailRecipeViewController(), sender: nil)
            self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    //섹션의 갯수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Today.allCases.count
    }
    
    //섹션당 보여줄 셀의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return youtubeData.count
        case 1:
            return myRecipe.count
        case 2:
            return wishListData.count
        case 3:
            return 1
        case 4:
            return recommendationData.count
        default:
            return 0
        }
    }
    
    //셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCocktailCollectionViewCell", for: indexPath) as? TodayCocktailCollectionViewCell,
              let helpOrderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HelpOrderCell", for: indexPath) as? HelpOrderCell,
              let hashTagCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HashTagCell", for: indexPath) as? HashTagCell
        else { return UICollectionViewCell() }
        
        switch indexPath.section {
        case 0:
            cell.mainImageView.kf.setImage(with: URL(string: "https://img.youtube.com/vi/\(youtubeData[indexPath.row].videoCode)/mqdefault.jpg" ), options: nil, completionHandler: nil)
            return cell
        case 1:
            cell.mainImageView.kf.setImage(with: URL(string: myRecipe[indexPath.row].imageURL), placeholder: UIImage(named: "\(myRecipe[indexPath.row].glass.rawValue)" + "Empty"))
            return cell
        case 2:
            cell.mainImageView.kf.setImage(with: URL(string: wishListData[indexPath.row].imageURL), placeholder: UIImage(named: "\(wishListData[indexPath.row].glass.rawValue)" + "Empty"))
            return cell
        case 3:
            helpOrderCell.questionLabel.attributedText = Today(rawValue: indexPath.section)?.titleText
            helpOrderCell.explainLabel.attributedText = Today(rawValue: indexPath.section)?.explainText
            return helpOrderCell
        case 4:
            hashTagCell.textLabel.text = "#\(recommendationData[indexPath.row].hashTagName)"
            return hashTagCell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            goToYoutube(videoCode: youtubeData[indexPath.row].videoCode)
        case 1:
            self.navigationController?.navigationBar.isHidden = false
            let cocktailDetailViewController = CocktailDetailViewController()
            cocktailDetailViewController.setData(data: myRecipe[indexPath.row])
            self.navigationController?.show(cocktailDetailViewController, sender: nil)
        case 2:
            self.navigationController?.navigationBar.isHidden = false
            let cocktailDetailViewController = CocktailDetailViewController()
            cocktailDetailViewController.setData(data: wishListData[indexPath.row])
            self.navigationController?.show(cocktailDetailViewController, sender: nil)
        case 3:
            let colorChoiceViewController = ColorChoiceViewController()
            colorChoiceViewController.myFavor = false
            self.navigationController?.show(colorChoiceViewController, sender: nil)
        case 4:
            let cocktailListViewController = CocktailListViewController()
            cocktailListViewController.lastRecipe = recommendationData[indexPath.row].spitRecipe(data: FirebaseRecipe.shared.recipe)
            cocktailListViewController.title = recommendationData[indexPath.row].hashTagName
            self.navigationController?.show(cocktailListViewController, sender: nil)
            
        default:
            return
        }
    }
    
    func goToYoutube(videoCode: String) {
        let alert = UIAlertController(title: "It's connected through YouTube".localized, message: "Will you continue?".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes".localized, style: .default, handler: {_ in
            ContentNetwork.shared.setlinkAction(appURL: "https://www.youtube.com/watch?v=\(videoCode)", webURL: "https://www.youtube.com/watch?v=\(videoCode)")
        }))
        alert.addAction(UIAlertAction(title: "No".localized, style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func getMyRecipe(completion: @escaping ([Cocktail]) -> (Void)) {
        guard let uid = uid else { return }
        ref.child("users").child(uid).child("MyRecipes").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [[String: Any]],
                  let data = try? JSONSerialization.data(withJSONObject: value, options: []),
                  let cocktailList = try? JSONDecoder().decode([Cocktail].self, from: data) else {
                      completion([Cocktail]())
                      return }
            let myRecipes = cocktailList.filter { $0.myRecipe == true }
            completion(myRecipes)
        }
    }
    
    func getWishList(completion: @escaping ([Cocktail]) -> (Void)) {
        guard let uid = uid else { return }
        ref.child("users").child(uid).child("WishList").observe( .value) { snapshot in
            guard let value = snapshot.value as? [[String: Any]],
                  let data = try? JSONSerialization.data(withJSONObject: value, options: []),
                  let cocktailList = try? JSONDecoder().decode([Cocktail].self, from: data) else {
                      completion([Cocktail]())
                      return }
            let myRecipes = cocktailList.filter { $0.wishList == true }
            completion(myRecipes)
        }
    }
    
    func getYoutubeContents(completion: @escaping ([YouTubeVideo]) -> (Void)) {
        ref.child("Youtube").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [[String: Any]],
                  let data = try? JSONSerialization.data(withJSONObject: value, options: []),
                  let youTubeVideoList = try? JSONDecoder().decode([YouTubeVideo].self, from: data) else {
                      completion([YouTubeVideo]())
                      return }
            completion(youTubeVideoList)
        }
    }
    
    func getRecommendations(completion: @escaping ([Recommendation]) -> (Void)) {
        ref.child("CocktailRecommendation").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [[String: Any]],
                  let data = try? JSONSerialization.data(withJSONObject: value, options: []),
                  let cocktailList = try? JSONDecoder().decode([Recommendation].self, from: data) else {
                      completion([Recommendation]())
                      return }
            completion(cocktailList)
        }
    }
}
