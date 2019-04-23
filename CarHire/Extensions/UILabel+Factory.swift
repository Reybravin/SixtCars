//
//  UILabel+Factory.swift
//  CarHire
//
//  Created by SS on 4/23/19.
//  Copyright © 2019 SergiySachuk. All rights reserved.
//

import UIKit

extension UILabel {
    
    struct Factory {
        
        static func makeForTitle() -> UILabel {
            let label = UILabel()
            label.minimumScaleFactor = 0.75
            label.adjustsFontSizeToFitWidth = true
            label.font = Fonts.titleFont
            label.textColor = Colors.titleColor
            return label
        }
        
        static func makeForSubtitle() -> UILabel {
            let label = UILabel()
            label.minimumScaleFactor = 0.75
            label.adjustsFontSizeToFitWidth = true
            label.font = Fonts.subtitleFont
            label.textColor = Colors.subtitleColor
            return label
        }
        
    }
    
}
