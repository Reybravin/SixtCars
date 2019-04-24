//
//  UIImageView+Ext.swift
//  CarHire
//
//  Created by SS on 4/19/19.
//  Copyright © 2019 SergiySachuk. All rights reserved.
//

import UIKit
import MapKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension MKAnnotationView {

    func loadAndResizeImage(urlString: String) {

        self.image = nil
        
        //1. Try to get the image from cache
        let suffix = "\(Images.defaultCarImageSize.width)" + "x" + "\(Images.defaultCarImageSize.height)"
        
        let key = urlString + suffix
        
        if let imageFromCache = imageCache.object(forKey: key as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        //2. Download if not found in cache
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error as Any)
                return
            }
            
            DispatchQueue.main.async {
                if let data = data {
                    if let imageToCache = UIImage(data: data) {
                        let resizedImage = imageToCache.resizeImage(targetSize: Images.defaultCarImageSize)
                        imageCache.setObject(resizedImage, forKey: key as AnyObject)
                        self.image = resizedImage
                        return
                    }
                }
                self.image = UIImage(named: "ic_car_default")
            }
        }
        task.resume()
    }

}

