//
//  UIImage+Cache.swift
//  CarHire
//
//  Created by SS on 4/22/19.
//  Copyright © 2019 SergiySachuk. All rights reserved.
//

import UIKit

//let imageCache = NSCache<NSString, UIImage>()

extension UIImage {
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
    
    static func getKeyForCaching(title: String) -> String {
        let suffix = "\(Images.defaultCarImageSize.width)" + "x" + "\(Images.defaultCarImageSize.height)"
        return title + suffix
    }
    
}
