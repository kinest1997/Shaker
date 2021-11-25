import UIKit

func getRecipe(data: inout [Cocktail]) {
    
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

func getDirectoryPath() -> NSURL {
  // path is main document directory path
    let documentDirectoryPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString)
    let pathWithFolderName = documentDirectoryPath.appendingPathComponent("UserImage")
    guard let url = NSURL(string: pathWithFolderName) else { return NSURL() } // convert path in url
    return url
}

func setImage(name: String, data: Cocktail, imageView: UIImageView) {
    if data.myRecipe == true {
        let fileManager = FileManager.default
          
        let imagePath = (getDirectoryPath() as NSURL).appendingPathComponent(name + ".png")
        let urlString: String = imagePath!.absoluteString
          
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

    static func resize(image: UIImage)-> UIImage{
        let size = CGSize(width: 300, height: 300)

        let renderer = UIGraphicsImageRenderer(size: size)
        let resizedImage = renderer.image { context in
            image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
        
        return resizedImage
    }
}
