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

class TodayCocktailCollectionViewController: UICollectionViewController {
    
    let loadingView = LoadingView()
    
    var youtubeData : [YouTubeVideo] = [] {
        didSet {
            youtubeData = oldValue
            dataReciped.append(true)
            if dataReciped.count == 3 {
                loadingView.dismiss(animated: true, completion: nil)
                collectionView.reloadData()
            }
        }
    }
    
    var myRecipe: [Cocktail] = [] {
        didSet {
            myRecipe = oldValue
            dataReciped.append(true)
            if dataReciped.count == 3 {
                loadingView.dismiss(animated: true, completion: nil)
                collectionView.reloadData()
            }

        }
    }
    
    var wishListData: [Cocktail] = [] {
        didSet {
            wishListData = oldValue
            dataReciped.append(true)
            if dataReciped.count == 3 {
                loadingView.dismiss(animated: true, completion: nil)
                collectionView.reloadData()
            }
        }
    }
    
    var dataReciped: [Bool] = []
    
    let sectionName = ["주문 도와드릴까요?", "초보자 추천 가이드북",  "내 즐겨찾기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "추천"
        collectionView.backgroundColor = .white
        collectionView.register(TodayCocktailCollectionViewCell.self, forCellWithReuseIdentifier: "TodayCocktailCollectionViewCell")
        collectionView.register(TodayCocktailCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TodayCocktailCollectionViewHeader")
        collectionView.collectionViewLayout = collectionViewLayout()
//        todayRecommendation = Array(FirebaseRecipe.shared.recipe.shuffled().prefix(10))
        
        collectionView.delegate = self
        
        loadingView.modalPresentationStyle = .overCurrentContext
        loadingView.modalTransitionStyle = .crossDissolve
        loadingView.explainLabel.text = "로딩중"
        self.present(loadingView, animated: true)
        
        FirebaseRecipe.shared.getYoutubeContents { data in
            FirebaseRecipe.shared.youTubeData = data
            self.youtubeData = data
        }
        
        FirebaseRecipe.shared.getMyRecipe { data in
            FirebaseRecipe.shared.myRecipe = data
            self.myRecipe = data
        }
        
        FirebaseRecipe.shared.getWishList { data in
            FirebaseRecipe.shared.wishList = data
            self.wishListData = data
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        wishListData = FirebaseRecipe.shared.wishList
        collectionView.reloadData()
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.3))
        
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
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TodayCocktailCollectionViewHeader", for: indexPath) as? TodayCocktailCollectionViewHeader else { return UICollectionReusableView()}
            if indexPath.section == 0 {
                headerview.seeTotalButton.isHidden = true
            } else {
                headerview.seeTotalButton.isHidden = false
            }
            headerview.sectionTextLabel.text = sectionName[indexPath.section]
            return headerview
        } else {
            return UICollectionReusableView()
        }
    }
    
    //섹션의 갯수
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    //섹션당 보여줄 셀의 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
}
