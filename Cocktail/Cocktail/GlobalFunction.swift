import UIKit

///도큐먼트에서 레시피를 불러오는 함수
func getRecipe() -> [Cocktail] {
    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Cocktail.plist")
    guard let cocktailData = FileManager.default.contents(atPath: documentURL.path) else { return [] }
    
    do {
        let data = try PropertyListDecoder().decode([Cocktail].self, from: cocktailData).sorted {
            $0.name < $1.name
        }
        return data
    } catch let error{
        print(String(describing: error))
        return []
    }
}

///그룹폴더에서 레시피를 불러오는 함수
func getWidgetRecipe() -> [Cocktail] {
    guard let documentURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.heesung.cocktail")?.appendingPathComponent("Cocktail.plist"),
            let cocktailData = FileManager.default.contents(atPath: documentURL.path) else { return [] }
    do {
        return try PropertyListDecoder().decode([Cocktail].self, from: cocktailData).sorted {
            $0.name < $1.name
        }
    } catch let error{
        print(String(describing: error))
        return []
    }
}

///레시피를 업데이트 하는 함수
func updateRecipe(originRecipe: Cocktail, modifiedRecipe: Cocktail, origin: [Cocktail] ) {
    var newRecipes = origin
    guard let number = origin.firstIndex(of: originRecipe) else { return }
    newRecipes.remove(at: number)
    newRecipes.insert(modifiedRecipe, at: number)
    upload(recipe: newRecipes)
}

///레시피를 도큐먼트에 업데이트 하는것
func upload(recipe: [Cocktail]) {
    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Cocktail.plist")
    do {
        let data = try PropertyListEncoder().encode(recipe)
        try data.write(to: documentURL)
    } catch let error {
        print("ERROR", error.localizedDescription)
    }
}

//위젯의 데이터
func reloadwidgetData() {
    guard let widgetRecipeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.heesung.cocktail")?.appendingPathComponent("Cocktail.plist"),
          let widgetImageURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.heesung.cocktail")?.appendingPathComponent("UserImage") else { return }
    
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
        } catch let error {
            print("ERROR", error.localizedDescription)
        }
    } else {
        do {
            try FileManager.default.copyItem(at: documentImageURL, to: widgetImageURL)
        } catch let error {
            print("ERROR", error.localizedDescription)
        }
    }
    
    if FileManager.default.fileExists(atPath: widgetRecipeURL.path) {
        do {
            try FileManager.default.removeItem(atPath: widgetRecipeURL.path)
        } catch {
            print(error)
        }
        do {
            try FileManager.default.copyItem(at: documentPlistURL, to: widgetRecipeURL)
        } catch let error {
            print("ERROR", error.localizedDescription)
        }
    } else {
        do {
            try FileManager.default.copyItem(at: documentPlistURL, to: widgetRecipeURL)
        } catch let error {
            print("ERROR", error.localizedDescription)
        }
    }
}

///이미지 폴더의 위치를 알려주는함수
func getImageDirectoryPath() -> URL {
    let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let url = directoryURL.appendingPathComponent("UserImage")
    return url
}

///이미지를 설정해주는 함수
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

///이미지 크기 변환 해주는것
struct ImageConverter{
    static func resize(image: UIImage)-> UIImage{
        let size = CGSize(width: 300, height: 300)
        let renderer = UIGraphicsImageRenderer(size: size)
        let resizedImage = renderer.image { context in
            image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
        return resizedImage
    }
}
