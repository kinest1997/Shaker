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

class TodayCocktailCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    enum Today: Int, CaseIterable {
        case firstSection
        case secondSection
        case thirdSection
        case fourthSection
        
        var titleText: NSMutableAttributedString {
            switch self {
            case .firstSection:
                let text = NSMutableAttributedString.addOrangeText(text: "바텐딩 초보자를 위한 가이드북", firstRange: NSRange(location: 7, length: 9), secondRange: NSRange(location: 8, length: 0), smallFont: UIFont.nexonFont(ofSize: 20, weight: .bold), orangeRange: NSRange(location: 0, length: 7))
                return text
            case .secondSection:
                let text = NSMutableAttributedString.addOrangeText(text: "내가 찜! 한 레시피", firstRange: NSRange(location: 0, length: 3), secondRange: NSRange(location: 5, length: 6), smallFont: UIFont.nexonFont(ofSize: 20, weight: .bold), orangeRange: NSRange(location: 3, length: 2))
                return text
            case .thirdSection:
                let text = NSMutableAttributedString.addOrangeText(text: "주문 도와드릴까요?", firstRange: NSRange(location: 2, length: 8), secondRange: NSRange(location: 3, length: 0), smallFont: UIFont.nexonFont(ofSize: 20, weight: .bold), orangeRange: NSRange(location: 0, length: 2))
                return text
            case .fourthSection:
                let text = NSMutableAttributedString.addOrangeText(text: "오늘의 한잔은?", firstRange: NSRange(location: 6, length: 2), secondRange: NSRange(), smallFont: UIFont.nexonFont(ofSize: 20, weight: .bold), orangeRange: NSRange(location: 0, length: 6))
                return text
            }
        }
        
        var explainText: NSMutableAttributedString {
            switch self {
            case .firstSection:
                let text = NSMutableAttributedString(string: "")
                return text
            case .secondSection:
                let text = NSMutableAttributedString.addOrangeText(text: "찜한 칵테일, 잊지 말고 다시 보아요", firstRange: NSRange(location: 1, length: 19), secondRange: NSRange(location: 10, length: 0), smallFont: UIFont.nexonFont(ofSize: 12, weight: .semibold), orangeRange: NSRange(location: 0, length: 1))
                return text
            case .thirdSection:
                let text = NSMutableAttributedString.addOrangeText(text: "시작하기 어려우신가요? 쉐이커가 레시피를 추천해드릴게요", firstRange: NSRange(location: 0, length: 13), secondRange: NSRange(location: 0, length: 0), smallFont: UIFont.nexonFont(ofSize: 12, weight: .semibold), orangeRange: NSRange(location: 13, length: 17))
                return text
            case .fourthSection:
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
        self.title = "SHAKER".localized
        view.addSubview(collectionView)
        view.addSubview(loadingView)
        navigationController?.navigationBar.tintColor = .mainGray
        collectionView.backgroundColor = .white
        collectionView.register(HashTagCell.self, forCellWithReuseIdentifier: "HashTagCell")
        collectionView.register(HelpOrderCell.self, forCellWithReuseIdentifier: "HelpOrderCell")
        collectionView.register(TodayCocktailCollectionViewCell.self, forCellWithReuseIdentifier: "TodayCocktailCollectionViewCell")
        collectionView.register(TodayCocktailCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TodayCocktailCollectionViewHeader")
        collectionView.register(TitleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TitleHeaderView")
        collectionView.register(NoTitleHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "NoTitleHeader")
        collectionView.collectionViewLayout = collectionViewLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        loadingView.explainLabel.text = "로딩중"
        
        if Auth.auth().currentUser == nil {
            getYoutubeContents {[weak self] data in
                FirebaseRecipe.shared.youTubeData = data
                self?.youtubeData = data
                self?.collectionView.reloadData()
                self?.loadingView.isHidden = true
            }
            
            getRecommendations {[weak self] data in
                self?.recommendationData = data
                self?.collectionView.reloadData()
            }
        } else {
            getMyRecipe {[weak self] data in
                FirebaseRecipe.shared.myRecipe = data
                self?.myRecipe = data
            }
            
            getWishList {[weak self] data in
                FirebaseRecipe.shared.wishList = data
                self?.wishListData = data
            }
            
            getYoutubeContents {[weak self] data in
                FirebaseRecipe.shared.youTubeData = data
                self?.youtubeData = data
                self?.collectionView.reloadData()
            }
            
            getRecommendations {[weak self] data in
                self?.recommendationData = data
                self?.collectionView.reloadData()
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
                let alert = UIAlertController(title: "반가워요", message: "내술장에 술이 하나도없네요 \n 추가하러 가시겠어요?", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "네", style: .default, handler: {[weak self] _ in
                    self?.goToViewController(number: 2, viewController: MyDrinksViewController())
                }))
                alert.addAction(UIAlertAction(title: "아니오", style: .cancel, handler: nil))
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
                return self.createOrderAssistSection()
            case 3:
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
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func createYoutubeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 10, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(0.2))
        
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
                guard let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NoTitleHeader", for: indexPath) as? NoTitleHeader else { return UICollectionReusableView()}
                return headerview
            case 3:
                basicHeader.explainLabel.attributedText = Today(rawValue: indexPath.section)?.explainText
                basicHeader.sectionTextLabel.attributedText = Today(rawValue: indexPath.section)?.titleText
                return basicHeader
            default:
                return UICollectionReusableView()
            }
        }
        return UICollectionReusableView()
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
            return wishListData.count
        case 2:
            return 1
        case 3:
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
            cell.mainImageView.kf.setImage(with: URL(string: wishListData[indexPath.row].imageURL), placeholder: UIImage(named: "\(wishListData[indexPath.row].glass.rawValue)" + "Empty"))
            return cell
        case 2:
            helpOrderCell.questionLabel.attributedText = Today(rawValue: indexPath.section)?.titleText
            helpOrderCell.explainLabel.attributedText = Today(rawValue: indexPath.section)?.explainText
            return helpOrderCell
        case 3:
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
            cocktailDetailViewController.setData(data: wishListData[indexPath.row])
            self.navigationController?.show(cocktailDetailViewController, sender: nil)
        case 2:
            let colorChoiceViewController = ColorChoiceViewController()
            colorChoiceViewController.myFavor = false
            self.navigationController?.show(colorChoiceViewController, sender: nil)
        case 3:
            let cocktailListViewController = CocktailListViewController()
            cocktailListViewController.lastRecipe = recommendationData[indexPath.row].list
            self.navigationController?.show(cocktailListViewController, sender: nil)
        default:
            return
        }
    }
    
    func goToYoutube(videoCode: String) {
        let alert = UIAlertController(title: "유튜브 앱으로 연결됩니다".localized, message: "이동하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "예", style: .default, handler: {_ in
            ContentNetwork.shared.setlinkAction(appURL: "https://www.youtube.com/watch?v=\(videoCode)", webURL: "https://www.youtube.com/watch?v=\(videoCode)")
        }))
        alert.addAction(UIAlertAction(title: "아니오", style: .cancel, handler: nil))
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
