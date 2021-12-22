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
    
    let uid = Auth.auth().currentUser?.uid
    
    let ref = Database.database().reference()
    
    let loadingView = LoadingView()
    
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
    
    var dataReciped: [Bool] = []
    
    let sectionName = ["주문 도와드릴까요?", "초보자 추천 가이드북",  "내 즐겨찾기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shaker"
        view.addSubview(collectionView)
        view.addSubview(loadingView)
        
        collectionView.backgroundColor = .white
        collectionView.register(TodayCocktailCollectionViewCell.self, forCellWithReuseIdentifier: "TodayCocktailCollectionViewCell")
        collectionView.register(TodayCocktailCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TodayCocktailCollectionViewHeader")
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
        if dataReciped.count == 3 {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.loadingView.isHidden = true
            }
            if UserDefaults.standard.object(forKey: "whatIHave") == nil {
                let alert = UIAlertController(title: "이런", message: "내술장에 술이 하나도없네요 \n 추가하러 가시겠어요?", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "네", style: .default, handler: {[weak self] _ in
                    self?.goToViewController(number: 2, viewController: MyDrinksViewController())
                }))
                alert.addAction(UIAlertAction(title: "다음에", style: .cancel, handler: nil))
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
                return self.createOrderAssistSection()
            case 1:
                return self.createYoutubeSection()
            case 2:
                return self.createWishListSection()
            default:
                return nil
            }
        }
    }
    
    func createOrderAssistSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 10, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .fractionalHeight(0.3))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .groupPaging
        
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func createWishListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 10, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.25))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .groupPaging
        
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func createYoutubeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 10, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.3))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeadSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeadSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return sectionHeader
    }
    
    //섹션 헤더설정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TodayCocktailCollectionViewHeader", for: indexPath) as? TodayCocktailCollectionViewHeader else { return UICollectionReusableView()}
            headerview.sectionTextLabel.text = sectionName[indexPath.section]
            return headerview
        } else {
            return UICollectionReusableView()
        }
    }
    
    //섹션의 갯수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    //섹션당 보여줄 셀의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return youtubeData.count
        case 2:
            return wishListData.count
        default:
            return 0
        }
    }
    
    //셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCocktailCollectionViewCell", for: indexPath) as? TodayCocktailCollectionViewCell else { return UICollectionViewCell() }
        cell.nameLabel.isHidden = false
        switch indexPath.section {
        case 0:
            cell.nameLabel.isHidden = true
            cell.mainImageView.image = UIImage(systemName: "signature")
            return cell
        case 1:
            cell.nameLabel.text = youtubeData[indexPath.row].videoName
            cell.mainImageView.kf.setImage(with: URL(string: "https://img.youtube.com/vi/\(youtubeData[indexPath.row].videoCode)/mqdefault.jpg" ), placeholder: UIImage(systemName: "heart"), options: nil, completionHandler: nil)
            return cell
        case 2:
            cell.nameLabel.text = wishListData[indexPath.row].name
            cell.mainImageView.kf.setImage(with: URL(string: wishListData[indexPath.row].imageURL), placeholder: UIImage(systemName: "heart"), options: nil, completionHandler: nil)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let colorChoiceViewController = ColorChoiceViewController()
            colorChoiceViewController.myFavor = false
            self.navigationController?.show(colorChoiceViewController, sender: nil)
            self.navigationController?.navigationBar.isHidden = false
        case 1:
            goToYoutube(videoCode: youtubeData[indexPath.row].videoCode)
        case 2:
            let cocktailDetailViewController = CocktailDetailViewController()
            cocktailDetailViewController.setData(data: wishListData[indexPath.row])
            self.navigationController?.show(cocktailDetailViewController, sender: nil)
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
}
