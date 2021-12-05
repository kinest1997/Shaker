//
//  TodayCocktailCollectionViewController.swift
//  Cocktail
//
//  Created by 강희성 on 2021/12/05.
//

import UIKit
import SnapKit
import Kingfisher

class TodayCocktailCollectionViewController: UICollectionViewController {
    
    var youtubeData = [YouTubeVideo]()
    
    var wishListData: [Cocktail] = []

    var todayRecommendation: [Cocktail] = []
    
    let sectionName = ["추천 유튜브", "내 즐겨찾기", "오늘의 추천"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.register(TodayCocktailCollectionViewCell.self, forCellWithReuseIdentifier: "TodayCocktailCollectionViewCell")
        collectionView.register(TodayCocktailCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TodayCocktailCollectionViewHeader")
        collectionView.collectionViewLayout = collectionViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        wishListData = FirebaseRecipe.shared.wishList
        todayRecommendation = Array(FirebaseRecipe.shared.recipe.shuffled().dropFirst(10))
        collectionView.reloadData()
    }
}

extension TodayCocktailCollectionViewController {
    
    func collectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout {[weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            return self.createSection()
            
        }
    }
    
    func createSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalWidth(0.3))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeadSize = NSCollectionLayoutSize(widthDimension: .estimated(1), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeadSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return sectionHeader
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TodayCocktailCollectionViewHeader", for: indexPath) as? TodayCocktailCollectionViewHeader else { return UICollectionReusableView()}
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
            return 9
//            return youtubeData.count
        case 1:
            return wishListData.count
        case 2:
            return todayRecommendation.count
        default:
            return 0
        }
    }
    
    //셀 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCocktailCollectionViewCell", for: indexPath) as? TodayCocktailCollectionViewCell else { return UICollectionViewCell() }
        
        switch indexPath.section {
        case 0:
//            cell.mainImageView.kf.setImage(with: URL(string: youtubeData[indexPath.row].videoURL ?? ""), placeholder: UIImage(systemName: "heart"), options: nil, completionHandler: nil)
            return cell
            
        case 1:
//            cell.mainImageView.kf.setImage(with: URL(string: wishListData[indexPath.row].imageURL ?? ""), placeholder: UIImage(systemName: "heart"), options: nil, completionHandler: nil)
            return cell
            
        case 2:
//            cell.mainImageView.kf.setImage(with: URL(string: todayRecommendation[indexPath.row].imageURL ?? ""), placeholder: UIImage(systemName: "heart"), options: nil, completionHandler: nil)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
            
        case 0:
            ContentNetwork.shared.setlinkAction(appURL: "https://www.youtube.com/watch?v=tAI45usuk20", webURL: "https://www.youtube.com/watch?v=tAI45usuk20")
//            ContentNetwork.shared.setlinkAction(appURL: "https://www.youtube.com/watch?v=tAI45usuk20", webURL: youtubeData[indexPath.row].videoURL ?? "")
        case 1:
            let cocktailDetailViewController = CocktailDetailViewController()
            cocktailDetailViewController.setData(data: wishListData[indexPath.row])
            cocktailDetailViewController.modalTransitionStyle = .crossDissolve
            cocktailDetailViewController.modalPresentationStyle = .overCurrentContext
            self.present(cocktailDetailViewController, animated: true, completion: nil)
            
        case 2:
            let cocktailDetailViewController = CocktailDetailViewController()
            cocktailDetailViewController.setData(data: todayRecommendation[indexPath.row])
            cocktailDetailViewController.modalTransitionStyle = .crossDissolve
            cocktailDetailViewController.modalPresentationStyle = .overCurrentContext
            self.present(cocktailDetailViewController, animated: true, completion: nil)
        default:
            return
        }
    }
    
}
