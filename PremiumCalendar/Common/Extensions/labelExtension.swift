//
//  labelExtension.swift
//  PremiumCalendar
//
//  Created by David Diego Gomez on 20/1/19.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import UIKit



extension UILabel {
    var ancho : CGFloat {
        var rect: CGRect = self.frame //get frame of label
        rect.size = (self.text?.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: self.font.fontName , size: self.font.pointSize)!]))! //Calculate as per label font
        return rect.size.width
    }
    var alto : CGFloat {
        var rect: CGRect = self.frame //get frame of label
        rect.size = (self.text?.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: self.font.fontName , size: self.font.pointSize)!]))! //Calculate as per label font
        return rect.size.height
    }
    
}
