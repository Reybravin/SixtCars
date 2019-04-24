//
//  CarImageView.swift
//  CarHire
//
//  Created by SS on 4/24/19.
//  Copyright © 2019 SergiySachuk. All rights reserved.
//

import UIKit

class CarImageView : UIImageView {
    
    var imageUrlString : String?
    
    func loadAndResizeImage(urlString: String) {
        
        imageUrlString = urlString
        
        self.image = nil
        
        //1. Try to get the image from cache
        let key = UIImage.getKeyForCaching(title: urlString)
        
        if let imageFromCache = imageCache.object(forKey: key as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        //2. Download if not found in cache
        NetworkService.shared.loadImage(urlString: urlString) { (image) in
            if let image = image {
                let resizedImage = image.resizeImage(targetSize: Images.defaultCarImageSize)
                if self.imageUrlString == urlString {
                    DispatchQueue.main.async {
                        self.image = resizedImage
                    }
                }
                imageCache.setObject(resizedImage, forKey: key as AnyObject)
                return
            }
            DispatchQueue.main.async {
                self.image = Images.defaultCarImage?.resizeImage(targetSize: Images.defaultCarImageSize)
            }
        }
        
    }
    
    
    
    //    func loadAndResizeImage(urlString: String) {
    //
    //        imageUrlString = urlString
    //
    //        self.image = nil
    //
    //        //1. Try to get the image from cache
    //        let suffix = "\(Images.defaultCarImageSize.width)" + "x" + "\(Images.defaultCarImageSize.height)"
    //
    //        let key = urlString + suffix
    //
    //        if let imageFromCache = imageCache.object(forKey: key as AnyObject) as? UIImage {
    //            self.image = imageFromCache
    //            return
    //        }
    //
    //        //2. Download if not found in cache
    //        guard let url = URL(string: urlString) else {return}
    //
    //        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    //
    //            if error != nil {
    //                print(error as Any)
    //                return
    //            }
    //
    //            DispatchQueue.main.async {
    //                if let data = data {
    //                    if let imageToCache = UIImage(data: data) {
    //                        let resizedImage = imageToCache.resizeImage(targetSize: Images.defaultCarImageSize)
    //                        if self.imageUrlString == urlString {
    //                            self.image = resizedImage
    //                        }
    //                        imageCache.setObject(resizedImage, forKey: key as AnyObject)
    //                        return
    //                    }
    //                }
    //                self.image = Images.defaultCarImage?.resizeImage(targetSize: Images.defaultCarImageSize)
    //            }
    //        }
    //        task.resume()
    //    }
    
}
