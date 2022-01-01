//
//  UIView.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/01.
//

import Foundation
import UIKit
extension UIView {
    
    //extension에서는 Stored Property(값을 넣는 프로퍼티)가
    //안되기 때문에, 이렇게 get과 set으로 넣어줘야한다.
     var cornerRadius : CGFloat{
      //외각선을 짤라주기
        get{
            return self.layer.cornerRadius
        }
        
        set{
            self.layer.cornerRadius = newValue
        }
        
    }
    
     var shadowRadius : CGFloat {
        //그림자의 퍼짐정도
        get{
            return self.layer.shadowRadius
        }
        
        
        set{
            self.layer.shadowRadius = newValue
        }
        
    }
    
     var shadowOpacity : Float {
        //그림자의 투명도 0 - 1 사이의 값을 가짐
        get{
            return self.layer.shadowOpacity
        }
        
        set{
            self.layer.shadowOpacity = newValue
        }
        
    }
    
     var shadowColor : UIColor {
        //그림자의 색
        get{
            if let shadowColor = self.layer.shadowColor {
                    return UIColor(cgColor: shadowColor)
            }
            return UIColor.clear
        }
        set{
            //그림자의 색이 지정됬을 경우
            self.layer.shadowOffset = CGSize(width: 0, height: 0)
            //shadowOffset은 빛의 위치를 지정해준다. 북쪽에 있으면 남쪽으로 그림지가 생기는 것
            self.layer.shadowColor = newValue.cgColor
            //그림자의 색을 지정
        }
        
    }
    
     var maskToBound : Bool{
        
        get{
            return self.layer.masksToBounds
        }
        
        set{
            self.layer.masksToBounds = newValue
        }
        
    }

    
}
