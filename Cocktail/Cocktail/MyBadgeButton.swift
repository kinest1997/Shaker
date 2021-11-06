import UIKit
import SnapKit

class BadgeButton: UIButton {
    
    private var badgeLabel = UILabel()
    
    var nameLabel = UILabel()
    
    private var buttonImage = UIImageView()
    
    //또 작성하기귀찮아서 그냥 함수 바꿈
    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        self.addSubview(buttonImage)
        buttonImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
        }
        buttonImage.image = image
    }
    
    //버튼의 이름 설정
    override func setTitle(_ title: String?, for state: UIControl.State) {
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            if buttonImage.image == nil {
                $0.top.equalToSuperview()
            } else {
                $0.top.equalTo(buttonImage.snp.bottom)
            }
        }
        nameLabel.text = title
        nameLabel.sizeToFit()
        nameLabel.textAlignment = .center
        nameLabel.isHidden = title != nil ? false : true
        nameLabel.backgroundColor = buttonBackgroundColor
        nameLabel.font = buttonFont
        nameLabel.textColor = UIColor.systemMint
    }
    
    override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        nameLabel.textColor = color
    }
    
    var buttonBackgroundColor = UIColor.white {
        didSet {
            nameLabel.backgroundColor = buttonBackgroundColor
        }
    }
    
    var buttonFont = UIFont.systemFont(ofSize: 20, weight: .bold) {
        didSet {
            nameLabel.font = buttonFont
        }
    }
    
    //버튼의 뱃지 설정
    var badge: String? {
        didSet {
            if badge == "0" {
                badgeBackgroundColor = .systemGray
                addBadgeToButon(badge: badge)
            } else {
                addBadgeToButon(badge: badge)
            }
        }
    }
    
    public var badgeBackgroundColor = UIColor.red {
        didSet {
            badgeLabel.backgroundColor = badgeBackgroundColor
        }
    }
    
    public var badgeTextColor = UIColor.white {
        didSet {
            badgeLabel.textColor = badgeTextColor
        }
    }
    
    public var badgeFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            badgeLabel.font = badgeFont
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBadgeToButon(badge: nil)
    }
    
    func addBadgeToButon(badge: String?) {
        badgeLabel.text = badge
        badgeLabel.textColor = badgeTextColor
        badgeLabel.backgroundColor = badgeBackgroundColor
        badgeLabel.font = badgeFont
        badgeLabel.sizeToFit()
        badgeLabel.textAlignment = .center
        
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.layer.masksToBounds = true
        badgeLabel.isHidden = badge != nil ? false : true
        self.addSubview(badgeLabel)
        
        badgeLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //위처럼만 해도 되는것인가? 아래처럼 굳이 deinit 할때 버튼의 뱃지를 없애주면 다시 화면 들어갔을때 저절로 새값을 받아오려나? 일단 해보고나서 
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self.addBadgeToButon(badge: nil)
//        fatalError("init(coder:) has not been implemented")
//    }
}
