import UIKit

func getRecipe(data: inout [Cocktail]) {
    //    guard let documentURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.heesung.cocktail")?.appendingPathComponent("Cocktail.plist") else { return }
    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Cocktail.plist")
    
    guard let cocktailData = FileManager.default.contents(atPath: documentURL.path) else { return }
    
    do { print(documentURL)
        data = try PropertyListDecoder().decode([Cocktail].self, from: cocktailData).sorted {
            $0.name < $1.name
        }
        
    } catch let error{
        print("머선129",error.localizedDescription)
        print(String(describing: error))
    }
}

func getWidgetRecipe() -> [Cocktail] {
    guard let documentURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.heesung.cocktail")?.appendingPathComponent("Cocktail.plist"), let cocktailData = FileManager.default.contents(atPath: documentURL.path) else { return [] }
    do { print(documentURL)
        return try PropertyListDecoder().decode([Cocktail].self, from: cocktailData).sorted {
            $0.name < $1.name
        }
    } catch let error{
        print("머선129",error.localizedDescription)
        print(String(describing: error))
        return []
    }
}

//위젯의 데이터
func reloadwidgetData() {
    guard let widgetRecipeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.heesung.cocktail")?.appendingPathComponent("Cocktail.plist"), let widgetImageURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.heesung.cocktail")?.appendingPathComponent("UserImage") else { return }
    
    let documentPlistURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Cocktail.plist")
    
    let documentImageURL = getImageDirectoryPath()
    
    if FileManager.default.fileExists(atPath: widgetImageURL.path) {
        do {
            try FileManager.default.removeItem(atPath: widgetImageURL.path)
        } catch {
            print(error)
        }
        do {
            try FileManager.default.copyItem(at: documentImageURL, to: widgetImageURL)
            print("도큐먼트에서 앱그룹으로 복사함")
        } catch let error {
            print("ERROR", error.localizedDescription)
        }
    } else {
        do {
            try FileManager.default.copyItem(at: documentImageURL, to: widgetImageURL)
            print("도큐먼트에서 앱그룹으로 복사함")
        } catch let error {
            print("ERROR", error.localizedDescription)
        }
    }
    
    if FileManager.default.fileExists(atPath: widgetRecipeURL.path) {
        do {
            try FileManager.default.removeItem(atPath: widgetRecipeURL.path)
            print("지웠음")
        } catch {
            print(error)
        }
        do {
            try FileManager.default.copyItem(at: documentPlistURL, to: widgetRecipeURL)
            print("도큐먼트에서 앱그룹으로 복사함")
        } catch let error {
            print("ERROR", error.localizedDescription)
        }
    } else {
        do {
            try FileManager.default.copyItem(at: documentPlistURL, to: widgetRecipeURL)
            print("도큐먼트에서 앱그룹으로 복사함")
        } catch let error {
            print("ERROR", error.localizedDescription)
        }
    }
    
    print(widgetRecipeURL)
    
}


func getImageDirectoryPath() -> URL {
    
    let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    let url = directoryURL.appendingPathComponent("UserImage")
    
    return url
}

func setImage(name: String, data: Cocktail, imageView: UIImageView) {
    if data.myRecipe == true {
        let fileManager = FileManager.default
        
        let imagePath = getImageDirectoryPath().appendingPathComponent(name + ".png")
        let urlString: String = imagePath.path
        
        if fileManager.fileExists(atPath: urlString) {
            let GetImageFromDirectory = UIImage(contentsOfFile: urlString)
            imageView.image = GetImageFromDirectory
        }
        else {
            print("No Image Found")
        }
    }
}

struct ImageConverter{
    //이미지 크기 변환 해주는것
    static func resize(image: UIImage)-> UIImage{
        let size = CGSize(width: 300, height: 300)
        let renderer = UIGraphicsImageRenderer(size: size)
        let resizedImage = renderer.image { context in
            image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
        return resizedImage
    }
}
